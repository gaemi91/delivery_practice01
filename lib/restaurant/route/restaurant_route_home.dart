import 'package:delivery_practice01/common/model/model_cursor_pagination.dart';
import 'package:delivery_practice01/restaurant/component/restaurant_card.dart';
import 'package:delivery_practice01/restaurant/model/model_restaurant.dart';
import 'package:delivery_practice01/restaurant/repository/repository_restaurant.dart';
import 'package:delivery_practice01/restaurant/route/restaurant_route_detail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RestaurantRouteHome extends ConsumerStatefulWidget {
  const RestaurantRouteHome({Key? key}) : super(key: key);

  @override
  ConsumerState<RestaurantRouteHome> createState() => _RestaurantRouteHomeState();
}

class _RestaurantRouteHomeState extends ConsumerState<RestaurantRouteHome> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<CursorPagination<ModelRestaurant>>(
        future: ref.watch(providerRepositoryRestaurant).paginate(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          return ListView.separated(
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context, index) {
              final modelRestaurant = snapshot.data!.data[index];

              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: InkWell(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(builder: (_) {
                      return RestaurantRouteDetail(
                        id: modelRestaurant.id,
                      );
                    }));
                  },
                  child: RestaurantCard.fromModel(model: modelRestaurant),
                ),
              );
            },
            separatorBuilder: (context, index) => const SizedBox(height: 10),
            itemCount: snapshot.data!.data.length,
          );
        });
  }
}
