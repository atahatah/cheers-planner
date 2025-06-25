import 'package:cheers_planner/core/api/google_places_repo.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final restaurantSearchServiceProvider = Provider<RestaurantSearchService>((
  ref,
) {
  final placesRepo = ref.watch(googlePlacesRepoProvider);
  return RestaurantSearchService(placesRepo);
});

class RestaurantSearchService {
  RestaurantSearchService(this._placesRepo);

  final GooglePlacesRepo _placesRepo;

  /// 場所候補から店舗を検索
  Future<List<Map<String, dynamic>>> searchRestaurantsForLocation({
    required Map<String, dynamic> locationCandidate,
    required Map<String, dynamic> eventData,
    List<String> keywords = const [],
  }) async {
    try {
      final center = locationCandidate['center'] as Map<String, dynamic>;
      final lat = center['lat'] as double;
      final lng = center['lng'] as double;
      final radius = (locationCandidate['radius'] as num).toDouble();
      final budgetUpperLimit = eventData['budgetUpperLimit'] as int;

      print(
        'Searching restaurants for location: ${locationCandidate['name']}',
      ); // Debug用
      print('Center: $lat, $lng, Radius: $radius'); // Debug用

      final allRestaurants = <Map<String, dynamic>>[];

      // 価格帯計算
      final maxPriceLevel = GooglePlacesRepo.calculatePriceLevel(
        budgetUpperLimit,
      );

      // 1. 基本検索（近隣検索）
      final nearbyResults = await _placesRepo.nearbySearch(
        lat: lat,
        lng: lng,
        radius: radius,
        keyword: '居酒屋 飲み会',
        maxprice: maxPriceLevel,
      );

      allRestaurants.addAll(nearbyResults);
      print('Nearby search results: ${nearbyResults.length}'); // Debug用

      // 2. キーワード検索
      final keywordsToSearch = keywords.isNotEmpty
          ? keywords
          : _getDefaultKeywords(eventData);

      for (final keyword in keywordsToSearch) {
        try {
          final textResults = await _placesRepo.textSearch(
            query: keyword,
            lat: lat,
            lng: lng,
            radius: radius,
            maxprice: maxPriceLevel,
          );
          allRestaurants.addAll(textResults);
          print(
            'Text search results for "$keyword": ${textResults.length}',
          ); // Debug用
        } catch (e) {
          print('Text search failed for keyword "$keyword": $e'); // Debug用
          // 個別キーワードの失敗は続行
        }
      }

      // 3. 重複除去
      final uniqueRestaurants = _removeDuplicates(allRestaurants);
      print(
        'Unique restaurants after deduplication: ${uniqueRestaurants.length}',
      ); // Debug用

      // 4. 基本情報抽出・ソート
      final processedRestaurants = uniqueRestaurants
          .map(GooglePlacesRepo.extractBasicInfo)
          .where(_isValidRestaurant)
          .toList();

      // 評価順でソート
      processedRestaurants.sort((a, b) {
        final ratingA = a['rating'] as double;
        final ratingB = b['rating'] as double;
        return ratingB.compareTo(ratingA);
      });

      // 上位15件まで
      final topRestaurants = processedRestaurants.take(15).toList();
      print('Final restaurant candidates: ${topRestaurants.length}'); // Debug用

      return topRestaurants;
    } catch (e) {
      throw RestaurantSearchException(
        'Restaurant search failed for location ${locationCandidate['name']}: $e',
      );
    }
  }

  /// 複数の場所候補から店舗を検索
  Future<Map<String, List<Map<String, dynamic>>>> searchAllLocations({
    required List<Map<String, dynamic>> locationCandidates,
    required Map<String, dynamic> eventData,
  }) async {
    final results = <String, List<Map<String, dynamic>>>{};

    for (final location in locationCandidates) {
      try {
        final restaurants = await searchRestaurantsForLocation(
          locationCandidate: location,
          eventData: eventData,
        );
        results[location['name'] as String] = restaurants;
      } catch (e) {
        print(
          'Failed to search restaurants for ${location['name']}: $e',
        ); // Debug用
        results[location['name'] as String] = [];
      }
    }

    return results;
  }

  /// デフォルトキーワード生成
  List<String> _getDefaultKeywords(Map<String, dynamic> eventData) {
    final purpose = eventData['purpose'] as String? ?? '';
    final budget = eventData['budgetUpperLimit'] as int? ?? 5000;

    final keywords = <String>[];

    // 目的に応じたキーワード
    if (purpose.contains('歓迎')) {
      keywords.addAll(['歓迎会 居酒屋', '新入社員 歓迎会', '歓迎 飲み会']);
    } else if (purpose.contains('送別')) {
      keywords.addAll(['送別会 居酒屋', '送別 飲み会']);
    } else if (purpose.contains('忘年')) {
      keywords.addAll(['忘年会 居酒屋', '忘年会 コース']);
    } else {
      keywords.addAll(['飲み会 居酒屋', '会社 飲み会']);
    }

    // 予算に応じたキーワード
    if (budget <= 3000) {
      keywords.addAll(['安い 居酒屋', '格安 飲み会']);
    } else if (budget >= 6000) {
      keywords.addAll(['おしゃれ 居酒屋', '高級 居酒屋']);
    }

    // 一般的なキーワード
    keywords.addAll(['個室 居酒屋', '飲み放題', 'コース料理']);

    return keywords.take(5).toList(); // 最大5個
  }

  /// 重複除去
  List<Map<String, dynamic>> _removeDuplicates(
    List<Map<String, dynamic>> restaurants,
  ) {
    final seen = <String>{};
    final unique = <Map<String, dynamic>>[];

    for (final restaurant in restaurants) {
      final placeId = restaurant['place_id'] as String?;
      if (placeId != null && !seen.contains(placeId)) {
        seen.add(placeId);
        unique.add(restaurant);
      }
    }

    return unique;
  }

  /// 有効なレストランかチェック
  bool _isValidRestaurant(Map<String, dynamic> restaurant) {
    final rating = restaurant['rating'] as double;
    final userRatingsTotal = restaurant['userRatingsTotal'] as int;

    // 評価が極端に低い、または評価数が少なすぎる場合は除外
    return rating >= 3.0 && userRatingsTotal >= 5;
  }
}

/// 店舗検索サービス関連の例外
class RestaurantSearchException implements Exception {
  RestaurantSearchException(this.message);
  final String message;

  @override
  String toString() => 'RestaurantSearchException: $message';
}
