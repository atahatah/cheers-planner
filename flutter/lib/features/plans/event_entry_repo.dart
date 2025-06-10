import 'package:cheers_planner/core/firebase/firestore_repo.dart';
import 'package:cheers_planner/features/plans/event_entry.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'event_entry_repo.g.dart';

@riverpod
EventEntryRepo eventEntryRepo(Ref ref) {
  final col = ref.watch(plansCollectionProvider);
  return EventEntryRepo(col);
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
