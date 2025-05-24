import 'package:cheers_planner/index.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'app_auth_controller.g.dart';

@riverpod
class AppAuthController extends _$AppAuthController {
  @override
  Future<AppAuthState> build() async {
    listenSelf(
      (_, next) => debugPrint('AppAuthController state changed: $next'),
    );
    final asyncUser = ref.watch(authStateChangesProvider);
    switch (asyncUser) {
      case final AsyncData<User?> userData:
        final user = userData.value;
        if (user == null) {
          return const AppAuthState.notSignedIn();
        }
        final userEntry = await ref.read(userEntryRepoProvider(user.uid)).get();
        if (userEntry == null) {
          return AppAuthState.notRegistered(user: user);
        }
        return AppAuthState.signedIn(user: user, userEntry: userEntry);
      case AsyncLoading<User?>():
        return const AppAuthState.notSignedIn();
      case AsyncError<User?>():
        return const AppAuthState.notSignedIn();
      default:
        throw Error();
    }
  }

  Future<void> register(DateTime? birthday) async {
    final user = ref.read(requireUserProvider);
    await ref
        .read(userEntryRepoProvider(user.uid))
        .set(UserEntry(birthday: birthday));
    ref.invalidateSelf();
  }

  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
    if (kDebugMode) {
      print('User signed out');
    }
  }
}
