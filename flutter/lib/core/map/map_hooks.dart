import 'package:cheers_planner/core/map/candidate_area.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class CandidateAreaController {
  CandidateAreaController(this._areas);

  final ValueNotifier<List<CandidateArea>> _areas;

  List<CandidateArea> get areas => _areas.value;

  void add(LatLng latLng, double radius) {
    _areas.value = [
      ..._areas.value,
      CandidateArea(
        latitude: latLng.latitude,
        longitude: latLng.longitude,
        radius: radius,
      ),
    ];
  }

  void removeAt(int index) {
    final list = [..._areas.value]..removeAt(index);
    _areas.value = list;
  }
}

CandidateAreaController useCandidateAreas() {
  final areas = useState<List<CandidateArea>>([]);
  return CandidateAreaController(areas);
}
