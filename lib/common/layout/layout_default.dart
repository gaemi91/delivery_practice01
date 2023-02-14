import 'package:flutter/material.dart';

class LayoutDefault extends StatelessWidget {
  final Widget child;
  final Color colorBG;

  const LayoutDefault({
    required this.child,
    this.colorBG = Colors.white,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorBG,
      body: child,
    );
  }
}
