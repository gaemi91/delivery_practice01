import 'package:delivery_practice01/common/layout/layout_default.dart';
import 'package:flutter/material.dart';

class CommonRouteTap extends StatelessWidget {
  const CommonRouteTap({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutDefault(
        child: Center(
      child: Text('route tap'),
    ));
  }
}
