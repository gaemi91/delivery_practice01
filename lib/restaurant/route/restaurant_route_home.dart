import 'package:delivery_practice01/common/const/data.dart';
import 'package:delivery_practice01/restaurant/component/restaurant_card.dart';
import 'package:delivery_practice01/restaurant/model/model_restaurant.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class RestaurantRouteHome extends StatelessWidget {
  const RestaurantRouteHome({Key? key}) : super(key: key);

  Future<List> paginateRestaurant() async {
    final accessToken = await storage.read(key: Token_key_Access);

    final resp = await dio.get(
      'http://$ip/restaurant',
      options: Options(headers: {'authorization': 'Bearer $accessToken'}),
    );

    return resp.data['data'];
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List>(
        future: paginateRestaurant(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          return ListView.separated(
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context, index) {
              final listItems = snapshot.data![index];
              final ModelRestaurant modelRestaurant = ModelRestaurant(
                id: listItems['id'],
                name: listItems['name'],
                thumbUrl: listItems['thumbUrl'],
                tags: List<String>.from(listItems['tags']),
                priceRange: PriceRange.values.firstWhere((e) => e.name == listItems['priceRange']),
                ratings: listItems['ratings'],
                ratingsCount: listItems['ratingsCount'],
                deliveryTime: listItems['deliveryTime'],
                deliveryFee: listItems['deliveryFee'],
              );

              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: RestaurantCard(
                  image: Image.network('http://$ip${modelRestaurant.thumbUrl}'),
                  name: modelRestaurant.name,
                  tags: modelRestaurant.tags,
                  ratings: modelRestaurant.ratings,
                  ratingsCount: modelRestaurant.ratingsCount,
                  deliveryTime: modelRestaurant.deliveryTime,
                  deliveryFee: modelRestaurant.deliveryFee,
                ),
              );
            },
            separatorBuilder: (context, index) => const SizedBox(height: 10),
            itemCount: snapshot.data!.length,
          );
        });
  }
}
