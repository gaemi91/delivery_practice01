import 'package:delivery_practice01/common/const/data.dart';
import 'package:delivery_practice01/common/layout/layout_default.dart';
import 'package:delivery_practice01/product/component/product_card.dart';
import 'package:delivery_practice01/restaurant/component/restaurant_card.dart';
import 'package:delivery_practice01/restaurant/model/model_restaurant_detail.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class RestaurantRouteDetail extends StatelessWidget {
  final String id;

  const RestaurantRouteDetail({
    required this.id,
    Key? key,
  }) : super(key: key);

  Future<Map<String, dynamic>> getRestaurantDetail() async {
    final accessToken = await storage.read(key: Token_key_Access);

    final resp = await dio.get(
      'http://$ip/restaurant/$id',
      options: Options(headers: {'authorization': 'Bearer $accessToken'}),
    );

    return resp.data;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, dynamic>>(
        future: getRestaurantDetail(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Scaffold(body: Center(child: CircularProgressIndicator()));
          }

          final items = ModelRestaurantDetail.fromJson(json: snapshot.data!);

          return LayoutDefault(
            title: items.name,
            child: CustomScrollView(
              physics: const BouncingScrollPhysics(),
              slivers: [
                SliverToBoxAdapter(
                  child: RestaurantCard.fromModel(
                    model: items,
                    isDetail: true,
                  ),
                ),
                const SliverPadding(
                  padding: EdgeInsets.symmetric(horizontal: 10.0),
                  sliver: SliverToBoxAdapter(
                    child: Text(
                      '메뉴',
                      style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
                SliverPadding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  sliver: SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        final products = items.products[index];
                        return Padding(
                          padding: const EdgeInsets.only(top: 10.0),
                          child: ProductCard.fromModel(model: products),
                        );
                      },
                      childCount: items.products.length,
                    ),
                  ),
                )
              ],
            ),
          );
        });
  }
}
