import 'package:delivery_practice01/common/const/colors.dart';
import 'package:delivery_practice01/common/layout/layout_default.dart';
import 'package:delivery_practice01/restaurant/route/restaurant_route_home.dart';
import 'package:flutter/material.dart';

class RouteTap extends StatefulWidget {
  const RouteTap({Key? key}) : super(key: key);

  @override
  State<RouteTap> createState() => _RouteTapState();
}

class _RouteTapState extends State<RouteTap> with TickerProviderStateMixin {
  int currentIndex = 0;
  late TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 4, vsync: this);
    tabController.addListener(tabListener);
  }

  @override
  void dispose() {
    tabController.removeListener(tabListener);
    tabController.dispose();
    super.dispose();
  }

  void tabListener() {
    setState(() {
      currentIndex = tabController.index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return LayoutDefault(
      title: '개미뚠뚠 딜리버리',
      body: TabBarView(
        controller: tabController,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          RestaurantRouteHome(),
          Center(child: Text('음식')),
          Center(child: Text('주문')),
          Center(child: Text('프로필')),
        ],
      ),
      bottomNavigator: BottomNavigationBar(
        elevation: 0,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Color_Main,
        unselectedItemColor: Color_Text,
        onTap: (value) {
          tabController.index = value;
          tabController.animateTo(value);
        },
        currentIndex: currentIndex,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home_outlined), label: '홈'),
          BottomNavigationBarItem(icon: Icon(Icons.fastfood_outlined), label: '음식'),
          BottomNavigationBarItem(icon: Icon(Icons.receipt_outlined), label: '주문'),
          BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: '프로필'),
        ],
      ),
    );
  }
}
