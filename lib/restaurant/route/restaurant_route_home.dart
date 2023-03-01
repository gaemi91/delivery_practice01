import 'package:delivery_practice01/common/const/data.dart';
import 'package:delivery_practice01/dio/dio.dart';
import 'package:delivery_practice01/restaurant/component/restaurant_card.dart';
import 'package:delivery_practice01/restaurant/model/model_restaurant.dart';
import 'package:delivery_practice01/restaurant/repository/repository_restaurant.dart';
import 'package:delivery_practice01/restaurant/route/restaurant_route_detail.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class RestaurantRouteHome extends StatelessWidget {
  const RestaurantRouteHome({Key? key}) : super(key: key);

  Future<List<ModelRestaurant>> paginateRestaurant() async {
    dio.interceptors.add(CustomInterceptor(storage: storage));

    final repository = await RepositoryRestaurant(dio, baseUrl: 'http://$ip/restaurant').paginate();

    return repository.data;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<ModelRestaurant>>(
        future: paginateRestaurant(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          return ListView.separated(
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context, index) {
              final listItems = snapshot.data![index];

              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: InkWell(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(builder: (_) {
                      return RestaurantRouteDetail(
                        id: listItems.id,
                      );
                    }));
                  },
                  child: RestaurantCard.fromModel(model: listItems),
                ),
              );
            },
            separatorBuilder: (context, index) => const SizedBox(height: 10),
            itemCount: snapshot.data!.length,
          );
        });
  }
}
