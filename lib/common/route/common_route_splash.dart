import 'package:delivery_practice01/common/const/colors.dart';
import 'package:delivery_practice01/common/const/data.dart';
import 'package:delivery_practice01/common/layout/layout_default.dart';
import 'package:delivery_practice01/common/route/common_route_tap.dart';
import 'package:delivery_practice01/user/route/user_route_login.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class CommonRouteSplash extends StatefulWidget {
  const CommonRouteSplash({Key? key}) : super(key: key);

  @override
  State<CommonRouteSplash> createState() => _CommonRouteSplashState();
}

class _CommonRouteSplashState extends State<CommonRouteSplash> {
  @override
  void initState() {
    super.initState();
    checkToken();
  }

  void checkToken() async {
    try {
      final refreshToken = await storage.read(key: Token_key_Refresh);

      final resp = await dio.post(
        'http://$ip/auth/token',
        options: Options(headers: {'authorization': 'Bearer $refreshToken'}),
      );

      await storage.write(key: Token_Key_Access, value: resp.data[Token_Key_Access]);

      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (_) => CommonRouteTap()), (route) => false);
    } catch (e) {
      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (_) => UserRouteLogIn()), (route) => false);
    }
  }

  void deleteToken() async {
    await storage.deleteAll();
  }

  @override
  Widget build(BuildContext context) {
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
