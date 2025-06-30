import 'package:cheers_planner/core/firebase/firestore_repo.dart';
import 'package:cheers_planner/core/models/event.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'event_repo.g.dart';

@riverpod
DocumentReference<Event> eventDocument(Ref ref, String eventId) {
  final firestore = ref.watch(firestoreProvider);
  return firestore
      .doc('events/$eventId')
      .withConverter<Event>(
        fromFirestore: (snapshot, _) {
          final data = snapshot.data();
          if (data == null) {
            throw Exception('Event data is null');
          }
          return Event.fromJson(data..['id'] = snapshot.id);
        },
        toFirestore: (model, _) => model.toJson()..remove('id'),
      );
}

@riverpod
CollectionReference<Participant> participantsCollection(
  Ref ref,
  String eventId,
) {
  final firestore = ref.watch(firestoreProvider);
  return firestore
      .collection('events/$eventId/participants')
      .withConverter<Participant>(
        fromFirestore: (snapshot, _) {
          final data = snapshot.data();
          if (data == null) {
            throw Exception('Participant data is null');
          }
          return Participant.fromJson(data..['id'] = snapshot.id);
        },
        toFirestore: (model, _) => model.toJson()..remove('id'),
      );
}

@riverpod
DocumentReference<Participant> participantDocument(
  Ref ref,
  String eventId,
  String participantId,
) {
  final participantsCollection = ref.watch(
    participantsCollectionProvider(eventId),
  );
  return participantsCollection.doc(participantId);
}

@riverpod
DocumentReference<EventResult> eventResultDocument(Ref ref, String eventId) {
  final firestore = ref.watch(firestoreProvider);
  return firestore
      .doc('events/$eventId/result')
      .withConverter<EventResult>(
        fromFirestore: (snapshot, _) {
          final data = snapshot.data();
          if (data == null) {
            throw Exception('EventResult data is null');
          }
          return EventResult.fromJson(data);
        },
        toFirestore: (model, _) => model.toJson(),
      );
}

// 便利なメソッド用のクラス
@riverpod
EventRepository eventRepository(Ref ref) {
  return EventRepository(ref);
}

class EventRepository {
  EventRepository(this._ref);

  final Ref _ref;

  // Event取得
  Future<Event?> getEvent(String eventId) async {
    try {
      final doc = await _ref.read(eventDocumentProvider(eventId)).get();
      return doc.data();
    } on FirebaseException catch (e) {
      print('Firebase error getting event: $e'); // Debug用
      return null;
    } catch (e) {
      print('Error getting event: $e'); // Debug用
      return null;
    }
  }

  // 参加者リスト取得
  Future<List<Participant>> getParticipants(String eventId) async {
    try {
      final collection = _ref.read(participantsCollectionProvider(eventId));
      final snapshot = await collection.get();
      return snapshot.docs.map((doc) => doc.data()).toList();
    } on FirebaseException catch (e) {
      print('Firebase error getting participants: $e'); // Debug用
      return [];
    } catch (e) {
      print('Error getting participants: $e'); // Debug用
      return [];
    }
  }

  // イベント結果取得
  Future<EventResult?> getEventResult(String eventId) async {
    try {
      final doc = await _ref.read(eventResultDocumentProvider(eventId)).get();
      return doc.data();
    } on FirebaseException catch (e) {
      print('Firebase error getting event result: $e'); // Debug用
      return null;
    } catch (e) {
      print('Error getting event result: $e'); // Debug用
      return null;
    }
  }

  // フルイベントデータ取得（Event + Participants + Result）
  Future<EventFullData?> getFullEventData(String eventId) async {
    try {
      final event = await getEvent(eventId);
      if (event == null) {
        return null;
      }

      final participants = await getParticipants(eventId);
      final result = await getEventResult(eventId);

      return EventFullData(
        event: event,
        participants: participants,
        result: result,
      );
    } on FirebaseException catch (e) {
      print('Firebase error getting full event data: $e'); // Debug用
      return null;
    } catch (e) {
      print('Error getting full event data: $e'); // Debug用
      return null;
    }
  }
}

// フルデータを格納するクラス
class EventFullData {
  const EventFullData({
    required this.event,
    required this.participants,
    this.result,
  });

  final Event event;
  final List<Participant> participants;
  final EventResult? result;

  @override
  String toString() {
    return 'EventFullData(event: ${event.eventName}, participants: ${participants.length}, hasResult: ${result != null})';
  }
}
