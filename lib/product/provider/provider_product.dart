import 'package:delivery_practice01/common/model/model_cursor_pagination.dart';
import 'package:delivery_practice01/common/provider/provider_pagination.dart';
import 'package:delivery_practice01/product/model/model_product.dart';
import 'package:delivery_practice01/product/repository/repository_product.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final stateNotifierProviderProduct = StateNotifierProvider<StateNotifierProduct, CursorPaginationBase>((ref) {
  final repository = ref.watch(providerRepositoryProduct);

  return StateNotifierProduct(repository: repository);
});

class StateNotifierProduct extends ProviderPagination<ModelProduct, RepositoryProduct> {
  StateNotifierProduct({required super.repository});
}
