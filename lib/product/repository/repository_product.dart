import 'package:delivery_practice01/common/const/data.dart';
import 'package:delivery_practice01/common/dio/dio.dart';
import 'package:delivery_practice01/common/model/model_cursor_pagination.dart';
import 'package:delivery_practice01/common/model/model_cursor_pagination_params.dart';
import 'package:delivery_practice01/common/repository/repository_base_pagination.dart';
import 'package:delivery_practice01/product/model/model_product.dart';
import 'package:dio/dio.dart' hide Headers;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:retrofit/retrofit.dart';

part 'repository_product.g.dart';

final providerRepositoryProduct = Provider<RepositoryProduct>((ref) {
  final dio = ref.watch(providerDio);

  return RepositoryProduct(dio, baseUrl: 'http://$ip/product');
});

@RestApi()
abstract class RepositoryProduct implements IRepositoryBasePagination<ModelProduct> {
  factory RepositoryProduct(Dio dio, {String baseUrl}) = _RepositoryProduct;

  @override
  @GET('/')
  @Headers({Token_key_Access: 'true'})
  Future<CursorPagination<ModelProduct>> paginate({
    @Queries() CursorPaginationParams? cursorPaginationParams = const CursorPaginationParams(),
  });
}
