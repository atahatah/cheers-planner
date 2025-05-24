import 'package:cheers_planner/index.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'root.g.dart';
part 'routes/auth.dart';
part 'routes/shell_routes/counter.dart';
part 'routes/shell_routes/settings.dart';
part 'routes/shell_routes/shell_route.dart';

@riverpod
GoRouter router(Ref ref) {
  final appAuthListenable = ref.watch(appAuthListenableProvider);
  return GoRouter(
    refreshListenable: appAuthListenable,
    initialLocation: const SignUpRoute().location,
    routes: $appRoutes,
    debugLogDiagnostics: kDebugMode,
    redirect: (context, state) {
      final asyncAuthState = ref.read(appAuthControllerProvider);
      switch (asyncAuthState) {
        case AsyncData(value: final authState):
          switch (authState) {
            case SignedIn():
              if (state.path?.startsWith('/auth') ?? false) {
                return const CounterRoute().location;
              }
              return null;
            case NotRegistered():
              return const RegisterRoute().location;
            case NotSignedIn():
              if (state.path?.startsWith('/auth') ?? false) {
                return null;
              }
              return const SignUpRoute().location;
          }
        case AsyncLoading():
          return null;
        case AsyncError():
          return null;
      }
      return null;
    },
  );
}

class RouteRefreshListenable extends Listenable {
  VoidCallback? _listener;
  @override
  void addListener(VoidCallback listener) {
    _listener = listener;
  }

  @override
  void removeListener(VoidCallback listener) {
    _listener = null;
  }

  void notify() {
    _listener?.call();
  }
}

@riverpod
RouteRefreshListenable appAuthListenable(Ref ref) {
  final listenable = RouteRefreshListenable();
  ref.listen(appAuthControllerProvider, (old, next) {
    listenable.notify();
  });
  return listenable;
}
