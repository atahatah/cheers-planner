// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event_entry.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_EventEntry _$EventEntryFromJson(Map<String, dynamic> json) =>
    $checkedCreate('_EventEntry', json, ($checkedConvert) {
      final val = _EventEntry(
        id: $checkedConvert('id', (v) => v as String?),
        eventName: $checkedConvert('eventName', (v) => v as String),
        dueDate: $checkedConvert(
          'dueDate',
          (v) => const DateTimeToTimestampConverter().fromJson(v),
        ),
        candidateDateTimes: $checkedConvert(
          'candidateDateTimes',
          (v) => (v as List<dynamic>)
              .map(
                (e) => _$recordConvert(
                  e,
                  ($jsonValue) => (
                    DateTime.parse($jsonValue[r'$1'] as String),
                    DateTime.parse($jsonValue[r'$2'] as String),
                  ),
                ),
              )
              .toList(),
        ),
        candidateAreas: $checkedConvert(
          'candidateAreas',
          (v) => (v as List<dynamic>)
              .map((e) => CandidateArea.fromJson(e as Map<String, dynamic>))
              .toList(),
        ),
        allergiesEtc: $checkedConvert('allergiesEtc', (v) => v as String),
        organizerId: $checkedConvert(
          'organizerId',
          (v) => (v as List<dynamic>).map((e) => e as String).toList(),
        ),
        participantId: $checkedConvert(
          'participantId',
          (v) => (v as List<dynamic>).map((e) => e as String).toList(),
        ),
      );
      return val;
    });

Map<String, dynamic> _$EventEntryToJson(_EventEntry instance) =>
    <String, dynamic>{
      'id': instance.id,
      'eventName': instance.eventName,
      'dueDate': const DateTimeToTimestampConverter().toJson(instance.dueDate),
      'candidateDateTimes': instance.candidateDateTimes
          .map(
            (e) => <String, dynamic>{
              r'$1': e.$1.toIso8601String(),
              r'$2': e.$2.toIso8601String(),
            },
          )
          .toList(),
      'candidateAreas': instance.candidateAreas.map((e) => e.toJson()).toList(),
      'allergiesEtc': instance.allergiesEtc,
      'organizerId': instance.organizerId,
      'participantId': instance.participantId,
    };

$Rec _$recordConvert<$Rec>(Object? value, $Rec Function(Map) convert) =>
    convert(value as Map<String, dynamic>);
