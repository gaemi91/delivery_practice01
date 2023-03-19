import 'package:delivery_practice01/product/model/model_product.dart';
import 'package:delivery_practice01/user/model/model_basket.dart';
import 'package:delivery_practice01/user/model/model_basket_body.dart';
import 'package:delivery_practice01/user/repository/repository_user_me.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:collection/collection.dart';

final providerBasket = StateNotifierProvider<ProviderBasket, List<ModelBasket>>((ref) {
  final repository = ref.watch(providerRepositoryUserMe);

  return ProviderBasket(repositoryUserMe: repository);
});

class ProviderBasket extends StateNotifier<List<ModelBasket>> {
  final RepositoryUserMe repositoryUserMe;

  ProviderBasket({required this.repositoryUserMe}) : super([]);

  Future<void> patchBasket() async {
    await repositoryUserMe.patchBasket(
      body: ModelBasketBody(
          basket: state
              .map((e) => ModelBasketBodyRequest(
                    productId: e.product.id,
                    count: e.count,
                  ))
              .toList()),
    );
  }

  Future<void> addToBasket({required ModelProduct modelProduct}) async {
    // 1) 장바구니에 해당 상품이 없는 경우
    //    추가하기
    // 2) 장바구니에 해당 상품이 있는 경우
    //    count +1 하기

    final exists = state.firstWhereOrNull((e) => e.product.id == modelProduct.id) != null;

    if (exists) {
      state = state
          .map((e) => e.product.id == modelProduct.id
              ? e.copyWith(
                  count: e.count + 1,
                )
              : e)
          .toList();
    } else {
      state = [
        ...state,
        ModelBasket(product: modelProduct, count: 1),
      ];
    }
    await patchBasket();
  }

  Future<void> removeFromBasket({
    required ModelProduct modelProduct,
    bool isDelete = false,
  }) async {
    // 1) 장바구니에 해당 상품이 있는 경우
    //    1) count가 1인 경우, 장바구니에서 제거
    //    2) count가 2 이상인 경우, count -1
    // 2) 장바구니에 해당 상품이 없는 경우
    //    바로 반환
    final exists = state.firstWhereOrNull((e) => e.product.id == modelProduct.id) != null;

    if (!exists) {
      return;
    }

    final existingProduct = state.firstWhere((e) => e.product.id == modelProduct.id);

    if (existingProduct.count == 1 || isDelete) {
      state = state.where((e) => e.product.id != modelProduct.id).toList();
    } else {
      state = state
          .map((e) => e.product.id == modelProduct.id
              ? e.copyWith(
                  count: e.count - 1,
                )
              : e)
          .toList();
    }
    await patchBasket();
  }
}
