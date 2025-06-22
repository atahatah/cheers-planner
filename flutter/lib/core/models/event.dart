import 'package:cheers_planner/core/firebase/firestore_converters.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'event.freezed.dart';
part 'event.g.dart';

@freezed
sealed class Event with _$Event {
  const factory Event({
    required String id,
    required List<String> organizerId,
    required String eventName,
    @DateTimeToTimestampConverter() required DateTime dueDate,
    required int minutes,
    required int budgetUpperLimit,
    required String purpose,
    required List<String> fixedQuestion,
    Map<String, CandidateDateTime>? candidateDateTimes,
    Map<String, CandidateArea>? candidateAreas,
    String? aiRecArea,
    @NullableDateTimeToTimestampConverter() DateTime? aiRecDate,
    List<String>? aiRecStore,
    @CreatedAtField() DateTime? createdAt,
    @UpdatedAtField() DateTime? updatedAt,
  }) = _Event;

  factory Event.fromJson(Map<String, dynamic> json) => _$EventFromJson(json);
}

@freezed
sealed class CandidateDateTime with _$CandidateDateTime {
  const factory CandidateDateTime({
    @DateTimeToTimestampConverter() required DateTime start,
    @DateTimeToTimestampConverter() required DateTime end,
  }) = _CandidateDateTime;

  factory CandidateDateTime.fromJson(Map<String, dynamic> json) =>
      _$CandidateDateTimeFromJson(json);
}

@freezed
sealed class CandidateArea with _$CandidateArea {
  const factory CandidateArea({
    @_GeoPointConverter() required GeoPoint center,
    required double radius,
  }) = _CandidateArea;

  factory CandidateArea.fromJson(Map<String, dynamic> json) =>
      _$CandidateAreaFromJson(json);
}

@freezed
sealed class Participant with _$Participant {
  const factory Participant({
    required String id,
    required String name,
    required String phoneNumber,
    required String positionOrGrade,
    required int desiredBudget,
    @_DateTimeListConverter() required List<DateTime> desiredDates,
    required List<String> desiredLocations,
    required String allergiesEtc,
    @DateTimeToTimestampConverter() required DateTime submittedAt,
    Map<String, FixedQuestionAnswer>? fixedQuestionAnswers,
    Map<String, CustomQuestionAnswer>? customQuestionAnswers,
    @CreatedAtField() DateTime? createdAt,
    @UpdatedAtField() DateTime? updatedAt,
  }) = _Participant;

  factory Participant.fromJson(Map<String, dynamic> json) =>
      _$ParticipantFromJson(json);
}

@freezed
sealed class FixedQuestionAnswer with _$FixedQuestionAnswer {
  const factory FixedQuestionAnswer({
    required String question,
    required String answer,
  }) = _FixedQuestionAnswer;

  factory FixedQuestionAnswer.fromJson(Map<String, dynamic> json) =>
      _$FixedQuestionAnswerFromJson(json);
}

@freezed
sealed class CustomQuestionAnswer with _$CustomQuestionAnswer {
  const factory CustomQuestionAnswer({
    required String question,
    required String answer,
  }) = _CustomQuestionAnswer;

  factory CustomQuestionAnswer.fromJson(Map<String, dynamic> json) =>
      _$CustomQuestionAnswerFromJson(json);
}

@freezed
sealed class EventResult with _$EventResult {
  const factory EventResult({
    @DateTimeToTimestampConverter() required DateTime optimalDate,
    @DateTimeToTimestampConverter() required DateTime optimalEnd,
    required List<Restaurant> restaurants,
    @CreatedAtField() DateTime? createdAt,
    @UpdatedAtField() DateTime? updatedAt,
  }) = _EventResult;

  factory EventResult.fromJson(Map<String, dynamic> json) =>
      _$EventResultFromJson(json);
}

@freezed
sealed class Restaurant with _$Restaurant {
  const factory Restaurant({
    required String name,
    required String formattedAddress,
    required double rating,
    required int priceLevel,
    required String menuHighlights,
    required String accessInfo,
    required String placeId,
  }) = _Restaurant;

  factory Restaurant.fromJson(Map<String, dynamic> json) =>
      _$RestaurantFromJson(json);
}

// DateTime ListのカスタムConverter
class _DateTimeListConverter
    implements JsonConverter<List<DateTime>, List<dynamic>> {
  const _DateTimeListConverter();

  @override
  List<DateTime> fromJson(List<dynamic> json) {
    return json.map((e) => (e as Timestamp).toDate()).toList();
  }

  @override
  List<dynamic> toJson(List<DateTime> object) {
    return object.map(Timestamp.fromDate).toList();
  }
}

class _GeoPointConverter
    implements JsonConverter<GeoPoint, Map<String, dynamic>> {
  const _GeoPointConverter();

  @override
  GeoPoint fromJson(Map<String, dynamic> json) {
    return GeoPoint(json['latitude'] as double, json['longitude'] as double);
  }

  @override
  Map<String, dynamic> toJson(GeoPoint geoPoint) {
    return {'latitude': geoPoint.latitude, 'longitude': geoPoint.longitude};
  }
}
