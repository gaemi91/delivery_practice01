import 'package:delivery_practice01/common/const/colors.dart';
import 'package:delivery_practice01/common/utils/utils_data.dart';
import 'package:delivery_practice01/product/model/model_product.dart';
import 'package:delivery_practice01/restaurant/model/model_restaurant_detail_product.dart';
import 'package:delivery_practice01/user/provider/provider_basket.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RestaurantProductCard extends ConsumerWidget {
  final String id;
  final String name;
  final String imgUrl;
  final String detail;
  final int price;
  final GestureTapCallback? onAddTap;
  final GestureTapCallback? onRemoveTap;

  const RestaurantProductCard({
    required this.id,
    required this.name,
    required this.imgUrl,
    required this.detail,
    required this.price,
    this.onAddTap,
    this.onRemoveTap,
    Key? key,
  }) : super(key: key);

  factory RestaurantProductCard.fromModelProduct({
    required ModelProduct model,
    GestureTapCallback? onAddTap,
    GestureTapCallback? onRemoveTap,
  }) {
    return RestaurantProductCard(
      id: model.id,
      name: model.name,
      imgUrl: model.imgUrl,
      detail: model.detail,
      price: model.price,
      onAddTap: onAddTap,
      onRemoveTap: onRemoveTap,
    );
  }

  factory RestaurantProductCard.fromModelRestaurantDetailProduct({
    required ModelRestaurantDetailProduct model,
    GestureTapCallback? onAddTap,
    GestureTapCallback? onRemoveTap,
  }) {
    return RestaurantProductCard(
      id: model.id,
      name: model.name,
      imgUrl: model.imgUrl,
      detail: model.detail,
      price: model.price,
      onAddTap: onAddTap,
      onRemoveTap: onRemoveTap,
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final stateBasket = ref.watch(providerBasket);

    return Column(
      children: [
        IntrinsicHeight(
          child: Row(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(8.0)),
                child: Image.network(imgUrl, fit: BoxFit.cover, width: 110, height: 110),
              ),
              const SizedBox(width: 10.0),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      name,
                      style: const TextStyle(fontSize: 18.0, fontWeight: FontWeight.w500),
                    ),
                    Text(
                      detail,
                      style: const TextStyle(color: Color_Text),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text('₩${UtilsData.f.format(price)}',
                        style: const TextStyle(color: Color_Main), textAlign: TextAlign.right),
                  ],
                ),
              )
            ],
          ),
        ),
        const SizedBox(height: 10.0),
        if (onAddTap != null && onRemoveTap != null)
          _Footer(
            price: (stateBasket.firstWhere((e) => e.product.id == id).product.price *
                    stateBasket.firstWhere((e) => e.product.id == id).count)
                .toString(),
            count: stateBasket.firstWhere((e) => e.product.id == id).count,
            onAddTap: onAddTap,
            onRemoveTap: onRemoveTap,
          ),
        const SizedBox(height: 5.0),
      ],
    );
  }
}

class _Footer extends StatelessWidget {
  final String price;
  final int count;
  final GestureTapCallback? onAddTap;
  final GestureTapCallback? onRemoveTap;

  const _Footer({
    required this.price,
    required this.count,
    required this.onAddTap,
    required this.onRemoveTap,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
            child: Text(
          '총액 ￦${UtilsData.f.format(int.parse(price))}',
          style: const TextStyle(color: Color_Main, fontWeight: FontWeight.w500),
        )),
        Row(
          children: [
            renderIcon(iconData: Icons.remove, onTap: onRemoveTap),
            const SizedBox(width: 10.0),
            Text(
              count.toString(),
              style: const TextStyle(color: Color_Main, fontSize: 14.0, fontWeight: FontWeight.w500),
            ),
            const SizedBox(width: 10.0),
            renderIcon(iconData: Icons.add, onTap: onAddTap),
          ],
        )
      ],
    );
  }

  Widget renderIcon({
    required IconData iconData,
    required GestureTapCallback? onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Color_Main, width: 1.0),
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Icon(iconData, color: Color_Main),
      ),
    );
  }
}
