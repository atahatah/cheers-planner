// lib/location_util.dart
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

Future<LatLng?> getCurrentLatLng() async {
  var perm = await Geolocator.checkPermission();
  if (perm == LocationPermission.denied) {
    perm = await Geolocator.requestPermission();
  }
  if (perm == LocationPermission.deniedForever ||
      perm == LocationPermission.denied) {
    return null; // 拒否
  }
  final pos = await Geolocator.getCurrentPosition(
    desiredAccuracy: LocationAccuracy.high,
  );
  return LatLng(pos.latitude, pos.longitude);
}
