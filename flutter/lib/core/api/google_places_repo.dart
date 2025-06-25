import 'dart:convert';
import 'dart:js_interop';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:http/http.dart' as http;

// JavaScript グローバル変数にアクセス
@JS('self.GOOGLE_PLACES_API_KEY')
external String? get googlePlacesApiKey;

final googlePlacesRepoProvider = Provider<GooglePlacesRepo>((ref) {
  return GooglePlacesRepo();
});

class GooglePlacesRepo {
  static const _baseUrl = 'https://maps.googleapis.com/maps/api/place';

  String get _apiKey {
    // JavaScriptのグローバル変数にアクセス
    String? key;

    try {
      key = googlePlacesApiKey;
    } catch (e) {
      print('⚠️ Error accessing window.GOOGLE_PLACES_API_KEY: $e');
    }

    print(
      '🔑 Checking API key from JS global: ${key != null ? 'Found' : 'Not found'}',
    );

    if (key == null || key.isEmpty) {
      throw GooglePlacesException(
        'Google Places API key not found. Please ensure GOOGLE_PLACES_API_KEY is set in your .env file.',
      );
    }
    return key;
  }

  /// テキスト検索（レストランをキーワードで検索）
  Future<List<Map<String, dynamic>>> textSearch({
    required String query,
    required double lat,
    required double lng,
    required double radius,
    int? minprice,
    int? maxprice,
  }) async {
    try {
      final url = Uri.parse('$_baseUrl/textsearch/json').replace(
        queryParameters: {
          'query': query,
          'location': '$lat,$lng',
          'radius': radius.round().toString(),
          'type': 'restaurant',
          'language': 'ja',
          'key': _apiKey,
          if (minprice != null) 'minprice': minprice.toString(),
          if (maxprice != null) 'maxprice': maxprice.toString(),
        },
      );

      print('Places API Text Search: $url'); // Debug用

      final response = await http.get(url);

      if (response.statusCode != 200) {
        throw GooglePlacesException(
          'HTTP ${response.statusCode}: ${response.body}',
        );
      }

      final data = json.decode(response.body) as Map<String, dynamic>;

      if (data['status'] != 'OK') {
        throw GooglePlacesException(
          'Places API Error: ${data['status']} - ${data['error_message'] ?? 'Unknown error'}',
        );
      }

      final results = data['results'] as List<dynamic>;
      return results.cast<Map<String, dynamic>>();
    } catch (e) {
      if (e is GooglePlacesException) rethrow;
      throw GooglePlacesException('Text search failed: $e');
    }
  }

  /// 近隣検索（座標周辺のレストランを検索）
  Future<List<Map<String, dynamic>>> nearbySearch({
    required double lat,
    required double lng,
    required double radius,
    String keyword = '',
    int? minprice,
    int? maxprice,
  }) async {
    try {
      final url = Uri.parse('$_baseUrl/nearbysearch/json').replace(
        queryParameters: {
          'location': '$lat,$lng',
          'radius': radius.round().toString(),
          'type': 'restaurant',
          'language': 'ja',
          'key': _apiKey,
          if (keyword.isNotEmpty) 'keyword': keyword,
          if (minprice != null) 'minprice': minprice.toString(),
          if (maxprice != null) 'maxprice': maxprice.toString(),
        },
      );

      print('Places API Nearby Search: $url'); // Debug用

      final response = await http.get(url);

      if (response.statusCode != 200) {
        throw GooglePlacesException(
          'HTTP ${response.statusCode}: ${response.body}',
        );
      }

      final data = json.decode(response.body) as Map<String, dynamic>;

      if (data['status'] != 'OK') {
        throw GooglePlacesException(
          'Places API Error: ${data['status']} - ${data['error_message'] ?? 'Unknown error'}',
        );
      }

      final results = data['results'] as List<dynamic>;
      return results.cast<Map<String, dynamic>>();
    } catch (e) {
      if (e is GooglePlacesException) rethrow;
      throw GooglePlacesException('Nearby search failed: $e');
    }
  }

  /// 店舗詳細情報取得
  Future<Map<String, dynamic>> getPlaceDetails(String placeId) async {
    try {
      final url = Uri.parse('$_baseUrl/details/json').replace(
        queryParameters: {
          'place_id': placeId,
          'fields': [
            'name',
            'formatted_address',
            'formatted_phone_number',
            'website',
            'rating',
            'user_ratings_total',
            'price_level',
            'opening_hours',
            'photos',
            'reviews',
            'geometry',
            'types',
          ].join(','),
          'language': 'ja',
          'key': _apiKey,
        },
      );

      print('Places API Details: $placeId'); // Debug用

      final response = await http.get(url);

      if (response.statusCode != 200) {
        throw GooglePlacesException(
          'HTTP ${response.statusCode}: ${response.body}',
        );
      }

      final data = json.decode(response.body) as Map<String, dynamic>;

      if (data['status'] != 'OK') {
        throw GooglePlacesException(
          'Places API Error: ${data['status']} - ${data['error_message'] ?? 'Unknown error'}',
        );
      }

      return data['result'] as Map<String, dynamic>;
    } catch (e) {
      if (e is GooglePlacesException) rethrow;
      throw GooglePlacesException('Place details failed: $e');
    }
  }

  /// 価格帯計算（予算から Google Places の price_level に変換）
  static int calculatePriceLevel(int budgetPerPerson) {
    if (budgetPerPerson <= 2000) return 1; // $
    if (budgetPerPerson <= 4000) return 2; // $$
    if (budgetPerPerson <= 6000) return 3; // $$$
    return 4; // $$$$
  }

  /// Places APIレスポンスから基本情報を抽出
  static Map<String, dynamic> extractBasicInfo(Map<String, dynamic> place) {
    final geometry = place['geometry'] as Map<String, dynamic>?;
    final location = geometry?['location'] as Map<String, dynamic>?;

    return {
      'placeId': place['place_id'] as String,
      'name': place['name'] as String,
      'formattedAddress':
          place['formatted_address'] as String? ??
          place['vicinity'] as String? ??
          '',
      'location': {
        'lat': location?['lat'] as double? ?? 0.0,
        'lng': location?['lng'] as double? ?? 0.0,
      },
      'rating': (place['rating'] as num?)?.toDouble() ?? 0.0,
      'userRatingsTotal': place['user_ratings_total'] as int? ?? 0,
      'priceLevel': place['price_level'] as int? ?? 0,
      'businessStatus': place['business_status'] as String?,
      'types': place['types'] as List<dynamic>?,
      'vicinity': place['vicinity'] as String?,
    };
  }
}

/// Google Places API関連の例外
class GooglePlacesException implements Exception {
  GooglePlacesException(this.message);
  final String message;

  @override
  String toString() => 'GooglePlacesException: $message';
}
