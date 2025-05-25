import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'app_check_repo.g.dart';

@riverpod
FirebaseAppCheck firebaseAppCheck(Ref ref) {
  return FirebaseAppCheck.instance;
}
