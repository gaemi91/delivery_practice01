import 'package:delivery_practice01/common/const/data.dart';
import 'package:delivery_practice01/restaurant/component/restaurant_card.dart';
import 'package:delivery_practice01/restaurant/model/model_restaurant_card.dart';
import 'package:delivery_practice01/restaurant/route/restaurant_route_detail.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class RestaurantRouteMain extends StatelessWidget {
  const RestaurantRouteMain({Key? key}) : super(key: key);

  Future<List> getRestaurantCard() async {
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
        future: getRestaurantCard(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: ListView.separated(
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index) {
                final ModelRestaurantCard modelRestaurantCard =
                    ModelRestaurantCard.fromJson(json: snapshot.data![index]);

                return InkWell(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (_) => RestaurantRouteDetail(id: modelRestaurantCard.id),
                    ));
                  },
                  child: RestaurantCard.fromModel(
                    model: modelRestaurantCard,
                  ),
                );
              },
              separatorBuilder: (context, index) {
                return const SizedBox(height: 20.0);
              },
              itemCount: 10,
            ),
          );
        });
  }
}
