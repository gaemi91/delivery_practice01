import 'package:delivery_practice01/common/route/common_route_splash.dart';
import 'package:delivery_practice01/common/route/common_route_tap.dart';
import 'package:delivery_practice01/restaurant/route/restaurant_route_basket.dart';
import 'package:delivery_practice01/restaurant/route/restaurant_route_detail.dart';
import 'package:delivery_practice01/user/model/model_user.dart';
import 'package:delivery_practice01/user/provider/provider_user_me.dart';
import 'package:delivery_practice01/user/route/user_route_login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

final changeNotifierProviderAuth = ChangeNotifierProvider<ChangeNotifierAuth>(
  (ref) => ChangeNotifierAuth(ref: ref),
);

class ChangeNotifierAuth extends ChangeNotifier {
  final Ref ref;

  ChangeNotifierAuth({required this.ref}) {
    ref.listen<ModelUserBase?>(stateNotifierProviderUserMe, (previous, next) {
      if (previous != next) {
        notifyListeners();
      }
    });
  }

  List<GoRoute> get routes => [
        GoRoute(
          path: '/splash',
          name: CommonRouteSplash.routeName,
          builder: (context, state) => const CommonRouteSplash(),
        ),
        GoRoute(
          path: '/login',
          name: UserRouteLogIn.routeName,
          builder: (context, state) => const UserRouteLogIn(),
        ),
        GoRoute(
            path: '/',
            name: CommonRouteTap.routeName,
            builder: (context, state) => const CommonRouteTap(),
            routes: [
              GoRoute(
                path: 'restaurant/:rid',
                name: RestaurantRouteDetail.routeName,
                builder: (context, state) => RestaurantRouteDetail(id: state.params['rid']!),
              ),
            ]),
        GoRoute(
          path: '/basket',
          name: RestaurantRouteBasket.routeName,
          builder: (context, state) => const RestaurantRouteBasket(),
        ),
      ];

  void logOut() {
    ref.read(stateNotifierProviderUserMe.notifier).logOut();
  }

  String? redirectLogic(GoRouterState state) {
    final ModelUserBase? stateUser = ref.read(stateNotifierProviderUserMe);
    final loggingIn = state.location == '/login';

    if (stateUser == null) {
      return loggingIn ? null : '/login';
    }

    if (stateUser is ModelUser) {
      return loggingIn || state.location == '/splash' ? '/' : null;
    }

    if (stateUser is ModelUserError) {
      return !loggingIn ? '/login' : null;
    }

    return null;
  }
}
