import 'package:delivery_practice01/common/const/colors.dart';
import 'package:delivery_practice01/user/provider/provider_user_me.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UserRouteProfile extends ConsumerWidget {
  const UserRouteProfile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Center(
      child: ElevatedButton(
        onPressed: () {
          ref.read(stateNotifierProviderUserMe.notifier).logOut();
        },
        style: ElevatedButton.styleFrom(backgroundColor: Color_Main),
        child: const Text('로그아웃'),
      ),
    );
  }
}
