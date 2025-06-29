import 'package:cheers_planner/core/app/snackbar_repo.dart';
import 'package:cheers_planner/core/router/root.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class MyApp extends HookConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);
    final snackBarKey = ref.watch(snackBarKeyProvider);
    return MaterialApp.router(
      title: 'Cheers Planner',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      routerConfig: router,
      scaffoldMessengerKey: snackBarKey,
    );
  }
}
