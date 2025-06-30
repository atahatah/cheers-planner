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
        .orderBy('submittedAt', descending: true);
  }

  Future<void> set(String id, EventParticipant participant) {
    return _col.doc(id).set(participant);
  }

  Future<void> delete(String id) => _col.doc(id).delete();

  /// 日程ごとの参加可能人数を取得
  Future<Map<DateTime, int>> getDateParticipantCounts() async {
    final snapshot = await _col.get();
    final counts = <DateTime, int>{};

    for (final doc in snapshot.docs) {
      final participant = doc.data();
      for (final date in participant.desiredDates) {
        // 時分のみを考慮するために日付をキーとして正規化
        final normalizedDate = DateTime(
          date.year,
          date.month,
          date.day,
          date.hour,
          date.minute,
        );
        counts[normalizedDate] = (counts[normalizedDate] ?? 0) + 1;
      }
    }

    return counts;
  }
}
