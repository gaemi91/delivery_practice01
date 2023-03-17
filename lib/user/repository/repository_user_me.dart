import 'package:delivery_practice01/common/const/data.dart';
import 'package:delivery_practice01/common/dio/dio.dart';
import 'package:delivery_practice01/user/model/model_user.dart';
import 'package:dio/dio.dart' hide Headers;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:retrofit/retrofit.dart';

part 'repository_user_me.g.dart';

final providerRepositoryUserMe = Provider<RepositoryUserMe>((ref) {
  final dio = ref.watch(providerDio);

  return RepositoryUserMe(dio, baseUrl: 'http://$ip/user/me');
});

@RestApi()
abstract class RepositoryUserMe {
  factory RepositoryUserMe(Dio dio, {String baseUrl}) = _RepositoryUserMe;

  @GET('/')
  @Headers({Token_key_Access: 'true'})
  Future<ModelUser> getUserMe();
}
