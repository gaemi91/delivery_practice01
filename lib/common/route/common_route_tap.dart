import 'package:delivery_practice01/common/const/colors.dart';
import 'package:delivery_practice01/common/layout/layout_default.dart';
import 'package:delivery_practice01/restaurant/route/restaurant_route_home.dart';
import 'package:flutter/material.dart';

class CommonRouteTap extends StatefulWidget {
  const CommonRouteTap({Key? key}) : super(key: key);

  @override
  State<CommonRouteTap> createState() => _CommonRouteTapState();
}

class _CommonRouteTapState extends State<CommonRouteTap> with SingleTickerProviderStateMixin {
  late TabController tabController;
  int currentTab = 0;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 4, vsync: this);
    tabController.addListener(controllerListener);
  }

  @override
  void dispose() {
    tabController.removeListener(controllerListener);
    tabController.dispose();
    super.dispose();
  }

  controllerListener() {
    setState(() {
      currentTab = tabController.index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return LayoutDefault(
      title: '개미 딜리버리',
      child: TabBarView(
        controller: tabController,
        physics: NeverScrollableScrollPhysics(),
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
        onTap: (value) {
          tabController.index = value;
          tabController.animateTo(value);
        },
        currentIndex: currentTab,
        selectedItemColor: Color_Main,
        unselectedItemColor: Color_Text,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: '홈',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.fastfood_outlined),
            label: '음식',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.receipt_outlined),
            label: '주문',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            label: '프로필',
          ),
        ],
      ),
    );
  }
}
