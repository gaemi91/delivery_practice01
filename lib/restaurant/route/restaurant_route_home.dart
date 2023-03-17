import 'package:delivery_practice01/common/route/common_route_pagination.dart';
import 'package:delivery_practice01/restaurant/component/restaurant_card.dart';
import 'package:delivery_practice01/restaurant/model/model_restaurant.dart';
import 'package:delivery_practice01/restaurant/provider/provider_restaurant.dart';
import 'package:delivery_practice01/restaurant/route/restaurant_route_detail.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class RestaurantRouteHome extends StatelessWidget {
  const RestaurantRouteHome({super.key});

  @override
  Widget build(BuildContext context) {
    return CommonRoutePagination<ModelRestaurant>(
      provider: stateNotifierProviderRestaurant,
      paginationWidgetBuilder: <ModelRestaurant>(_, index, model) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: InkWell(
            onTap: () {
              context.goNamed(
                RestaurantRouteDetail.routeName,
                params: {'rid': model.id},
              );
            },
            child: RestaurantCard.fromModel(model: model),
          ),
        );
      },
    );
  }
}
