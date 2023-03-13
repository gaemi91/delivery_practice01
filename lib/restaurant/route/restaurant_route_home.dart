import 'package:delivery_practice01/common/model/model_cursor_pagination.dart';
import 'package:delivery_practice01/restaurant/component/restaurant_card.dart';
import 'package:delivery_practice01/restaurant/provider/provider_restaurant.dart';
import 'package:delivery_practice01/restaurant/route/restaurant_route_detail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RestaurantRouteHome extends ConsumerStatefulWidget {
  const RestaurantRouteHome({Key? key}) : super(key: key);

  @override
  ConsumerState<RestaurantRouteHome> createState() => _RestaurantRouteHomeState();
}

class _RestaurantRouteHomeState extends ConsumerState<RestaurantRouteHome> {
  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    scrollController.addListener(scrollListener);
  }

  @override
  void dispose() {
    scrollController.removeListener(scrollListener);
    scrollController.dispose();
    super.dispose();
  }

  void scrollListener() {
    if (scrollController.offset > scrollController.position.maxScrollExtent - 300) {
      ref.read(stateNotifierProviderRestaurant.notifier).paginate(fetchMore: true);
    }
  }

  @override
  Widget build(BuildContext context) {
    final data = ref.watch(stateNotifierProviderRestaurant);

    if (data is CursorPaginationLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (data is CursorPaginationError) {
      return Center(child: Text(data.message));
    }

    final cp = data as CursorPagination;

    return ListView.separated(
      controller: scrollController,
      physics: const BouncingScrollPhysics(),
      itemBuilder: (context, index) {
        if (index == cp.data.length) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
            child: Center(
              child: data is CursorPaginationFetchMore ? const CircularProgressIndicator() : const Text('마지막 데이터입니다.'),
            ),
          );
        }

        final modelRestaurant = cp.data[index];

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
      itemCount: cp.data.length + 1,
    );
  }
}
