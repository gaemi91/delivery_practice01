import 'package:delivery_practice01/common/layout/layout_default.dart';
import 'package:flutter/material.dart';

class RouteTap extends StatelessWidget {
  const RouteTap({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutDefault(
      body: Center(child: Text('Route Tap')),
    );
  }
}
