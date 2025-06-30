// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event_entry.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_EventEntry _$EventEntryFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('_EventEntry', json, ($checkedConvert) {
  final val = _EventEntry(
    id: $checkedConvert('id', (v) => v as String?),
    aiResults: $checkedConvert('aiResults', (v) => v as Map<String, dynamic>?),
    purpose: $checkedConvert('purpose', (v) => v as String),
    candidateDateTimes: $checkedConvert(
      'candidateDateTimes',
      (v) => (v as List<dynamic>)
          .map((e) => CandidateDateTime.fromJson(e as Map<String, dynamic>))
          .toList(),
    ),
    allergiesEtc: $checkedConvert('allergiesEtc', (v) => v as String?),
    organizerId: $checkedConvert(
      'organizerId',
      (v) => (v as List<dynamic>).map((e) => e as String).toList(),
    ),
    participantId: $checkedConvert(
      'participantId',
      (v) =>
          (v as List<dynamic>?)?.map((e) => e as String).toList() ?? const [],
    ),
    budgetUpperLimit: $checkedConvert(
      'budgetUpperLimit',
      (v) => (v as num).toInt(),
    ),
    fixedQuestion: $checkedConvert(
      'fixedQuestion',
      (v) => (v as List<dynamic>).map((e) => e as String).toList(),
    ),
    minutes: $checkedConvert('minutes', (v) => (v as num).toInt()),
  );
  return val;
});

Map<String, dynamic> _$EventEntryToJson(_EventEntry instance) =>
    <String, dynamic>{
      'id': instance.id,
      'aiResults': instance.aiResults,
      'purpose': instance.purpose,
      'candidateDateTimes': instance.candidateDateTimes
          .map((e) => e.toJson())
          .toList(),
      'allergiesEtc': instance.allergiesEtc,
      'organizerId': instance.organizerId,
      'participantId': instance.participantId,
      'budgetUpperLimit': instance.budgetUpperLimit,
      'fixedQuestion': instance.fixedQuestion,
      'minutes': instance.minutes,
    };

_CandidateDateTime _$CandidateDateTimeFromJson(Map<String, dynamic> json) =>
    $checkedCreate('_CandidateDateTime', json, ($checkedConvert) {
      final val = _CandidateDateTime(
        start: $checkedConvert(
          'start',
          (v) => const DateTimeToTimestampConverter().fromJson(v),
        ),
      );
      return val;
    });

Map<String, dynamic> _$CandidateDateTimeToJson(_CandidateDateTime instance) =>
    <String, dynamic>{
      'start': const DateTimeToTimestampConverter().toJson(instance.start),
    };

_CandidateArea _$CandidateAreaFromJson(Map<String, dynamic> json) =>
    $checkedCreate('_CandidateArea', json, ($checkedConvert) {
      final val = _CandidateArea(
        location: $checkedConvert(
          'location',
          (v) => const GeoPointToJsonConverter().fromJson(v as GeoPoint),
        ),
        radius: $checkedConvert('radius', (v) => (v as num).toInt()),
      );
      return val;
    });

Map<String, dynamic> _$CandidateAreaToJson(_CandidateArea instance) =>
    <String, dynamic>{
      'location': const GeoPointToJsonConverter().toJson(instance.location),
      'radius': instance.radius,
    };
