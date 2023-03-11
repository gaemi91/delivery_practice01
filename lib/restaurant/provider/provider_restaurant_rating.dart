import 'package:delivery_practice01/common/model/model_cursor_pagination.dart';
import 'package:delivery_practice01/common/provider/provider_pagination.dart';
import 'package:delivery_practice01/rating/model/model_rating.dart';
import 'package:delivery_practice01/restaurant/repository/repository_restaurant_rating.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final stateNotifierProviderRestaurantRating =
    StateNotifierProvider.family<StateNotifierRestaurantRating, CursorPaginationBase, String>((ref, id) {
  final repository = ref.watch(providerRepositoryRestaurantRating(id));

  return StateNotifierRestaurantRating(repository: repository);
});

class StateNotifierRestaurantRating extends ProviderPagination<ModelRating, RepositoryRestaurantRating> {
  StateNotifierRestaurantRating({required super.repository});
}
