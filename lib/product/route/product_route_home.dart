import 'package:delivery_practice01/common/route/common_route_pagination.dart';
import 'package:delivery_practice01/product/model/model_product.dart';
import 'package:delivery_practice01/product/provider/provider_product.dart';
import 'package:delivery_practice01/restaurant/component/restaurant_product_card.dart';
import 'package:delivery_practice01/restaurant/route/restaurant_route_detail.dart';
import 'package:flutter/material.dart';

class ProductRouteHome extends StatelessWidget {
  const ProductRouteHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CommonRoutePagination<ModelProduct>(
      provider: stateNotifierProviderProduct,
      paginationWidgetBuilder: <ModelProduct>(context, index, model) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: InkWell(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (_) => RestaurantRouteDetail(id: model.restaurant.id),
              ));
            },
            child: RestaurantProductCard.fromModelProduct(model: model),
          ),
        );
      },
    );
  }
}
