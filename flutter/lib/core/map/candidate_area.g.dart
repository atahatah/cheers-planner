// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'candidate_area.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_CandidateArea _$CandidateAreaFromJson(Map<String, dynamic> json) =>
    $checkedCreate('_CandidateArea', json, ($checkedConvert) {
      final val = _CandidateArea(
        latitude: $checkedConvert('latitude', (v) => (v as num).toDouble()),
        longitude: $checkedConvert('longitude', (v) => (v as num).toDouble()),
        radius: $checkedConvert('radius', (v) => (v as num).toDouble()),
      );
      return val;
    });

Map<String, dynamic> _$CandidateAreaToJson(_CandidateArea instance) =>
    <String, dynamic>{
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'radius': instance.radius,
    };
