import 'package:delivery_practice01/common/layout/layout_default.dart';
import 'package:delivery_practice01/product/component/product_card.dart';
import 'package:delivery_practice01/restaurant/component/restaurant_card.dart';
import 'package:flutter/material.dart';

class RestaurantRouteDetail extends StatelessWidget {
  final String id;

  const RestaurantRouteDetail({
    required this.id,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutDefault(
      title: '불타는 떡볶이',
      child: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverToBoxAdapter(
            child: RestaurantCard(
              image: Image.asset('asset/img/food/ddeok_bok_gi.jpg'),
              name: '불타는 떡볶이',
              tags: ['떡볶이', '치즈', '매운맛'],
              ratings: 4.51,
              ratingsCount: 100,
              deliveryTime: 15,
              deliveryFee: 1000,
              isDetail: true,
              detail: '기본적으로 아주아주 달콤짭짤 하비다요 하하하하하하하하하',
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
                  return Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: ProductCard(),
                  );
                },
                childCount: 10,
              ),
            ),
          )
        ],
      ),
    );
  }
}
