import 'package:cheers_planner/core/firebase/firestore_converters.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'event_entry.freezed.dart';
part 'event_entry.g.dart';

@freezed
sealed class EventEntry with _$EventEntry {
  const factory EventEntry({
    String? id,
    Map<String, dynamic>? aiResults,
    required String purpose,
    @ListToMapConverter<CandidateDateTime>(prefix: 'datetime')
    required List<CandidateDateTime> candidateDateTimes,
    required String? allergiesEtc,
    required List<String> organizerId,
    @Default([]) List<String> participantId,
    required int budgetUpperLimit,
    required List<String> fixedQuestion,
    required int minutes,
  }) = _EventEntry;

  factory EventEntry.fromJson(Map<String, dynamic> json) =>
      _$EventEntryFromJson(json);
}

@freezed
sealed class CandidateDateTime with _$CandidateDateTime {
  const factory CandidateDateTime({
    @DateTimeToTimestampConverter() required DateTime start,
  }) = _CandidateDateTime;

  factory CandidateDateTime.fromJson(Map<String, dynamic> json) =>
      _$CandidateDateTimeFromJson(json);
}

@freezed
sealed class CandidateArea with _$CandidateArea {
  const factory CandidateArea({
    @GeoPointToJsonConverter() required GeoPoint location,

    /// 半径 m
    required int radius,
  }) = _CandidateArea;

  factory CandidateArea.fromJson(Map<String, dynamic> json) =>
      _$CandidateAreaFromJson(json);
}
