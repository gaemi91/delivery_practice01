import 'package:delivery_practice01/common/const/colors.dart';
import 'package:delivery_practice01/common/const/data.dart';
import 'package:delivery_practice01/common/layout/layout_default.dart';
import 'package:delivery_practice01/common/route/route_tap.dart';
import 'package:delivery_practice01/user/route/user_route_login.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class RouteSplash extends StatefulWidget {
  const RouteSplash({Key? key}) : super(key: key);

  @override
  State<RouteSplash> createState() => _RouteSplashState();
}

class _RouteSplashState extends State<RouteSplash> {
  @override
  void initState() {
    super.initState();
    checkToken();
  }

  checkToken() async {
    try {
      final refreshToken = await storage.read(key: Token_key_Refresh);

      final resp = await dio.post(
        'http://$ip/auth/token',
        options: Options(headers: {'authorization': 'Bearer $refreshToken'}),
      );

      await storage.write(key: Token_key_Access, value: resp.data[Token_key_Access]);

      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (_) => const RouteTap()),
        (route) => false,
      );
    } catch (e) {
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (_) => const UserRouteLogIn()),
        (route) => false,
      );
    }
  }

  deleteToken() async {
    await storage.deleteAll();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutDefault(
      colorBG: Color_Main,
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('asset/img/logo/logo.png', width: MediaQuery.of(context).size.width * 2 / 3),
            const SizedBox(height: 10.0),
            const CircularProgressIndicator(color: Colors.white),
          ],
        ),
      ),
    );
  }
}
