import 'package:firebase_auth/firebase_auth.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_entry.freezed.dart';
part 'user_entry.g.dart';

@freezed
sealed class UserEntry with _$UserEntry {
  const factory UserEntry({
    required String id,
    required String name,
    required String email,
    required String photoUrl,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _UserEntry;

  factory UserEntry.fromJson(Map<String, dynamic> json) =>
      _$UserEntryFromJson(json);

  factory UserEntry.fromFirebaseUser(User user) {
    return UserEntry(
      id: user.uid,
      name: user.displayName ?? '',
      email: user.email ?? '',
      photoUrl: user.photoURL ?? '',
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );
  }
}
