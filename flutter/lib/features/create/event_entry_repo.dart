import 'package:cheers_planner/core/firebase/firestore_repo.dart';
import 'package:cheers_planner/features/create/event_entry.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'event_entry_repo.g.dart';

@riverpod
EventEntriesRepo eventEntriesRepo(Ref ref) {
  final col = ref.watch(eventsCollectionProvider);
  return EventEntriesRepo(col);
}

@riverpod
EventEntryRepo eventEntryRepo(Ref ref, String eventId) {
  final doc = ref.watch(eventDocumentProvider(eventId));
  return EventEntryRepo(doc);
}

@riverpod
Future<EventEntry> eventEntry(Ref ref, String eventId) {
  final repo = ref.watch(eventEntryRepoProvider(eventId));
  return repo.get().then((event) {
    if (event == null) {
      throw NoSuchEventException(eventId);
    }
    return event;
  });
}

class EventEntriesRepo {
  EventEntriesRepo(this._col);

  final CollectionReference<EventEntry> _col;

  Query<EventEntry> listViewQuery() {
    return _col.orderBy('dueDate', descending: true);
  }

  Future<String> add(EventEntry event) {
    return _col.add(event).then((docRef) => docRef.id);
  }

  Future<EventEntry?> get(String id) async {
    final snapshot = await _col.doc(id).get();
    return snapshot.data();
  }

  Future<void> delete(String id) => _col.doc(id).delete();
}

class EventEntryRepo {
  EventEntryRepo(this._doc);

  final DocumentReference<EventEntry> _doc;

  Future<void> add(EventEntry event) {
    return _doc.set(event);
  }

  Future<EventEntry?> get() async {
    final snapshot = await _doc.get();
    return snapshot.data();
  }

  Future<void> delete() => _doc.delete();
}

class NoSuchEventException implements Exception {
  NoSuchEventException(this.eventId);

  final String eventId;

  @override
  String toString() => 'No such event with ID: $eventId';
}
