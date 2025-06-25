// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'location_candidate.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_LocationCandidate _$LocationCandidateFromJson(Map<String, dynamic> json) =>
    $checkedCreate('_LocationCandidate', json, ($checkedConvert) {
      final val = _LocationCandidate(
        name: $checkedConvert('name', (v) => v as String),
        center: $checkedConvert(
          'center',
          (v) => LocationCenter.fromJson(v as Map<String, dynamic>),
        ),
        radius: $checkedConvert('radius', (v) => (v as num).toDouble()),
        reason: $checkedConvert('reason', (v) => v as String),
        suitableFor: $checkedConvert('suitableFor', (v) => v as String),
      );
      return val;
    });

Map<String, dynamic> _$LocationCandidateToJson(_LocationCandidate instance) =>
    <String, dynamic>{
      'name': instance.name,
      'center': instance.center.toJson(),
      'radius': instance.radius,
      'reason': instance.reason,
      'suitableFor': instance.suitableFor,
    };

_LocationCenter _$LocationCenterFromJson(Map<String, dynamic> json) =>
    $checkedCreate('_LocationCenter', json, ($checkedConvert) {
      final val = _LocationCenter(
        lat: $checkedConvert('lat', (v) => (v as num).toDouble()),
        lng: $checkedConvert('lng', (v) => (v as num).toDouble()),
      );
      return val;
    });

Map<String, dynamic> _$LocationCenterToJson(_LocationCenter instance) =>
    <String, dynamic>{'lat': instance.lat, 'lng': instance.lng};

_LocationCandidateRequest _$LocationCandidateRequestFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('_LocationCandidateRequest', json, ($checkedConvert) {
  final val = _LocationCandidateRequest(
    desiredLocations: $checkedConvert(
      'desiredLocations',
      (v) => (v as List<dynamic>).map((e) => e as String).toList(),
    ),
    participantPositions: $checkedConvert(
      'participantPositions',
      (v) => (v as List<dynamic>).map((e) => e as String).toList(),
    ),
    budgetUpperLimit: $checkedConvert(
      'budgetUpperLimit',
      (v) => (v as num).toInt(),
    ),
    purpose: $checkedConvert('purpose', (v) => v as String),
    specialConsiderations: $checkedConvert(
      'specialConsiderations',
      (v) => (v as List<dynamic>).map((e) => e as String).toList(),
    ),
  );
  return val;
});

Map<String, dynamic> _$LocationCandidateRequestToJson(
  _LocationCandidateRequest instance,
) => <String, dynamic>{
  'desiredLocations': instance.desiredLocations,
  'participantPositions': instance.participantPositions,
  'budgetUpperLimit': instance.budgetUpperLimit,
  'purpose': instance.purpose,
  'specialConsiderations': instance.specialConsiderations,
};
