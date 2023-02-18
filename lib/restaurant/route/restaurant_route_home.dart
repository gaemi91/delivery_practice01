import 'package:delivery_practice01/common/const/data.dart';
import 'package:delivery_practice01/restaurant/component/restaurant_card.dart';
import 'package:delivery_practice01/restaurant/model/model_restaurant_card.dart';
import 'package:delivery_practice01/restaurant/route/restaurant_route_detail.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class RestaurantRouteHome extends StatelessWidget {
  const RestaurantRouteHome({Key? key}) : super(key: key);

  Future<List> paginate() async {
    final accessToken = await storage.read(key: Token_key_Access);

    final resp = await dio.get(
      'http://$ip/restaurant',
      options: Options(
        headers: {'authorization': 'Bearer $accessToken'},
      ),
    );

    return resp.data['data'];
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List>(
        future: paginate(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          return ListView.separated(
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context, index) {
              final listItems = ModelRestaurantCard.fromJson(snapshot.data![index]);

              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: InkWell(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (_) => RestaurantRouteDetail(id: listItems.id),
                    ));
                  },
                  child: RestaurantCard.fromModel(model: listItems),
                ),
              );
            },
            separatorBuilder: (context, index) {
              return const SizedBox(height: 20.0);
            },
            itemCount: snapshot.data!.length,
          );
        });
  }
}