import 'dart:convert';

import 'package:cheers_planner/core/auth/app_auth_controller.dart';
import 'package:cheers_planner/core/auth/app_auth_state.dart';
import 'package:cheers_planner/features/auth/register_screen.dart';
import 'package:cheers_planner/features/auth/sign_in_screen.dart';
import 'package:cheers_planner/features/auth/sign_up_screen.dart';
import 'package:cheers_planner/features/create/consult_event_screen.dart';
import 'package:cheers_planner/features/create/create_event_screen.dart';
import 'package:cheers_planner/features/create/event_entry.dart';
import 'package:cheers_planner/features/create/event_list_screen.dart';
import 'package:cheers_planner/features/create/management_screen.dart';
import 'package:cheers_planner/features/exec_ai/exec_ai_screen.dart';
import 'package:cheers_planner/features/settings/settings_screen.dart';
import 'package:cheers_planner/features/vote/result_screen.dart';
import 'package:cheers_planner/features/vote/vote_screen.dart';
import 'package:cheers_planner/features/vote/voted_list_screen.dart';
import 'package:cheers_planner/features/vote/vote_confirm_screen.dart';
import 'package:cheers_planner/features/vote/participant.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'root.g.dart';
part 'routes/auth.dart';
part 'routes/shell_routes/create.dart';
part 'routes/shell_routes/exec_ai.dart';
part 'routes/shell_routes/settings.dart';
part 'routes/shell_routes/shell_route.dart';
part 'routes/shell_routes/vote.dart';

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
      final path = state.fullPath;
      switch (asyncAuthState) {
        case AsyncData(value: final authState):
          switch (authState) {
            case SignedIn():
              if (path?.startsWith('/auth') ?? false) {
                final token = state.uri.queryParameters['redirect'] ?? '';
                if (token.isNotEmpty) {
                  final decoded = utf8.decode(base64Url.decode(token));
                  return decoded;
                }
                return const VotedListRoute().location;
              }
              return null;
            case NotRegistered():
              if (path?.startsWith(const RegisterRoute().location) ?? false) {
                return null;
              }
              return '${const RegisterRoute().location}?redirect=${base64Url.encode(utf8.encode(state.uri.toString()))}';
            case NotSignedIn():
              if (path?.startsWith(const SignUpRoute().location) ?? false) {
                return null;
              }
              return '${const SignUpRoute().location}?redirect=${base64Url.encode(utf8.encode(state.uri.toString()))}';
          }
        case AsyncLoading():
        case AsyncError():
        default:
          return null;
      }
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
