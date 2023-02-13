import 'package:flutter/material.dart';

class LayoutDefault extends StatelessWidget {
  final Widget child;

  const LayoutDefault({
    required this.child,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: child,
    );
  }
}
