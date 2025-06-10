import 'package:cheers_planner/core/auth/user_entry.dart';
import 'package:cheers_planner/features/plans/event_entry.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'firestore_repo.g.dart';

@riverpod
FirebaseFirestore firestore(Ref ref) {
  return FirebaseFirestore.instance;
}

@riverpod
DocumentReference<UserEntry> userDocument(Ref ref, String uid) {
  final firestore = ref.watch(firestoreProvider);
  return firestore
      .doc('users/$uid')
      .withConverter<UserEntry>(
        fromFirestore: (snapshot, _) =>
            UserEntry.fromJson(snapshot.data()!..['id'] = snapshot.id),
        toFirestore: (model, _) => model.toJson()..remove('id'),
      );
}

@riverpod
DocumentReference<EventEntry> planDocument(Ref ref, String planId) {
  final firestore = ref.watch(firestoreProvider);
  return firestore
      .doc('events/$planId')
      .withConverter<EventEntry>(
        fromFirestore: (snapshot, _) =>
            EventEntry.fromJson(snapshot.data()!..['id'] = snapshot.id),
        toFirestore: (model, _) => model.toJson()..remove('id'),
      );
}

@riverpod
CollectionReference<EventEntry> plansCollection(Ref ref) {
  final firestore = ref.watch(firestoreProvider);
  return firestore
      .collection('events')
      .withConverter<EventEntry>(
        fromFirestore: (snapshot, _) =>
            EventEntry.fromJson(snapshot.data()!..['id'] = snapshot.id),
        toFirestore: (model, _) => model.toJson()..remove('id'),
      );
}
