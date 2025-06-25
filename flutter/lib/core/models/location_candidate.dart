import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'location_candidate.freezed.dart';
part 'location_candidate.g.dart';

@freezed
sealed class LocationCandidate with _$LocationCandidate {
  const factory LocationCandidate({
    required String name,
    required LocationCenter center,
    required double radius,
    required String reason,
    required String suitableFor,
  }) = _LocationCandidate;

  factory LocationCandidate.fromJson(Map<String, dynamic> json) =>
      _$LocationCandidateFromJson(json);
}

@freezed
sealed class LocationCenter with _$LocationCenter {
  const factory LocationCenter({required double lat, required double lng}) =
      _LocationCenter;

  // Freezedクラスにメソッドを追加する場合の正しい構文
  const LocationCenter._();

  factory LocationCenter.fromJson(Map<String, dynamic> json) =>
      _$LocationCenterFromJson(json);

  // GeoPointに変換するためのヘルパー
  GeoPoint toGeoPoint() => GeoPoint(lat, lng);
}

@freezed
sealed class LocationCandidateRequest with _$LocationCandidateRequest {
  const factory LocationCandidateRequest({
    required List<String> desiredLocations,
    required List<String> participantPositions,
    required int budgetUpperLimit,
    required String purpose,
    required List<String> specialConsiderations,
  }) = _LocationCandidateRequest;

  factory LocationCandidateRequest.fromJson(Map<String, dynamic> json) =>
      _$LocationCandidateRequestFromJson(json);
}
