import 'package:delivery_practice01/common/layout/layout_default.dart';
import 'package:delivery_practice01/product/component/product_card.dart';
import 'package:delivery_practice01/restaurant/component/restaurant_card.dart';
import 'package:delivery_practice01/restaurant/model/model_restaurant_detail.dart';
import 'package:delivery_practice01/restaurant/provider/provider_restaurant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:skeletons/skeletons.dart';

class RestaurantRouteDetail extends ConsumerStatefulWidget {
  final String id;

  const RestaurantRouteDetail({
    required this.id,
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState<RestaurantRouteDetail> createState() => _RestaurantRouteDetailState();
}

class _RestaurantRouteDetailState extends ConsumerState<RestaurantRouteDetail> {
  @override
  void initState() {
    super.initState();
    ref.read(stateNotifierProviderRestaurant.notifier).getRestaurantDetail(id: widget.id);
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(providerRestaurantDetail(widget.id));

    if (state == null) {
      return const LayoutDefault(child: Center(child: CircularProgressIndicator()));
    }

    return LayoutDefault(
      title: state.name,
      child: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverToBoxAdapter(
            child: RestaurantCard.fromModel(
              model: state,
              isDetail: true,
            ),
          ),
          if (state is! ModelRestaurantDetail) renderLoading(),
          if (state is ModelRestaurantDetail)
            const SliverPadding(
              padding: EdgeInsets.symmetric(horizontal: 10.0),
              sliver: SliverToBoxAdapter(
                child: Text(
                  '메뉴',
                  style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w500),
                ),
              ),
            ),
          if (state is ModelRestaurantDetail)
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate(
                  childCount: state.products.length,
                  (context, index) {
                    final products = state.products[index];
                    return Padding(
                      padding: const EdgeInsets.only(top: 10.0),
                      child: ProductCard.fromModel(model: products),
                    );
                  },
                ),
              ),
            )
        ],
      ),
    );
  }

  SliverPadding renderLoading() {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
      sliver: SliverList(
        delegate: SliverChildListDelegate([
          ...List.generate(
              4,
              (index) => const SkeletonLine(
                    style: SkeletonLineStyle(
                      padding: EdgeInsets.only(bottom: 10.0),
                    ),
                  )),
          ...List.generate(
              5,
              (index) => SkeletonListTile(
                    hasSubtitle: true,
                    padding: const EdgeInsets.only(bottom: 10.0),
                  ))
        ]),
      ),
    );
  }
}
