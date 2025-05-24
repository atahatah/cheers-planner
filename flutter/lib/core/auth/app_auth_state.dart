import 'package:cheers_planner/index.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'app_auth_state.freezed.dart';

@freezed
sealed class AppAuthState with _$AppAuthState {
  const factory AppAuthState.signedIn({
    required User user,
    required UserEntry userEntry,
  }) = SignedIn;

  const factory AppAuthState.notRegistered({required User user}) =
      NotRegistered;

  const factory AppAuthState.notSignedIn() = NotSignedIn;
}
