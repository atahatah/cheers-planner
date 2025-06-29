// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'participant.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_EventParticipant _$EventParticipantFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('_EventParticipant', json, ($checkedConvert) {
  final val = _EventParticipant(
    id: $checkedConvert('id', (v) => v as String?),
    eventId: $checkedConvert('eventId', (v) => v as String?),
    phoneNumber: $checkedConvert('phoneNumber', (v) => v as String),
    positionOrGrade: $checkedConvert('positionOrGrade', (v) => v as String?),
    desiredBudget: $checkedConvert('desiredBudget', (v) => (v as num).toInt()),
    desiredDateTimes: $checkedConvert(
      'desiredDateTimes',
      (v) => const DateTimeListToTimestampListConverter().fromJson(v as List),
    ),
    desiredLocations: $checkedConvert(
      'desiredLocations',
      (v) => const GeoPointListToJsonConverter().fromJson(v as List<GeoPoint>),
    ),
    allergiesEtc: $checkedConvert('allergiesEtc', (v) => v as String),
    createdAt: $checkedConvert(
      'createdAt',
      (v) => const CreatedAtField().fromJson(v),
    ),
    updatedAt: $checkedConvert(
      'updatedAt',
      (v) => const UpdatedAtField().fromJson(v),
    ),
  );
  return val;
});

Map<String, dynamic> _$EventParticipantToJson(_EventParticipant instance) =>
    <String, dynamic>{
      'id': instance.id,
      'eventId': instance.eventId,
      'phoneNumber': instance.phoneNumber,
      'positionOrGrade': instance.positionOrGrade,
      'desiredBudget': instance.desiredBudget,
      'desiredDateTimes': const DateTimeListToTimestampListConverter().toJson(
        instance.desiredDateTimes,
      ),
      'desiredLocations': const GeoPointListToJsonConverter().toJson(
        instance.desiredLocations,
      ),
      'allergiesEtc': instance.allergiesEtc,
      'createdAt': const CreatedAtField().toJson(instance.createdAt),
      'updatedAt': const UpdatedAtField().toJson(instance.updatedAt),
    };
