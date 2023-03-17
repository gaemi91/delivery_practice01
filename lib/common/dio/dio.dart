import 'package:delivery_practice01/common/const/data.dart';
import 'package:delivery_practice01/common/secure_storage/secure_storage.dart';
import 'package:delivery_practice01/main.dart';
import 'package:delivery_practice01/user/provider/provider_auth.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final providerDio = Provider<Dio>((ref) {
  final dio = Dio();
  final storage = ref.watch(providerSecureStorage);

  dio.interceptors.add(CustomInterceptor(storage: storage, ref: ref));

  return dio;
});

class CustomInterceptor extends Interceptor {
  final FlutterSecureStorage storage;
  final Ref ref;

  CustomInterceptor({required this.storage, required this.ref});

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    logger.i('[REQ] [${options.method}] [${options.uri}]');

    if (options.headers[Token_key_Access] == 'true') {
      options.headers.remove(Token_key_Access);

      final accessToken = await storage.read(key: Token_key_Access);

      options.headers.addAll({authorization: 'Bearer $accessToken'});
    }

    if (options.headers[Token_key_Refresh] == 'true') {
      options.headers.remove(Token_key_Refresh);

      final refreshToken = await storage.read(key: Token_key_Refresh);

      options.headers.addAll({authorization: 'Bearer $refreshToken'});
    }
    return super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    logger.i('[RES] [${response.requestOptions.method}] [${response.requestOptions.uri}]');

    super.onResponse(response, handler);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) async {
    logger.e('[ERR] [${err.requestOptions.method}] [${err.requestOptions.uri}]');

    final refreshToken = await storage.read(key: Token_key_Refresh);

    if (refreshToken == null) {
      return;
    }

    final isStatus401 = err.response?.statusCode == 401;
    final isPathRefresh = err.requestOptions.path == '/auth/token';

    if (isStatus401 && !isPathRefresh) {
      try {
        final dio = Dio();

        final resp = await dio.post(
          'http://$ip/auth/token',
          options: Options(headers: {authorization: 'Bearer $refreshToken'}),
        );

        final accessToken = resp.data[Token_key_Access];
        final options = err.requestOptions;

        options.headers.addAll({authorization: 'Bearer $accessToken'});
        await storage.write(key: Token_key_Access, value: accessToken);

        final response = await dio.fetch(options);

        return handler.resolve(response);
      } on DioError catch (e) {
        ref.read(changeNotifierProviderAuth.notifier).logOut();

        return handler.reject(e);
      }
    }
    return handler.reject(err);
  }
}
