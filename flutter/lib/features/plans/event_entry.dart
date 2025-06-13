import 'package:cheers_planner/core/firebase/firestore_converters.dart';
import 'package:cheers_planner/core/map/candidate_area.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'event_entry.freezed.dart';
part 'event_entry.g.dart';

@freezed
sealed class EventEntry with _$EventEntry {
  const factory EventEntry({
    String? id,
    required String eventName,
    @DateTimeToTimestampConverter() required DateTime dueDate,
    required List<(DateTime start, DateTime end)> candidateDateTimes,
    required List<CandidateArea> candidateAreas,
    required String allergiesEtc,
    required List<String> organizerId,
    required List<String> participantId,
  }) = _EventEntry;

  factory EventEntry.fromJson(Map<String, dynamic> json) =>
      _$EventEntryFromJson(json);
}
