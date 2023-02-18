import 'package:flutter/material.dart';

class LayoutDefault extends StatelessWidget {
  final Widget body;
  final Color colorBG;
  final String? title;
  final Widget? bottomNavigator;

  const LayoutDefault({
    required this.body,
    this.colorBG = Colors.white,
    this.title,
    this.bottomNavigator,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorBG,
      appBar: title == null
          ? null
          : AppBar(
              centerTitle: true,
              title: Text(
                title!,
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 22.0),
              ),
              elevation: 0,
              backgroundColor: Colors.white,
              foregroundColor: Colors.black,
            ),
      body: body,
      bottomNavigationBar: bottomNavigator,
    );
  }
}
