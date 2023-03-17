import 'package:delivery_practice01/common/const/colors.dart';
import 'package:delivery_practice01/common/layout/layout_default.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CommonRouteSplash extends ConsumerWidget {
  static String get routeName => 'splash';

  const CommonRouteSplash({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    return LayoutDefault(
        colorBG: Color_Main,
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset('asset/img/logo/logo.png', width: MediaQuery.of(context).size.width * 2 / 3),
              const SizedBox(height: 10.0),
              const CircularProgressIndicator(color: Colors.white),
            ],
          ),
        ));
  }
}
