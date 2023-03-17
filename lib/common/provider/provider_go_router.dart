import 'package:delivery_practice01/user/provider/provider_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

final providerGoRouter = Provider<GoRouter>((ref) {
  final provider = ref.read(changeNotifierProviderAuth);

  return GoRouter(
    routes: provider.routes,
    initialLocation: '/splash',
    redirect: (context, state) => provider.redirectLogic(state),
    refreshListenable: provider,
  );
});
