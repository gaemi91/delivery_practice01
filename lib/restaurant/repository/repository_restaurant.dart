import 'package:delivery_practice01/common/const/data.dart';
import 'package:delivery_practice01/common/dio/dio.dart';
import 'package:delivery_practice01/common/model/model_cursor_pagination.dart';
import 'package:delivery_practice01/common/model/model_cursor_pagination_more.dart';
import 'package:delivery_practice01/restaurant/model/model_restaurant.dart';
import 'package:delivery_practice01/restaurant/model/model_restaurant_detail.dart';
import 'package:dio/dio.dart' hide Headers;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:retrofit/retrofit.dart';

part 'repository_restaurant.g.dart';

final providerRepositoryRestaurant = Provider<RepositoryRestaurant>((ref) {
  final dio = ref.watch(providerDio);

  return RepositoryRestaurant(dio, baseUrl: 'http://$ip/restaurant');
});

@RestApi()
abstract class RepositoryRestaurant {
  factory RepositoryRestaurant(Dio dio, {String baseUrl}) = _RepositoryRestaurant;

  @GET('/')
  @Headers({Token_Key_Access: 'true'})
  Future<CursorPagination<ModelRestaurant>> paginate({
    @Queries() CursorPaginationMore? cursorPaginationMore = const CursorPaginationMore(),
  });

  @GET('/{id}')
  @Headers({Token_Key_Access: 'true'})
  Future<ModelRestaurantDetail> getRestaurantDetail({
    @Path() required String id,
    //@Path('id') required String sid,
  });
}
