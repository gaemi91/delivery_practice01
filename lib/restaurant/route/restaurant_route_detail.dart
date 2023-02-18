import 'package:delivery_practice01/common/const/data.dart';
import 'package:delivery_practice01/common/layout/layout_default.dart';
import 'package:delivery_practice01/product/component/product_card.dart';
import 'package:delivery_practice01/restaurant/component/restaurant_card.dart';
import 'package:delivery_practice01/restaurant/model/model_restaurant_detail.dart';
import 'package:delivery_practice01/restaurant/repository/repository_restaurant.dart';
import 'package:flutter/material.dart';

class RestaurantRouteDetail extends StatelessWidget {
  final String id;

  const RestaurantRouteDetail({
    required this.id,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Future<ModelRestaurantDetail> getRestaurantDetail() async{
      final repository = RepositoryRestaurant(dio, baseUrl: 'http://$ip/restaurant');

      return repository.getRestaurantDetail(sid: id);
    }

    return FutureBuilder<ModelRestaurantDetail>(
        future: getRestaurantDetail(),
        builder: (context, AsyncSnapshot<ModelRestaurantDetail> snapshot) {
          if (snapshot.hasError) {
            return Text('${snapshot.error}');
          }
          if (!snapshot.hasData) {
            return const Scaffold(body: Center(child: CircularProgressIndicator()));
          }

          final ModelRestaurantDetail model = snapshot.data!;

          return LayoutDefault(
            title: model.name,
            body: CustomScrollView(
              physics: const BouncingScrollPhysics(),
              slivers: [
                SliverToBoxAdapter(
                  child: RestaurantCard.fromModel(model: model, isDetail: true),
                ),
                const SliverPadding(
                  padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                  sliver: SliverToBoxAdapter(
                    child: Text('메뉴', style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w600)),
                  ),
                ),
                SliverPadding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  sliver: SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: ProductCard.fromModel(model: model.products[index]),
                        );
                      },
                      childCount: model.products.length,
                    ),
                  ),
                )
              ],
            ),
          );
        });
  }
}
