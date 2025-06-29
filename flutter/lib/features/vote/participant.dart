import 'package:cheers_planner/core/firebase/firestore_converters.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'participant.freezed.dart';
part 'participant.g.dart';

@freezed
sealed class EventParticipant with _$EventParticipant {
  const factory EventParticipant({
    String? id,
    String? eventId,
    required String phoneNumber,
    required String? positionOrGrade,
    required int desiredBudget,
    @DateTimeListToTimestampListConverter()
    required List<DateTime> desiredDateTimes,
    @GeoPointListToJsonConverter() required List<GeoPoint> desiredLocations,
    required String allergiesEtc,
    @CreatedAtField() DateTime? createdAt,
    @UpdatedAtField() DateTime? updatedAt,
  }) = _EventParticipant;
  factory EventParticipant.fromJson(Map<String, dynamic> json) =>
      _$EventParticipantFromJson(json);
}
