import 'package:flutter/material.dart';

class LayoutDefault extends StatelessWidget {
  final Widget body;
  final Color colorBG;
  final String? title;
  final List<Widget>? actions;
  final Widget? bottomNavigationBar;

  const LayoutDefault({
    required this.body,
    this.title,
    this.actions,
    this.colorBG = Colors.white,
    this.bottomNavigationBar,
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
                style: const TextStyle(fontSize: 20.0, fontWeight: FontWeight.w600),
              ),
              elevation: 0,
              backgroundColor: Colors.white,
              foregroundColor: Colors.black,
              actions: actions,
            ),
      body: body,
      bottomNavigationBar: bottomNavigationBar,
    );
  }
}
