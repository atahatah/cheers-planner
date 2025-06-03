import 'package:cheers_planner/core/auth/user_entry.dart';
import 'package:cheers_planner/core/firebase/firestore_repo.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'user_entry_repo.g.dart';

@riverpod
UserEntryRepo userEntryRepo(Ref ref, String uid) {
  final userDocument = ref.watch(userDocumentProvider(uid));
  return UserEntryRepo(userDocument);
}

class UserEntryRepo {
  UserEntryRepo(this._doc);
  final DocumentReference<UserEntry> _doc;

  Future<UserEntry?> get() async {
    final snapshot = await _doc.get();
    return snapshot.data();
  }

  Future<void> set(UserEntry user) async {
    await _doc.set(user);
  }
}
