import 'package:delivery_practice01/restaurant/model/model_restaurant_detail.dart';
import 'package:dio/dio.dart' hide Headers;
import 'package:retrofit/retrofit.dart';

part 'repository_restaurant.g.dart';

@RestApi()
abstract class RepositoryRestaurant {
  factory RepositoryRestaurant(Dio dio, {String baseUrl}) = _RepositoryRestaurant;

  //@GET('/')
  //paginate();

  @GET('/{id}')
  @Headers({
    'authorization':'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VybmFtZSI6InRlc3RAY29kZWZhY3RvcnkuYWkiLCJzdWIiOiJmNTViMzJkMi00ZDY4LTRjMWUtYTNjYS1kYTlkN2QwZDkyZTUiLCJ0eXBlIjoiYWNjZXNzIiwiaWF0IjoxNjc2NjQ3NzA1LCJleHAiOjE2NzY2NDgwMDV9.UNlMqtUnkjxM27O8g4E_1T0bfSbIsKDAq7wA0rLuKcE'
  })
  Future<ModelRestaurantDetail> getRestaurantDetail({
    @Path() required String id,
    //@Path('id') required String sid,
  });
}
