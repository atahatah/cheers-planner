import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'snackbar_repo.g.dart';

@riverpod
GlobalKey<ScaffoldMessengerState> snackBarKey(Ref ref) {
  return GlobalKey<ScaffoldMessengerState>();
}

@riverpod
SnackBarRepo snackBarRepo(Ref ref) {
  final key = ref.watch(snackBarKeyProvider);
  return SnackBarRepo(key);
}

class SnackBarRepo {
  SnackBarRepo(this.key);
  final GlobalKey<ScaffoldMessengerState> key;

  void show(String message) {
    key.currentState?.showSnackBar(SnackBar(content: Text(message)));
  }
}
