import 'package:cheers_planner/features/create/event_entry.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

AreasController useAreasSelection({double defaultRadius = 500}) {
  final areas = useState<List<CandidateArea>>([]);

  void add(LatLng pos) {
    areas.value = [
      ...areas.value,
      CandidateArea(
        location: GeoPoint(pos.latitude, pos.longitude),
        radius: defaultRadius.toInt(),
      ),
    ];
  }

  // Update radius by index
  void update(int index, double r) {
    areas.value = [
      for (var i = 0; i < areas.value.length; i++)
        i == index
            ? areas.value[i].copyWith(radius: r.toInt())
            : areas.value[i],
    ];
  }

  // Remove by index
  void remove(int index) {
    areas.value = [
      for (var i = 0; i < areas.value.length; i++)
        if (i != index) areas.value[i],
    ];
  }

  return AreasController(areas.value, add, update, remove);
}

class AreasController {
  const AreasController(this.areas, this.add, this.update, this.remove);
  final List<CandidateArea> areas;
  final void Function(LatLng) add;
  final void Function(int, double) update;
  final void Function(int) remove;
}
