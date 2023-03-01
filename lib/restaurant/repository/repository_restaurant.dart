import 'package:delivery_practice01/common/const/data.dart';
import 'package:delivery_practice01/common/model/model_cursor_pagination.dart';
import 'package:delivery_practice01/restaurant/model/model_restaurant.dart';
import 'package:delivery_practice01/restaurant/model/model_restaurant_detail.dart';
import 'package:dio/dio.dart' hide Headers;
import 'package:retrofit/retrofit.dart';

part 'repository_restaurant.g.dart';

@RestApi()
abstract class RepositoryRestaurant {
  factory RepositoryRestaurant(Dio dio, {String baseUrl}) = _RepositoryRestaurant;

  @GET('/')
  @Headers({Token_key_Access: 'true'})
  Future<ModelCursorPagination<ModelRestaurant>> paginate();

  @GET('/{id}')
  @Headers({Token_key_Access: 'true'})
  Future<ModelRestaurantDetail> getRestaurantDetail({@Path() required String id});
}
