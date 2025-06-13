import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'map_repo.g.dart';

@riverpod
MapRepo mapRepo(Ref ref) {
  // TODO: Replace with your actual Google Maps API key.
  return const MapRepo(apiKey: 'YOUR_GOOGLE_MAPS_API_KEY');
}

class MapRepo {
  const MapRepo({required this.apiKey});

  final String apiKey;
}
