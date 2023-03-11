import 'package:delivery_practice01/common/const/data.dart';
import 'package:delivery_practice01/common/dio/dio.dart';
import 'package:delivery_practice01/common/model/model_cursor_pagination.dart';
import 'package:delivery_practice01/common/model/model_cursor_pagination_params.dart';
import 'package:delivery_practice01/common/repository/repository_base_pagination.dart';
import 'package:delivery_practice01/restaurant/model/model_restaurant.dart';
import 'package:delivery_practice01/restaurant/model/model_restaurant_detail.dart';
import 'package:dio/dio.dart' hide Headers;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:retrofit/retrofit.dart';

part 'repository_restaurant.g.dart';

final providerRepositoryRestaurant = Provider<RepositoryRestaurant>((ref) {
  final dio = ref.watch(providerDio);

  final repositoryRestaurant = RepositoryRestaurant(dio, baseUrl: 'http://$ip/restaurant');

  return repositoryRestaurant;
});

@RestApi()
abstract class RepositoryRestaurant implements IRepositoryBasePagination<ModelRestaurant>{
  factory RepositoryRestaurant(Dio dio, {String baseUrl}) = _RepositoryRestaurant;

  @override
  @GET('/')
  @Headers({Token_key_Access: 'true'})
  Future<CursorPagination<ModelRestaurant>> paginate({
    @Queries() CursorPaginationParams? cursorPaginationParams = const CursorPaginationParams(),
  });

  @GET('/{id}')
  @Headers({Token_key_Access: 'true'})
  Future<ModelRestaurantDetail> getRestaurantDetail({@Path() required String id});
}
