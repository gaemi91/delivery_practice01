import 'package:delivery_practice01/restaurant/model/model_restaurant_detail.dart';
import 'package:dio/dio.dart' hide Headers;
import 'package:retrofit/retrofit.dart';

part 'repository_restaurant.g.dart';

@RestApi()
abstract class RepositoryRestaurant {
  factory RepositoryRestaurant(Dio dio, {required String baseUrl}) = _RepositoryRestaurant;

  //@GET('/')
  //paginate();

  @GET('/{id}')
  @Headers({
    'authorization':'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VybmFtZSI6InRlc3RAY29kZWZhY3RvcnkuYWkiLCJzdWIiOiJmNTViMzJkMi00ZDY4LTRjMWUtYTNjYS1kYTlkN2QwZDkyZTUiLCJ0eXBlIjoiYWNjZXNzIiwiaWF0IjoxNjc2NzExMTUzLCJleHAiOjE2NzY3MTE0NTN9.ts64DgOnkB1KCq1Gfn4IaIIs5WP8jc6lSwt08e-wvMc'
  })
  Future<ModelRestaurantDetail> getRestaurantDetail({
    @Path('id') required String sid,
  });
}

/*
Future<List> paginate() async {
  final accessToken = await storage.read(key: Token_key_Access);

  final resp = await dio.get(
    'http://$ip/restaurant',
    options: Options(
      headers: {'authorization': 'Bearer $accessToken'},
    ),
  );

  return resp.data['data'];
}

final listItems = ModelRestaurantCard.fromJson(snapshot.data![index]);*/
