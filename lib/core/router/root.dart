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
  return GoRouter(
    initialLocation: const SignUpRoute().location,
    routes: $appRoutes,
    debugLogDiagnostics: kDebugMode,
  );
}
