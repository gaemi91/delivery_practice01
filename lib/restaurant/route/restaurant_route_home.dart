import 'package:delivery_practice01/restaurant/component/restaurant_card.dart';
import 'package:flutter/material.dart';

class RestaurantRouteHome extends StatelessWidget {
  const RestaurantRouteHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RestaurantCard(
      image: Image.asset('asset/img/food/ddeok_bok_gi.jpg'),
      name: '불타는 떡볶이',
      tags: ['매콤','달콤','떡볶이'],
      ratings: 4.52,
      ratingsCount: 100,
      deliveryTime: 15,
      deliveryFee: 2000,

    );
  }
}
