import 'package:delivery_practice01/common/layout/layout_default.dart';
import 'package:delivery_practice01/common/model/model_cursor_pagination.dart';
import 'package:delivery_practice01/common/utils/utils_pagination.dart';
import 'package:delivery_practice01/restaurant/component/restaurant_product_card.dart';
import 'package:delivery_practice01/rating/component/rating_card.dart';
import 'package:delivery_practice01/rating/model/model_rating.dart';
import 'package:delivery_practice01/restaurant/component/restaurant_card.dart';
import 'package:delivery_practice01/restaurant/model/model_restaurant_detail.dart';
import 'package:delivery_practice01/restaurant/provider/provider_restaurant.dart';
import 'package:delivery_practice01/restaurant/provider/provider_restaurant_rating.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:skeletons/skeletons.dart';

class RestaurantRouteDetail extends ConsumerStatefulWidget {
  static String get routeName => 'restaurantDetail';

  final String id;

  const RestaurantRouteDetail({
    required this.id,
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState<RestaurantRouteDetail> createState() => _RestaurantRouteDetailState();
}

class _RestaurantRouteDetailState extends ConsumerState<RestaurantRouteDetail> {
  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    ref.read(stateNotifierProviderRestaurant.notifier).getRestaurantDetail(id: widget.id);
    scrollController.addListener(scrollControllerListener);
  }

  @override
  void dispose() {
    scrollController.removeListener(scrollControllerListener);
    scrollController.dispose();

    super.dispose();
  }

  void scrollControllerListener() {
    UtilsPagination.paginate(
      scrollController: scrollController,
      providerPagination: ref.read(stateNotifierProviderRestaurantRating(widget.id).notifier),
    );
  }

  @override
  Widget build(BuildContext context) {
    final stateRestaurant = ref.watch(providerRestaurantDetail(widget.id));
    final stateRating = ref.watch(stateNotifierProviderRestaurantRating(widget.id));

    if (stateRestaurant == null) {
      return const LayoutDefault(child: Center(child: CircularProgressIndicator()));
    }

    return LayoutDefault(
      title: stateRestaurant.name,
      child: CustomScrollView(
        controller: scrollController,
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverToBoxAdapter(
            child: RestaurantCard.fromModel(
              model: stateRestaurant,
              isDetail: true,
            ),
          ),
          if (stateRestaurant is! ModelRestaurantDetail) renderLoading(),
          if (stateRestaurant is ModelRestaurantDetail)
            const SliverPadding(
              padding: EdgeInsets.symmetric(horizontal: 10.0),
              sliver: SliverToBoxAdapter(
                child: Text(
                  '메뉴',
                  style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w500),
                ),
              ),
            ),
          if (stateRestaurant is ModelRestaurantDetail)
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    final products = stateRestaurant.products[index];
                    return Padding(
                      padding: const EdgeInsets.only(top: 10.0),
                      child: RestaurantProductCard.fromModelRestaurantDetailProduct(model: products),
                    );
                  },
                  childCount: stateRestaurant.products.length,
                ),
              ),
            ),
          if (stateRating is CursorPagination<ModelRating>)
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
              sliver: SliverList(
                  delegate: SliverChildBuilderDelegate(
                childCount: stateRating.data.length,
                (context, index) {
                  final model = stateRating.data[index];

                  return Padding(
                    padding: EdgeInsets.only(bottom: index == stateRating.data.length - 1 ? 0 : 10.0),
                    child: RatingCard.fromModel(model: model),
                  );
                },
              )),
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
            1,
            (index) => SkeletonParagraph(
              style: const SkeletonParagraphStyle(
                padding: EdgeInsets.only(bottom: 10.0),
                lines: 5,
                spacing: 10,
              ),
            ),
          ),
          ...List.generate(
            3,
            (index) => SkeletonListTile(
              contentSpacing: 10,
              hasSubtitle: true,
            ),
          ),
        ]),
      ),
    );
  }
}
