import 'package:delivery_practice01/common/const/colors.dart';
import 'package:delivery_practice01/common/layout/layout_default.dart';
import 'package:delivery_practice01/common/utils/utils_data.dart';
import 'package:delivery_practice01/restaurant/component/restaurant_product_card.dart';
import 'package:delivery_practice01/user/provider/provider_basket.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RestaurantRouteBasket extends ConsumerWidget {
  static String get routeName => 'basket';

  const RestaurantRouteBasket({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final stateBasket = ref.watch(providerBasket);

    if (stateBasket.isEmpty) {
      return const LayoutDefault(
        title: '장바구니',
        child: Center(
          child: Text('장바구니가 비었습니다.'),
        ),
      );
    }

    final priceBasket = UtilsData.f.format(stateBasket.fold<int>(0, (p, n) => p + n.product.price * n.count));
    final deliveryFee = UtilsData.f.format(stateBasket.first.product.restaurant.deliveryFee);
    final priceTotal = UtilsData.f.format(
      stateBasket.fold<int>(0, (p, n) => p + n.product.price * n.count) +
          stateBasket.first.product.restaurant.deliveryFee,
    );

    return LayoutDefault(
      title: '장바구니',
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Column(
          children: [
            Expanded(
              child: ListView.separated(
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) {
                  final modelProduct = stateBasket[index].product;

                  return RestaurantProductCard.fromModelProduct(
                    model: modelProduct,
                    onAddTap: () {
                      ref.read(providerBasket.notifier).addToBasket(modelProduct: modelProduct);
                    },
                    onRemoveTap: () {
                      ref.read(providerBasket.notifier).removeFromBasket(modelProduct: modelProduct);
                    },
                  );
                },
                separatorBuilder: (context, index) => const Divider(),
                itemCount: stateBasket.length,
              ),
            ),
            const SizedBox(height: 5.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('장바구니 금액', style: TextStyle(color: Color_Text, fontWeight: FontWeight.w500)),
                Text('￦${priceBasket.toString()}',
                    style: const TextStyle(color: Color_Text, fontWeight: FontWeight.w500)),
              ],
            ),
            const SizedBox(height: 5.0),
            if (stateBasket.isNotEmpty)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('배달비', style: TextStyle(color: Color_Text, fontWeight: FontWeight.w500)),
                  Text('￦${deliveryFee.toString()}',
                      style: const TextStyle(color: Color_Text, fontWeight: FontWeight.w500)),
                ],
              ),
            const SizedBox(height: 5.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('총액', style: TextStyle(fontWeight: FontWeight.w500)),
                Text('￦${priceTotal.toString()}', style: const TextStyle(fontWeight: FontWeight.w500)),
              ],
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(backgroundColor: Color_Main),
                child: const Text('결제하기'),
              ),
            )
          ],
        ),
      ),
    );
  }
}
