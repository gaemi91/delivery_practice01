import 'package:delivery_practice01/common/dio/dio.dart';
import 'package:delivery_practice01/common/model/model_cursor_pagination.dart';
import 'package:delivery_practice01/common/model/model_cursor_pagination_params.dart';
import 'package:delivery_practice01/common/repository/repository_base_pagination.dart';
import 'package:delivery_practice01/rating/model/model_rating.dart';
import 'package:dio/dio.dart' hide Headers;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:retrofit/retrofit.dart';
import 'package:delivery_practice01/common/const/data.dart';

part 'repository_restaurant_rating.g.dart';

final providerRepositoryRestaurantRating = Provider.family<RepositoryRestaurantRating, String>((ref, id) {
  final dio = ref.watch(providerDio);

  final repositoryRestaurantRating = RepositoryRestaurantRating(
    dio,
    baseUrl: 'http://$ip/restaurant/$id/rating',
  );

  return repositoryRestaurantRating;
});

@RestApi()
abstract class RepositoryRestaurantRating implements IRepositoryBasePagination<ModelRating>{
  factory RepositoryRestaurantRating(Dio dio, {String baseUrl}) = _RepositoryRestaurantRating;

  @override
  @GET('/')
  @Headers({Token_key_Access: 'true'})
  Future<CursorPagination<ModelRating>> paginate({
    @Queries() CursorPaginationParams? cursorPaginationParams = const CursorPaginationParams(),
  });
}
