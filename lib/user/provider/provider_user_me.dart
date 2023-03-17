import 'package:delivery_practice01/common/const/data.dart';
import 'package:delivery_practice01/common/secure_storage/secure_storage.dart';
import 'package:delivery_practice01/user/model/model_user.dart';
import 'package:delivery_practice01/user/repository/repository_auth.dart';
import 'package:delivery_practice01/user/repository/repository_user_me.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

final stateNotifierProviderUserMe = StateNotifierProvider<StateNotifierUserMe, ModelUserBase?>((ref) {
  return StateNotifierUserMe(
    storage: ref.watch(providerSecureStorage),
    repositoryUserMe: ref.watch(providerRepositoryUserMe),
    repositoryAuth: ref.watch(providerRepositoryAuth),
  );
});

class StateNotifierUserMe extends StateNotifier<ModelUserBase?> {
  final FlutterSecureStorage storage;
  final RepositoryUserMe repositoryUserMe;
  final RepositoryAuth repositoryAuth;

  StateNotifierUserMe({
    required this.storage,
    required this.repositoryUserMe,
    required this.repositoryAuth,
  }) : super(ModelUserLoading()) {
    getUserMe();
  }

  Future<void> getUserMe() async {
    final refreshToken = await storage.read(key: Token_key_Refresh);
    final accessToken = await storage.read(key: Token_key_Access);

    if (refreshToken == null || accessToken == null) {
      //로그아웃
      state = null;

      return;
    }

    final resp = await repositoryUserMe.getUserMe();

    //로그인
    state = resp;
  }

  Future<ModelUserBase> logIn({
    required String username,
    required String password,
  }) async {
    try {
      state = ModelUserLoading();

      final resp = await repositoryAuth.logIn(username: username, password: password);

      await storage.write(key: Token_key_Refresh, value: resp.refreshToken);
      await storage.write(key: Token_key_Access, value: resp.accessToken);

      final modelUser = await repositoryUserMe.getUserMe();

      state = modelUser;

      return modelUser;
    } catch (e) {
      state = ModelUserError(message: '로그인에 실패했습니다.');

      return Future.value(state);
    }
  }

  Future<void> logOut() async {
    state = null;

    await Future.wait([
      storage.delete(key: Token_key_Refresh),
      storage.delete(key: Token_key_Access),
    ]);
  }
}
