import 'package:cheers_planner/core/firebase/firestore_converters.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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
    required List<String> candidateAreas,
    required String allergiesEtc,
    required List<String> organizerId,
    required List<String> participantId,
  }) = _EventEntry;

  factory EventEntry.fromJson(Map<String, dynamic> json) =>
      _$EventEntryFromJson(json);
}

@freezed
sealed class CandidateDateTime with _$CandidateDateTime {
  const factory CandidateDateTime({
    String? id,
    String? eventId,
    @DateTimeToTimestampConverter() required DateTime start,
    @DateTimeToTimestampConverter() required DateTime end,
  }) = _CandidateDateTime;

  factory CandidateDateTime.fromJson(Map<String, dynamic> json) =>
      _$CandidateDateTimeFromJson(json);
}

@freezed
sealed class CandidateArea with _$CandidateArea {
  const factory CandidateArea({
    String? id,
    String? eventId,
    @GeoPointToJsonConverter() required GeoPoint location,

    /// 半径 m
    required int radius,
  }) = _CandidateArea;

  factory CandidateArea.fromJson(Map<String, dynamic> json) =>
      _$CandidateAreaFromJson(json);
}

@freezed
sealed class EventResult with _$EventResult {
  const factory EventResult({
    String? id,
    String? eventId,
    @DateTimeToTimestampConverter() required DateTime optimalDate,
    @DateTimeToTimestampConverter() required DateTime optimalEnd,
  }) = _EventResult;

  factory EventResult.fromJson(Map<String, dynamic> json) =>
      _$EventResultFromJson(json);
}

@freezed
sealed class OptimalRestaurant with _$OptimalRestaurant {
  const factory OptimalRestaurant({
    String? id,
    String? eventId,
    String? resultId,
    required String name,
    required String formattedAddress,
    required int rating,
    required int priceLevel,
    required String menuHighlights,
    required String accessInfo,
    required String placeId,
  }) = _OptimalRestaurant;

  factory OptimalRestaurant.fromJson(Map<String, dynamic> json) =>
      _$OptimalRestaurantFromJson(json);
}
