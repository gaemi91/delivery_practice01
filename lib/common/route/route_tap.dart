import 'package:delivery_practice01/common/const/colors.dart';
import 'package:delivery_practice01/common/layout/layout_default.dart';
import 'package:flutter/material.dart';

class RouteTap extends StatefulWidget {
  const RouteTap({Key? key}) : super(key: key);

  @override
  State<RouteTap> createState() => _RouteTapState();
}

class _RouteTapState extends State<RouteTap> with SingleTickerProviderStateMixin {
  late TabController tabController;
  int currentIndex = 0;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 4, vsync: this);
    tabController.addListener(tabControllerListener);
  }

  @override
  void dispose() {
    tabController.removeListener(tabControllerListener);
    tabController.dispose();
    super.dispose();
  }

  void tabControllerListener() {
    setState(() {
      currentIndex = tabController.index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return LayoutDefault(
      title: '개미 딜리버리',
      body: TabBarView(
        controller: tabController,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          Center(child: Text('홈')),
          Center(child: Text('음식')),
          Center(child: Text('주문')),
          Center(child: Text('프로필')),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        elevation: 0,
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
