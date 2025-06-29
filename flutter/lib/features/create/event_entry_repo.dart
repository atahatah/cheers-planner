import 'package:cheers_planner/core/firebase/firestore_repo.dart';
import 'package:cheers_planner/features/create/event_entry.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'event_entry_repo.g.dart';

@riverpod
EventEntryRepo eventEntryRepo(Ref ref) {
  final col = ref.watch(eventsCollectionProvider);
  return EventEntryRepo(col);
}

@riverpod
CandidateDateTimeRepo candidateDateTimeRepo(Ref ref, String eventId) {
  final col = ref.watch(candidateDatesCollectionProvider(eventId));
  return CandidateDateTimeRepo(col);
}

@riverpod
CandidateAreaRepo candidateAreaRepo(Ref ref, String eventId) {
  final col = ref.watch(candidateAreasCollectionProvider(eventId));
  return CandidateAreaRepo(col);
}

@riverpod
EventResultRepo eventResultRepo(Ref ref, String eventId) {
  final col = ref.watch(eventResultsCollectionProvider(eventId));
  return EventResultRepo(col);
}

class EventEntryRepo {
  EventEntryRepo(this._col);

  final CollectionReference<EventEntry> _col;

  Query<EventEntry> listViewQuery() {
    return _col.orderBy('dueDate', descending: true);
  }

  Future<void> add(EventEntry event) {
    return _col.add(event);
  }

  Future<EventEntry?> get(String id) async {
    final snapshot = await _col.doc(id).get();
    return snapshot.data();
  }

  Future<void> delete(String id) => _col.doc(id).delete();
}

class CandidateDateTimeRepo {
  CandidateDateTimeRepo(this._col);

  final CollectionReference<CandidateDateTime> _col;

  Future<void> add(CandidateDateTime candidate) {
    return _col.add(candidate);
  }

  Future<CandidateDateTime?> get(String id) async {
    final snapshot = await _col.doc(id).get();
    return snapshot.data();
  }

  Future<void> delete(String id) => _col.doc(id).delete();
}

class CandidateAreaRepo {
  CandidateAreaRepo(this._col);

  final CollectionReference<CandidateArea> _col;

  Future<void> add(CandidateArea candidate) {
    return _col.add(candidate);
  }

  Future<CandidateArea?> get(String id) async {
    final snapshot = await _col.doc(id).get();
    return snapshot.data();
  }

  Future<void> delete(String id) => _col.doc(id).delete();
}

class EventResultRepo {
  EventResultRepo(this._col);

  final CollectionReference<EventResult> _col;

  Future<void> add(EventResult result) {
    return _col.add(result);
  }

  Future<EventResult?> get(String id) async {
    final snapshot = await _col.doc(id).get();
    return snapshot.data();
  }

  Future<void> delete(String id) => _col.doc(id).delete();
}
