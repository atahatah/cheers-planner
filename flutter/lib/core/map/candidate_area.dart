import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

part 'candidate_area.freezed.dart';
part 'candidate_area.g.dart';

@freezed
sealed class CandidateArea with _$CandidateArea {
  const factory CandidateArea({
    required double latitude,
    required double longitude,
    required double radius,
  }) = _CandidateArea;

  factory CandidateArea.fromJson(Map<String, dynamic> json) =>
      _$CandidateAreaFromJson(json);
}

extension CandidateAreaX on CandidateArea {
  LatLng get latLng => LatLng(latitude, longitude);
}
