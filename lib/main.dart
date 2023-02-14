import 'package:delivery_practice01/common/route/common_route_splash.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

var logger = Logger(printer: PrettyPrinter(methodCount: 1));
var loggerDetail = Logger(printer: PrettyPrinter(methodCount: 3));

void main() {
  runApp(const _App());
}

class _App extends StatelessWidget {
  const _App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: 'notosans'),
      home: const CommonRouteSplash(),
    );
  }
}
