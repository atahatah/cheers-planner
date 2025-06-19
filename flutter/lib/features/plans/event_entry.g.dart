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
          (v) => (v as List<dynamic>).map((e) => e as String).toList(),
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
      'candidateAreas': instance.candidateAreas,
      'allergiesEtc': instance.allergiesEtc,
      'organizerId': instance.organizerId,
      'participantId': instance.participantId,
    };

$Rec _$recordConvert<$Rec>(Object? value, $Rec Function(Map) convert) =>
    convert(value as Map<String, dynamic>);

_CandidateDateTime _$CandidateDateTimeFromJson(Map<String, dynamic> json) =>
    $checkedCreate('_CandidateDateTime', json, ($checkedConvert) {
      final val = _CandidateDateTime(
        id: $checkedConvert('id', (v) => v as String?),
        eventId: $checkedConvert('eventId', (v) => v as String?),
        start: $checkedConvert(
          'start',
          (v) => const DateTimeToTimestampConverter().fromJson(v),
        ),
        end: $checkedConvert(
          'end',
          (v) => const DateTimeToTimestampConverter().fromJson(v),
        ),
      );
      return val;
    });

Map<String, dynamic> _$CandidateDateTimeToJson(_CandidateDateTime instance) =>
    <String, dynamic>{
      'id': instance.id,
      'eventId': instance.eventId,
      'start': const DateTimeToTimestampConverter().toJson(instance.start),
      'end': const DateTimeToTimestampConverter().toJson(instance.end),
    };

_CandidateArea _$CandidateAreaFromJson(Map<String, dynamic> json) =>
    $checkedCreate('_CandidateArea', json, ($checkedConvert) {
      final val = _CandidateArea(
        id: $checkedConvert('id', (v) => v as String?),
        eventId: $checkedConvert('eventId', (v) => v as String?),
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
      'id': instance.id,
      'eventId': instance.eventId,
      'location': const GeoPointToJsonConverter().toJson(instance.location),
      'radius': instance.radius,
    };

_EventResult _$EventResultFromJson(Map<String, dynamic> json) =>
    $checkedCreate('_EventResult', json, ($checkedConvert) {
      final val = _EventResult(
        id: $checkedConvert('id', (v) => v as String?),
        eventId: $checkedConvert('eventId', (v) => v as String?),
        optimalDate: $checkedConvert(
          'optimalDate',
          (v) => const DateTimeToTimestampConverter().fromJson(v),
        ),
        optimalEnd: $checkedConvert(
          'optimalEnd',
          (v) => const DateTimeToTimestampConverter().fromJson(v),
        ),
      );
      return val;
    });

Map<String, dynamic> _$EventResultToJson(_EventResult instance) =>
    <String, dynamic>{
      'id': instance.id,
      'eventId': instance.eventId,
      'optimalDate': const DateTimeToTimestampConverter().toJson(
        instance.optimalDate,
      ),
      'optimalEnd': const DateTimeToTimestampConverter().toJson(
        instance.optimalEnd,
      ),
    };

_OptimalRestaurant _$OptimalRestaurantFromJson(Map<String, dynamic> json) =>
    $checkedCreate('_OptimalRestaurant', json, ($checkedConvert) {
      final val = _OptimalRestaurant(
        id: $checkedConvert('id', (v) => v as String?),
        eventId: $checkedConvert('eventId', (v) => v as String?),
        resultId: $checkedConvert('resultId', (v) => v as String?),
        name: $checkedConvert('name', (v) => v as String),
        formattedAddress: $checkedConvert(
          'formattedAddress',
          (v) => v as String,
        ),
        rating: $checkedConvert('rating', (v) => (v as num).toInt()),
        priceLevel: $checkedConvert('priceLevel', (v) => (v as num).toInt()),
        menuHighlights: $checkedConvert('menuHighlights', (v) => v as String),
        accessInfo: $checkedConvert('accessInfo', (v) => v as String),
        placeId: $checkedConvert('placeId', (v) => v as String),
      );
      return val;
    });

Map<String, dynamic> _$OptimalRestaurantToJson(_OptimalRestaurant instance) =>
    <String, dynamic>{
      'id': instance.id,
      'eventId': instance.eventId,
      'resultId': instance.resultId,
      'name': instance.name,
      'formattedAddress': instance.formattedAddress,
      'rating': instance.rating,
      'priceLevel': instance.priceLevel,
      'menuHighlights': instance.menuHighlights,
      'accessInfo': instance.accessInfo,
      'placeId': instance.placeId,
    };
