import 'package:cheers_planner/core/firebase/auth_exception.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_repo.g.dart';

@riverpod
FirebaseAuth firebaseAuth(Ref ref) {
  return FirebaseAuth.instance;
}

@riverpod
Stream<User?> authStateChanges(Ref ref) {
  final auth = ref.watch(firebaseAuthProvider);
  return auth.authStateChanges();
}

@riverpod
User requireUser(Ref ref) {
  final user = ref.watch(authStateChangesProvider).value;
  if (user == null) {
    throw NotSignedInException(StackTrace.current);
  }
  return user;
}
