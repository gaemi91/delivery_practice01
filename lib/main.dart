import 'package:delivery_practice01/common/route/route_splash.dart';
import 'package:flutter/material.dart';


void main() {
  runApp(const _App());
}

class _App extends StatelessWidget {
  const _App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'notosans'
      ),
      home: RouteSplash()
    );
  }
}
