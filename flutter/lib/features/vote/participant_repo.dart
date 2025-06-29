import 'package:cheers_planner/core/firebase/firestore_repo.dart';
import 'package:cheers_planner/features/vote/participant.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'participant_repo.g.dart';

@riverpod
ParticipantRepo participantRepo(Ref ref, String eventId) {
  final col = ref.watch(participantsCollectionProvider(eventId));
  return ParticipantRepo(col);
}

class ParticipantRepo {
  ParticipantRepo(this._col);

  final CollectionReference<EventParticipant> _col;

  Query<EventParticipant> listViewQuery(String eventId) {
    return _col
        .where('eventId', isEqualTo: eventId)
        .orderBy('createdAt', descending: true);
  }

  Future<void> set(String id, EventParticipant participant) {
    return _col.doc(id).set(participant);
  }

  Future<EventParticipant?> get(String id) async {
    final snapshot = await _col.doc(id).get();
    return snapshot.data();
  }

  Future<void> delete(String id) => _col.doc(id).delete();
}
