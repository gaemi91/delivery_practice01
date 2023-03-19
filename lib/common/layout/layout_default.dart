import 'package:flutter/material.dart';

class LayoutDefault extends StatelessWidget {
  final Widget child;
  final Color colorBG;
  final String? title;
  final Widget? bottomNavigator;
  final Widget? floatingActionButton;

  const LayoutDefault({
    required this.child,
    this.colorBG = Colors.white,
    this.title,
    this.bottomNavigator,
    this.floatingActionButton,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorBG,
      appBar: title == null
          ? null
          : AppBar(
              backgroundColor: Colors.white,
              foregroundColor: Colors.black,
              elevation: 0,
              centerTitle: true,
              title: Text(title!, style: const TextStyle(fontSize: 20.0, fontWeight: FontWeight.w700)),
            ),
      body: child,
      bottomNavigationBar: bottomNavigator,
      floatingActionButton: floatingActionButton,
    );
  }
}
