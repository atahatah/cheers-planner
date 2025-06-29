import 'package:cheers_planner/core/auth/user_entry.dart';
import 'package:cheers_planner/features/create/event_entry.dart';
import 'package:cheers_planner/features/vote/participant.dart';
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
DocumentReference<EventEntry> eventDocument(Ref ref, String eventId) {
  final firestore = ref.watch(firestoreProvider);
  return firestore
      .doc('events/$eventId')
      .withConverter<EventEntry>(
        fromFirestore: (snapshot, _) =>
            EventEntry.fromJson(snapshot.data()!..['id'] = snapshot.id),
        toFirestore: (model, _) => model.toJson()..remove('id'),
      );
}

@riverpod
CollectionReference<EventEntry> eventsCollection(Ref ref) {
  final firestore = ref.watch(firestoreProvider);
  return firestore
      .collection('events')
      .withConverter<EventEntry>(
        fromFirestore: (snapshot, _) =>
            EventEntry.fromJson(snapshot.data()!..['id'] = snapshot.id),
        toFirestore: (model, _) => model.toJson()..remove('id'),
      );
}

@riverpod
CollectionReference<CandidateDateTime> candidateDatesCollection(
  Ref ref,
  String eventId,
) {
  final firestore = ref.watch(firestoreProvider);
  return firestore
      .collection('events/$eventId/candidateDateTimes')
      .withConverter<CandidateDateTime>(
        fromFirestore: (snapshot, _) => CandidateDateTime.fromJson(
          snapshot.data()!
            ..['id'] = snapshot.id
            ..['eventId'] = eventId,
        ),
        toFirestore: (model, _) => model.toJson()
          ..remove('id')
          ..remove('eventId'),
      );
}

@riverpod
CollectionReference<CandidateArea> candidateAreasCollection(
  Ref ref,
  String eventId,
) {
  final firestore = ref.watch(firestoreProvider);
  return firestore
      .collection('events/$eventId/candidateAreas')
      .withConverter<CandidateArea>(
        fromFirestore: (snapshot, _) => CandidateArea.fromJson(
          snapshot.data()!
            ..['id'] = snapshot.id
            ..['eventId'] = eventId,
        ),
        toFirestore: (model, _) => model.toJson()
          ..remove('id')
          ..remove('eventId'),
      );
}

@riverpod
CollectionReference<EventResult> eventResultsCollection(
  Ref ref,
  String eventId,
) {
  final firestore = ref.watch(firestoreProvider);
  return firestore
      .collection('events/$eventId/results')
      .withConverter<EventResult>(
        fromFirestore: (snapshot, _) => EventResult.fromJson(
          snapshot.data()!
            ..['id'] = snapshot.id
            ..['eventId'] = eventId,
        ),
        toFirestore: (model, _) => model.toJson()
          ..remove('id')
          ..remove('eventId'),
      );
}

@riverpod
CollectionReference<EventParticipant> participantsCollection(
  Ref ref,
  String eventId,
) {
  final firestore = ref.watch(firestoreProvider);
  return firestore
      .collection('events/$eventId/participants')
      .withConverter<EventParticipant>(
        fromFirestore: (snapshot, _) => EventParticipant.fromJson(
          snapshot.data()!
            ..['id'] = snapshot.id
            ..['eventId'] = eventId,
        ),
        toFirestore: (model, _) => model.toJson()
          ..remove('id')
          ..remove('eventId'),
      );
}
