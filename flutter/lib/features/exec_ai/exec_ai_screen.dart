import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ExecAiScreen extends StatefulWidget {
  const ExecAiScreen({super.key, this.eventId});

  final String? eventId;

  @override
  State<ExecAiScreen> createState() => _ExecAiScreenState();
}

class _ExecAiScreenState extends State<ExecAiScreen> {
  var _isLoadingStep1 = false;
  var _isLoadingStep2 = false;
  var _isLoadingStep3 = false;
  var _isLoadingStep4 = false;
  var _isLoadingAllSteps = false;

  String? _eventId;
  Map<String, dynamic>? _eventData;
  var _isInitializing = true;

  List<dynamic>? _locationCandidates;
  List<String>? _keywords;
  Map<String, dynamic>? _restaurantResults;
  Map<String, dynamic>? _optimizedResults;

  // エミュレータ使用フラグに基づいてFirebase Functionsインスタンスを設定
  static const useEmulators = bool.fromEnvironment('USE_FIREBASE_EMULATORS');
  late final FirebaseFunctions functions;

  @override
  void initState() {
    super.initState();
    // エミュレータ使用時はリージョン指定なし、本番環境時はリージョン指定
    if (useEmulators) {
      functions = FirebaseFunctions.instance;
      debugPrint('🔧 Using Firebase Functions Emulator (no region)');
    } else {
      functions = FirebaseFunctions.instanceFor(region: 'asia-northeast1');
      debugPrint('🌐 Using Firebase Functions Production (asia-northeast1)');
    }
    _loadInitialData();
  }

  Future<void> _loadInitialData() async {
    setState(() {
      _isInitializing = true;
    });
    try {
      // widget.eventIdが存在する場合はそれを使用、そうでなければ_getTestEventIdを呼び出し
      final eventId = widget.eventId ?? await _getTestEventId();
      if (eventId != null) {
        final eventDoc = await FirebaseFirestore.instance
            .collection('events')
            .doc(eventId)
            .get();
        if (eventDoc.exists) {
          setState(() {
            _eventId = eventId;
            _eventData = eventDoc.data();
          });
        } else {
          throw Exception('Event ID "$eventId"が見つかりましたが、ドキュメントの取得に失敗しました。');
        }
      } else {
        setState(() {
          _eventId = null;
          _eventData = null;
        });
      }
    } catch (e) {
      if (mounted) {
        _showErrorDialog('イベント読み込み', e.toString());
      }
    } finally {
      if (mounted) {
        setState(() {
          _isInitializing = false;
        });
      }
    }
  }

  Future<void> _executeAllSteps() async {
    setState(() {
      _isLoadingAllSteps = true;
    });

    try {
      await _executeStep1();
      if (_locationCandidates == null) {
        throw Exception('Step 1 (場所候補生成) に失敗したため、処理を中断しました。');
      }

      await _executeStep2();
      if (_keywords == null) {
        throw Exception('Step 2 (キーワード生成) に失敗したため、処理を中断しました。');
      }

      await _executeStep3();
      if (_restaurantResults == null) {
        throw Exception('Step 3 (レストラン検索) に失敗したため、処理を中断しました。');
      }

      await _executeStep4();
      if (_optimizedResults == null) {
        throw Exception('Step 4 (レストラン選択最適化) に失敗しました。');
      }

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('全てのステップが正常に完了しました。'),
            backgroundColor: Colors.green,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        _showErrorDialog('一括実行エラー', e.toString());
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoadingAllSteps = false;
        });
      }
    }
  }

  // Step 1: 場所候補生成
  Future<void> _executeStep1() async {
    setState(() {
      _isLoadingStep1 = true;
    });

    try {
      if (_eventId == null) {
        throw Exception('テストイベントが見つかりません');
      }

      debugPrint('Using eventId for step1: $_eventId');

      final callable = functions.httpsCallable(
        'generateLocationCandidatesStep',
      );
      final result = await callable.call({'eventId': _eventId});

      debugPrint('Step1 result: ${result.data}');

      final data = result.data as Map<String, dynamic>;

      if (data['success'] == true) {
        setState(() {
          _locationCandidates = data['locationCandidates'] as List<dynamic>;
        });

        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('場所候補を ${_locationCandidates!.length} 件生成しました'),
              backgroundColor: Colors.green,
            ),
          );
        }
      } else {
        throw Exception('場所候補の生成に失敗しました: ${data['message'] ?? '不明なエラー'}');
      }
    } catch (e) {
      debugPrint('Step1 error: $e');
      if (mounted) {
        _showErrorDialog('場所候補生成', e.toString());
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoadingStep1 = false;
        });
      }
    }
  }

  // Step 2: キーワード生成
  Future<void> _executeStep2() async {
    setState(() {
      _isLoadingStep2 = true;
    });

    try {
      if (_eventId == null) {
        throw Exception('テストイベントが見つかりません');
      }

      final callable = functions.httpsCallable('generateKeywordsStep');
      final result = await callable.call({'eventId': _eventId});
      final data = result.data as Map<String, dynamic>;

      if (data['success'] == true) {
        setState(() {
          _keywords = List<String>.from(data['keywords'] as List<dynamic>);
        });

        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('検索キーワードを ${_keywords!.length} 個生成しました'),
              backgroundColor: Colors.green,
            ),
          );
        }
      } else {
        throw Exception('キーワードの生成に失敗しました');
      }
    } catch (e) {
      if (mounted) {
        _showErrorDialog('キーワード生成', e.toString());
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoadingStep2 = false;
        });
      }
    }
  }

  // Step 3: レストラン検索
  Future<void> _executeStep3() async {
    setState(() {
      _isLoadingStep3 = true;
    });

    try {
      if (_eventId == null) {
        throw Exception('テストイベントが見つかりません');
      }

      final callable = functions.httpsCallable('searchRestaurantsStep');
      final result = await callable.call({'eventId': _eventId});
      final data = result.data as Map<String, dynamic>;

      if (data['success'] == true) {
        setState(() {
          _restaurantResults =
              data['restaurantSearchResults'] as Map<String, dynamic>;
        });

        final totalRestaurants = _calculateRestaurantCount(_restaurantResults!);

        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('レストランを $totalRestaurants 件検索しました'),
              backgroundColor: Colors.green,
            ),
          );
        }
      } else {
        throw Exception('レストラン検索に失敗しました');
      }
    } catch (e) {
      if (mounted) {
        _showErrorDialog('レストラン検索', e.toString());
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoadingStep3 = false;
        });
      }
    }
  }

  // Step 4: レストラン選択最適化
  Future<void> _executeStep4() async {
    setState(() {
      _isLoadingStep4 = true;
    });

    try {
      if (_eventId == null) {
        throw Exception('テストイベントが見つかりません');
      }

      final callable = functions.httpsCallable('optimizeRestaurantsStep');
      final result = await callable.call({'eventId': _eventId});
      final data = result.data as Map<String, dynamic>;

      if (data['success'] == true) {
        setState(() {
          _optimizedResults = data['optimizedResults'] as Map<String, dynamic>;
        });

        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('レストラン選択最適化が完了しました'),
              backgroundColor: Colors.green,
            ),
          );
        }
      } else {
        throw Exception('レストラン選択最適化に失敗しました');
      }
    } catch (e) {
      debugPrint('Step4 Error: $e');
      if (mounted) {
        _showErrorDialog('レストラン選択最適化', e.toString());
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoadingStep4 = false;
        });
      }
    }
  }

  Future<String?> _getTestEventId() async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) return null;

      final userId = user.uid;

      // まずtest-event-123が存在するかチェック
      const testEventId = 'test-event-123';
      final testEventDoc = await FirebaseFirestore.instance
          .collection('events')
          .doc(testEventId)
          .get();

      if (testEventDoc.exists) {
        debugPrint('Found test-event-123, using it directly');
        return testEventId;
      }

      debugPrint('test-event-123 not found, searching for user events...');

      // ユーザーが関連するイベントを探す
      final eventsSnapshot = await FirebaseFirestore.instance
          .collection('events')
          .where('organizerId', arrayContains: userId)
          .limit(1)
          .get();

      if (eventsSnapshot.docs.isNotEmpty) {
        debugPrint('Found event as organizer: ${eventsSnapshot.docs.first.id}');
        return eventsSnapshot.docs.first.id;
      }

      // 幹事でない場合、参加者として参加しているイベントを探す
      final allEventsSnapshot = await FirebaseFirestore.instance
          .collection('events')
          .limit(10)
          .get();

      debugPrint(
        'Checking ${allEventsSnapshot.docs.length} events for participation...',
      );

      for (final eventDoc in allEventsSnapshot.docs) {
        final participantsSnapshot = await eventDoc.reference
            .collection('participants')
            .where('userId', isEqualTo: userId)
            .limit(1)
            .get();

        if (participantsSnapshot.docs.isNotEmpty) {
          debugPrint('Found event as participant: ${eventDoc.id}');
          return eventDoc.id;
        }
      }

      // 最後の手段：利用可能な任意のイベントを使用
      if (allEventsSnapshot.docs.isNotEmpty) {
        final firstEventId = allEventsSnapshot.docs.first.id;
        debugPrint('Using first available event: $firstEventId');
        return firstEventId;
      }

      debugPrint('No events found at all');
      return null;
    } catch (e) {
      debugPrint('Error getting test event ID: $e');
      return null;
    }
  }

  void _showErrorDialog(String step, String error) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('$step エラー'),
        content: Text('$step中にエラーが発生しました:\n$error'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('閉じる'),
          ),
        ],
      ),
    );
  }

  void _showDetailDialog() {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        child: Container(
          width: MediaQuery.of(context).size.width * 0.9,
          height: MediaQuery.of(context).size.height * 0.8,
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'AI分析結果',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: const Icon(Icons.close),
                  ),
                ],
              ),
              Expanded(
                child: DefaultTabController(
                  length: 4,
                  child: Column(
                    children: [
                      const TabBar(
                        tabs: [
                          Tab(text: '場所候補'),
                          Tab(text: 'キーワード'),
                          Tab(text: 'レストラン'),
                          Tab(text: '最適化結果'),
                        ],
                      ),
                      Expanded(
                        child: TabBarView(
                          children: [
                            _buildLocationCandidatesResult(),
                            _buildKeywordsResult(),
                            _buildRestaurantsResult(),
                            _buildOptimizedResultsResult(),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLocationCandidatesResult() {
    if (_locationCandidates == null) {
      return const Center(child: Text('場所候補がまだ生成されていません'));
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: _locationCandidates!.map((candidateData) {
        final candidate = candidateData as Map<String, dynamic>;
        return Card(
          margin: const EdgeInsets.symmetric(vertical: 4),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  (candidate['name'] as String?) ?? 'Unknown',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text('理由: ${(candidate['reason'] as String?) ?? 'N/A'}'),
                Text('適合層: ${(candidate['suitableFor'] as String?) ?? 'N/A'}'),
                Text('半径: ${candidate['radius'] ?? 'N/A'}m'),
                if (candidate['center'] != null)
                  Text(
                    '座標: ${candidate['center']['lat']}, ${candidate['center']['lng']}',
                  ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildKeywordsResult() {
    if (_keywords == null) {
      return const Center(child: Text('キーワードがまだ生成されていません'));
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: _keywords!
              .map(
                (keyword) => Chip(
                  label: Text(keyword),
                  backgroundColor: Colors.blue.shade100,
                ),
              )
              .toList(),
        ),
      ],
    );
  }

  Widget _buildRestaurantsResult() {
    if (_restaurantResults == null) {
      return const Center(child: Text('レストランがまだ検索されていません'));
    }

    return Column(
      children: _restaurantResults!.entries.map((entry) {
        final locationName = entry.key;
        final restaurantsData = entry.value;

        // IdentityMap対応: 安全なデータ変換
        final restaurants = _convertToSafeList(restaurantsData);

        return Card(
          margin: const EdgeInsets.only(bottom: 16),
          child: ExpansionTile(
            title: Text(
              locationName,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text('${restaurants.length} 件のレストラン'),
            children: [
              // 各レストランの詳細表示
              ...restaurants.asMap().entries.map((restaurantEntry) {
                final index = restaurantEntry.key;
                final restaurant = restaurantEntry.value;

                return _buildSimpleRestaurantCard(index, restaurant);
              }),
            ],
          ),
        );
      }).toList(),
    );
  }

  Widget _buildSimpleRestaurantCard(int index, dynamic restaurant) {
    debugPrint('[Step3] SimpleRestaurantCard data: $restaurant');
    if (restaurant is! Map<String, dynamic>) {
      return Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('レストランデータエラー: ${restaurant.runtimeType}'),
            Text('内容: ${restaurant.toString().substring(0, 100)}...'),
          ],
        ),
      );
    }

    final restaurantMap = restaurant;
    final name = (restaurantMap['name'] as String?) ?? 'Unknown';
    final rating = restaurantMap['rating'] ?? 0;
    final priceLevel = restaurantMap['priceLevel'];
    final address =
        _getSafeString(restaurantMap['vicinity']) ??
        _getSafeString(restaurantMap['formattedAddress']) ??
        'N/A';
    final placeId = restaurantMap['placeId'] as String?;
    final phoneNumber = restaurantMap['phoneNumber'] as String?;

    // レビュー分析データの取得
    final reviewAnalysis =
        restaurantMap['reviewAnalysis'] as Map<String, dynamic>?;
    final goodPoints = reviewAnalysis?['goodPoints'] as List<dynamic>? ?? [];
    final badPoints = reviewAnalysis?['badPoints'] as List<dynamic>? ?? [];
    final totalReviewCount = (restaurantMap['userRatingsTotal'] as int?) ?? 0;

    // menuHighlightsの安全な取得
    final menuHighlightsData = restaurantMap['menuHighlights'];
    final List<dynamic> menuHighlights;
    if (menuHighlightsData is List) {
      menuHighlights = menuHighlightsData;
    } else if (menuHighlightsData is String) {
      menuHighlights = [menuHighlightsData];
    } else {
      menuHighlights = [];
    }

    // メニューハイライト
    final accessInfo = _getSafeString(restaurantMap['accessInfo']);

    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(8),
        color: Colors.grey.shade50,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // レストラン名とランキング
          Row(
            children: [
              Container(
                width: 30,
                height: 30,
                decoration: BoxDecoration(
                  color: index == 0 ? Colors.blue : Colors.grey,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Text(
                    '${index + 1}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    if (totalReviewCount > 0)
                      Text(
                        'レビュー数: $totalReviewCount件',
                        style: TextStyle(
                          color: Colors.blue.shade600,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),

          // 基本情報
          Row(
            children: [
              const Icon(Icons.star, color: Colors.orange, size: 16),
              const SizedBox(width: 4),
              Text('評価: $rating'),
              const SizedBox(width: 16),
              const Icon(Icons.attach_money, color: Colors.green, size: 16),
              const SizedBox(width: 4),
              Text('価格帯: ${_formatPriceLevel(priceLevel)}'),
            ],
          ),
          const SizedBox(height: 8),
          Text('住所: $address', style: TextStyle(color: Colors.grey.shade600)),
          const SizedBox(height: 8),

          // メニューハイライト
          if (menuHighlights.isNotEmpty) ...[
            const Row(
              children: [
                Icon(Icons.restaurant_menu, color: Colors.orange, size: 16),
                SizedBox(width: 4),
                Text(
                  'メニューハイライト (AI要約):',
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
              ],
            ),
            const SizedBox(height: 4),
            ...menuHighlights.map(
              (highlight) => Padding(
                padding: const EdgeInsets.only(left: 20, bottom: 2),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      '・',
                      style: TextStyle(
                        color: Colors.orange,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Expanded(
                      child: Text(
                        highlight.toString(),
                        style: const TextStyle(fontSize: 12),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 8),
          ],

          // アクセス情報
          if (accessInfo != null) ...[
            const Row(
              children: [
                Icon(Icons.directions, color: Colors.blue, size: 16),
                SizedBox(width: 4),
                Text('アクセス:', style: TextStyle(fontWeight: FontWeight.w600)),
              ],
            ),
            const SizedBox(height: 4),
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Text(
                accessInfo,
                style: TextStyle(fontSize: 12, color: Colors.grey[600]),
              ),
            ),
            const SizedBox(height: 8),
          ],

          // Google Mapリンクと電話番号
          Row(
            children: [
              // Google Mapリンク
              if (placeId != null) ...[
                Material(
                  color: Colors.transparent,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(4),
                    onTap: () => _openGoogleMap(placeId),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 150),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.blue.shade50,
                        borderRadius: BorderRadius.circular(4),
                        border: Border.all(color: Colors.blue.shade200),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.map,
                            color: Colors.blue.shade700,
                            size: 16,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            'マップ',
                            style: TextStyle(
                              color: Colors.blue.shade700,
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
              ],
              // 電話番号
              if (phoneNumber != null) ...[
                Row(
                  children: [
                    Icon(Icons.phone, color: Colors.green.shade700, size: 16),
                    const SizedBox(width: 4),
                    SelectableText(
                      phoneNumber,
                      style: TextStyle(
                        color: Colors.green.shade700,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ],
            ],
          ),
          const SizedBox(height: 16),

          // 良い点（AIによる分析）
          if (goodPoints.isNotEmpty) ...[
            const Row(
              children: [
                Icon(Icons.thumb_up, color: Colors.green, size: 16),
                SizedBox(width: 8),
                Text('良い点', style: TextStyle(fontWeight: FontWeight.bold)),
              ],
            ),
            const SizedBox(height: 8),
            ...goodPoints
                .take(15)
                .map(
                  (review) => Padding(
                    padding: const EdgeInsets.only(left: 24, bottom: 4),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('• ', style: TextStyle(color: Colors.green)),
                        Expanded(
                          child: Text(
                            review.toString(),
                            style: const TextStyle(fontSize: 12),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
            const SizedBox(height: 12),
          ],

          // 懸念点（AIによる分析）
          if (badPoints.isNotEmpty) ...[
            const Row(
              children: [
                Icon(Icons.warning, color: Colors.orange, size: 16),
                SizedBox(width: 8),
                Text('懸念点', style: TextStyle(fontWeight: FontWeight.bold)),
              ],
            ),
            const SizedBox(height: 8),
            ...badPoints
                .take(15)
                .map(
                  (review) => Padding(
                    padding: const EdgeInsets.only(left: 24, bottom: 4),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          '• ',
                          style: TextStyle(color: Colors.orange),
                        ),
                        Expanded(
                          child: Text(
                            review.toString(),
                            style: const TextStyle(fontSize: 12),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
          ],

          // レビューがない場合の表示
          if (goodPoints.isEmpty && badPoints.isEmpty) ...[
            Row(
              children: [
                const Icon(Icons.info, color: Colors.grey, size: 16),
                const SizedBox(width: 8),
                Text(
                  'レビュー情報なし',
                  style: TextStyle(
                    color: Colors.grey.shade600,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildOptimizedResultsResult() {
    if (_optimizedResults == null) {
      return const Center(child: Text('最適化結果がまだ生成されていません'));
    }

    final locationRankings =
        _optimizedResults!['locationRankings'] as Map<String, dynamic>? ?? {};
    final overallRecommendation =
        _optimizedResults!['overallRecommendation'] as Map<String, dynamic>?;

    return Column(
      children: [
        // 総合推奨の表示
        if (overallRecommendation != null &&
            overallRecommendation['bestChoice'] != null) ...[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 4, bottom: 8),
                child: Row(
                  children: [
                    Icon(Icons.star, color: Colors.green.shade700, size: 24),
                    const SizedBox(width: 8),
                    Text(
                      '総合おすすめ',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.green.shade700,
                      ),
                    ),
                  ],
                ),
              ),
              _buildRestaurantCard(
                0, // 総合1位なのでindexは0
                overallRecommendation['bestChoice']['restaurant'],
              ),
            ],
          ),
          const SizedBox(height: 16),
        ],

        // 駅別ランキング表示
        Text(
          '駅別ランキング',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.blue.shade800,
          ),
        ),
        const SizedBox(height: 12),

        // IdentityMap対応: 安全なentries処理
        ...(() {
          // IdentityMapやMapの場合
          return locationRankings.keys.map((locationName) {
            final locationData = locationRankings[locationName];
            if (locationData is Map<String, dynamic>) {
              return _buildLocationRankingCard(locationName, locationData);
            } else {
              return Card(
                margin: const EdgeInsets.only(bottom: 16),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Text('$locationName: データ形式エラー'),
                ),
              );
            }
          });
        })(),
      ],
    );
  }

  Widget _buildLocationRankingCard(
    String locationName,
    Map<String, dynamic> locationData,
  ) {
    // topRestaurantsの安全な取得
    final topRestaurantsData = locationData['topRestaurants'];

    if (topRestaurantsData == null) {
      return Card(
        margin: const EdgeInsets.only(bottom: 16),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Text('$locationName: データがありません'),
        ),
      );
    }

    // 型チェックとエラーハンドリング
    if (topRestaurantsData is! List) {
      debugPrint(
        '⚠️ topRestaurantsData is not List: ${topRestaurantsData.runtimeType}',
      );
      debugPrint('⚠️ topRestaurantsData content: $topRestaurantsData');

      return Card(
        margin: const EdgeInsets.only(bottom: 16),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('$locationName: データ形式エラー'),
              Text('期待: List, 実際: ${topRestaurantsData.runtimeType}'),
              if (topRestaurantsData is Map)
                Text('データ内容: ${topRestaurantsData.keys.join(", ")}'),
              const SizedBox(height: 8),
              Text('詳細: ${topRestaurantsData.toString().substring(0, 100)}...'),
            ],
          ),
        ),
      );
    }

    final topRestaurants = topRestaurantsData;

    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: ExpansionTile(
        title: Text(
          locationName,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text('${topRestaurants.length} 件の推奨店舗'),
        children: [
          // 各レストランの詳細表示
          ...topRestaurants.asMap().entries.map((restaurantEntry) {
            final index = restaurantEntry.key;
            final restaurant = restaurantEntry.value;

            return _buildRestaurantCard(index, restaurant);
          }),
        ],
      ),
    );
  }

  Widget _buildRestaurantCard(int index, dynamic restaurant) {
    debugPrint('[Step4] OptimizedRestaurantCard data: $restaurant');
    debugPrint('🔍 Building restaurant card for index $index');
    debugPrint('🔍 Restaurant type: ${restaurant.runtimeType}');
    debugPrint(
      '🔍 Restaurant content: ${restaurant.toString().substring(0, 200)}...',
    );

    if (restaurant is! Map<String, dynamic>) {
      return Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('レストランデータエラー: ${restaurant.runtimeType}'),
            Text('内容: ${restaurant.toString().substring(0, 100)}...'),
          ],
        ),
      );
    }

    final restaurantMap = restaurant;
    final restaurantData =
        restaurantMap['restaurant'] as Map<String, dynamic>? ?? {};
    final totalScore = restaurantMap['totalScore'] ?? 0;

    debugPrint('🔍 RestaurantMap keys: ${restaurantMap.keys.toList()}');
    debugPrint('🔍 RestaurantData keys: ${restaurantData.keys.toList()}');

    // アピールポイントの安全な取得
    final appealPointsData = restaurantMap['appealPoints'];
    debugPrint('🔍 AppealPoints type: ${appealPointsData.runtimeType}');
    final appealPoints = (appealPointsData is List)
        ? appealPointsData.cast<String>()
        : <String>[];

    // 懸念点の安全な取得
    final concernsData = restaurantMap['concerns'];
    debugPrint('🔍 Concerns type: ${concernsData.runtimeType}');
    final concerns = (concernsData is List)
        ? concernsData.cast<String>()
        : <String>[];

    // restaurantDataから各種情報を取得
    final accessInfo = _getSafeString(restaurantData['accessInfo']);
    final reviewAnalysis =
        restaurantData['reviewAnalysis'] as Map<String, dynamic>?;
    final goodPoints = reviewAnalysis?['goodPoints'] as List<dynamic>? ?? [];
    final badPoints = reviewAnalysis?['badPoints'] as List<dynamic>? ?? [];
    final totalReviewCount = (restaurantData['userRatingsTotal'] as int?) ?? 0;

    // menuHighlightsの安全な取得
    final menuHighlightsData = restaurantData['menuHighlights'];
    final List<dynamic> menuHighlights;
    if (menuHighlightsData is List) {
      menuHighlights = menuHighlightsData;
    } else if (menuHighlightsData is String) {
      menuHighlights = [menuHighlightsData];
    } else {
      menuHighlights = [];
    }

    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(8),
        color: index == 0 ? Colors.blue.shade50 : Colors.grey.shade50,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ランキングとレストラン名
          Row(
            children: [
              Container(
                width: 30,
                height: 30,
                decoration: BoxDecoration(
                  color: index == 0 ? Colors.blue : Colors.grey,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Text(
                    '${index + 1}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      (restaurantData['name'] as String?) ?? 'Unknown',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      '総合スコア: $totalScore点',
                      style: TextStyle(
                        color: Colors.blue.shade600,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),

          // 基本情報
          Row(
            children: [
              const Icon(Icons.star, color: Colors.orange, size: 16),
              const SizedBox(width: 4),
              Text('評価: ${restaurantData['rating'] ?? 'N/A'}'),
              const SizedBox(width: 16),
              const Icon(Icons.attach_money, color: Colors.green, size: 16),
              const SizedBox(width: 4),
              Text('価格帯: ${_formatPriceLevel(restaurantData['priceLevel'])}'),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            '住所: ${restaurantData['vicinity'] ?? restaurantData['formattedAddress'] ?? 'N/A'}',
            style: TextStyle(color: Colors.grey.shade600),
          ),
          const SizedBox(height: 8),

          // メニューハイライト
          if (menuHighlights.isNotEmpty) ...[
            const Row(
              children: [
                Icon(Icons.restaurant_menu, color: Colors.orange, size: 16),
                SizedBox(width: 4),
                Text(
                  'メニューハイライト (AI要約):',
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
              ],
            ),
            const SizedBox(height: 4),
            ...menuHighlights.map(
              (highlight) => Padding(
                padding: const EdgeInsets.only(left: 20, bottom: 2),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      '・',
                      style: TextStyle(
                        color: Colors.orange,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Expanded(
                      child: Text(
                        highlight.toString(),
                        style: const TextStyle(fontSize: 12),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 8),
          ],

          // アクセス情報
          if (accessInfo != null) ...[
            const Row(
              children: [
                Icon(Icons.directions, color: Colors.blue, size: 16),
                SizedBox(width: 4),
                Text('アクセス:', style: TextStyle(fontWeight: FontWeight.w600)),
              ],
            ),
            const SizedBox(height: 4),
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Text(
                accessInfo,
                style: TextStyle(fontSize: 12, color: Colors.grey[600]),
              ),
            ),
            const SizedBox(height: 8),
          ],

          // Google Mapリンクと電話番号
          Row(
            children: [
              // Google Mapリンク
              if (restaurantData['placeId'] != null) ...[
                Material(
                  color: Colors.transparent,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(4),
                    onTap: () =>
                        _openGoogleMap(restaurantData['placeId'] as String),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 150),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.blue.shade50,
                        borderRadius: BorderRadius.circular(4),
                        border: Border.all(color: Colors.blue.shade200),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.map,
                            color: Colors.blue.shade700,
                            size: 16,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            'マップ',
                            style: TextStyle(
                              color: Colors.blue.shade700,
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
              ],
              // 電話番号
              if (restaurantData['phoneNumber'] != null) ...[
                Row(
                  children: [
                    Icon(Icons.phone, color: Colors.green.shade700, size: 16),
                    const SizedBox(width: 4),
                    SelectableText(
                      restaurantData['phoneNumber'] as String,
                      style: TextStyle(
                        color: Colors.green.shade700,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ],
            ],
          ),
          const SizedBox(height: 16),

          // アピールポイント
          if (appealPoints.isNotEmpty) ...[
            const Row(
              children: [
                Icon(Icons.thumb_up, color: Colors.green, size: 16),
                SizedBox(width: 8),
                Text('アピールポイント', style: TextStyle(fontWeight: FontWeight.bold)),
              ],
            ),
            const SizedBox(height: 8),
            ...appealPoints.map(
              (point) => Padding(
                padding: const EdgeInsets.only(left: 24, bottom: 4),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('• ', style: TextStyle(color: Colors.green)),
                    Expanded(child: Text(point)),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 12),
          ],

          // 懸念点
          if (concerns.isNotEmpty) ...[
            const Row(
              children: [
                Icon(Icons.warning, color: Colors.orange, size: 16),
                SizedBox(width: 8),
                Text('懸念点', style: TextStyle(fontWeight: FontWeight.bold)),
              ],
            ),
            const SizedBox(height: 8),
            ...concerns.map(
              (concern) => Padding(
                padding: const EdgeInsets.only(left: 24, bottom: 4),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('• ', style: TextStyle(color: Colors.orange)),
                    Expanded(child: Text(concern)),
                  ],
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  String? _getSafeString(dynamic value) {
    return value?.toString();
  }

  /// 価格帯を分かりやすい表示に変換
  String _formatPriceLevel(dynamic priceLevel) {
    if (priceLevel == null) return '情報なし';

    final int level;
    if (priceLevel is int) {
      level = priceLevel;
    } else if (priceLevel is String) {
      level = int.tryParse(priceLevel) ?? -1;
    } else if (priceLevel is double) {
      level = priceLevel.toInt();
    } else {
      return '情報なし';
    }

    switch (level) {
      case 0:
      case 1:
        return '安価';
      case 2:
        return 'お手頃';
      case 3:
      case 4:
        return '高価';
      default:
        return '情報なし';
    }
  }

  /// IdentityMap対応の安全な件数集計ユーティリティ
  int _countItemsSafely(dynamic data) {
    if (data is List) {
      return data.length;
    } else if (data is Map) {
      return data.values.length;
    } else {
      return data != null ? 1 : 0;
    }
  }

  /// レストラン検索結果の総件数を計算
  int _calculateRestaurantCount(Map<String, dynamic> results) {
    var totalCount = 0;
    for (final restaurants in results.values) {
      totalCount += _countItemsSafely(restaurants);
    }
    return totalCount;
  }

  /// 最適化結果の総件数を計算
  int _calculateOptimizedCount(Map<String, dynamic> results) {
    var totalCount = 0;
    final locationRankings = results['locationRankings'];
    if (locationRankings is Map) {
      for (final locationData in locationRankings.values) {
        if (locationData is Map && locationData['topRestaurants'] != null) {
          totalCount += _countItemsSafely(locationData['topRestaurants']);
        }
      }
    }
    return totalCount;
  }

  /// IdentityMap対応のレストランデータ変換
  List<dynamic> _convertToSafeList(dynamic data) {
    if (data is List) {
      return List<dynamic>.from(data);
    } else if (data is Map) {
      return data.values.toList();
    } else {
      return data != null ? [data] : [];
    }
  }

  /// Google Mapでレストランを開く (Flutter Web専用)
  Future<void> _openGoogleMap(String placeId) async {
    try {
      // Google MapsのURL（Place IDを使用）
      final googleMapsUrl =
          'https://www.google.com/maps/place/?q=place_id:$placeId';

      final uri = Uri.parse(googleMapsUrl);
      // webOnlyWindowNameを使用して新しいタブで開く
      await launchUrl(uri, webOnlyWindowName: '_blank');
      debugPrint('✅ Google Maps opened: $googleMapsUrl');
    } catch (e) {
      debugPrint('❌ Error opening Google Maps: $e');
      _showErrorSnackBar('Google Mapを開けませんでした');
    }
  }

  /// エラー用スナックバー表示
  void _showErrorSnackBar(String message) {
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: Colors.red,
          duration: const Duration(seconds: 3),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('AI分析実行')),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                'AI分析を段階的に実行します',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 32),

              if (_isInitializing)
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 32),
                  child: Center(child: CircularProgressIndicator()),
                )
              else
                _buildEventSummaryCard(),

              const SizedBox(height: 16),
              ElevatedButton.icon(
                onPressed: (_isLoadingAllSteps || _eventId == null)
                    ? null
                    : _executeAllSteps,
                icon: _isLoadingAllSteps
                    ? const SizedBox(
                        width: 24,
                        height: 24,
                        child: CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 3,
                        ),
                      )
                    : const Icon(Icons.rocket_launch),
                label: const Text('全ステップを連続実行'),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  backgroundColor: Colors.deepPurple,
                  foregroundColor: Colors.white,
                  textStyle: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // Step 1: 場所候補生成
              Card(
                elevation: 2,
                margin: const EdgeInsets.only(bottom: 16),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 24,
                            height: 24,
                            decoration: BoxDecoration(
                              color: _locationCandidates != null
                                  ? Colors.green
                                  : Colors.grey,
                              shape: BoxShape.circle,
                            ),
                            child: const Center(
                              child: Text(
                                '1',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          const Text(
                            '場所候補生成',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      const Text('参加者情報から最適な場所候補を生成します'),
                      const SizedBox(height: 12),
                      ElevatedButton(
                        onPressed:
                            (_isLoadingStep1 ||
                                _isLoadingAllSteps ||
                                _eventId == null)
                            ? null
                            : _executeStep1,
                        child: _isLoadingStep1
                            ? const SizedBox(
                                width: 20,
                                height: 20,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                ),
                              )
                            : const Text('場所候補を生成'),
                      ),
                      if (_locationCandidates != null)
                        Padding(
                          padding: const EdgeInsets.only(top: 16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Divider(),
                              const SizedBox(height: 8),
                              _buildLocationCandidatesResult(),
                            ],
                          ),
                        ),
                    ],
                  ),
                ),
              ),

              // Step 2: キーワード生成
              Card(
                elevation: 2,
                margin: const EdgeInsets.only(bottom: 16),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 24,
                            height: 24,
                            decoration: BoxDecoration(
                              color: _keywords != null
                                  ? Colors.green
                                  : Colors.grey,
                              shape: BoxShape.circle,
                            ),
                            child: const Center(
                              child: Text(
                                '2',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          const Text(
                            'キーワード生成',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      const Text('レストラン検索用のキーワードを生成します'),
                      const SizedBox(height: 12),
                      ElevatedButton(
                        onPressed:
                            (_isLoadingStep2 ||
                                _isLoadingAllSteps ||
                                _locationCandidates == null ||
                                _eventId == null)
                            ? null
                            : _executeStep2,
                        child: _isLoadingStep2
                            ? const SizedBox(
                                width: 20,
                                height: 20,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                ),
                              )
                            : const Text('キーワードを生成'),
                      ),
                      if (_keywords != null)
                        Padding(
                          padding: const EdgeInsets.only(top: 16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Divider(),
                              const SizedBox(height: 8),
                              const Text(
                                '生成されたキーワード:',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(height: 8),
                              _buildKeywordsResult(),
                            ],
                          ),
                        ),
                    ],
                  ),
                ),
              ),

              // Step 3: レストラン検索
              Card(
                elevation: 2,
                margin: const EdgeInsets.only(bottom: 16),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 24,
                            height: 24,
                            decoration: BoxDecoration(
                              color: _restaurantResults != null
                                  ? Colors.green
                                  : Colors.grey,
                              shape: BoxShape.circle,
                            ),
                            child: const Center(
                              child: Text(
                                '3',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          const Text(
                            'レストラン検索',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      const Text('生成された場所候補からレストランを検索します'),
                      const SizedBox(height: 12),
                      ElevatedButton(
                        onPressed:
                            (_isLoadingStep3 ||
                                _isLoadingAllSteps ||
                                _keywords == null ||
                                _eventId == null)
                            ? null
                            : _executeStep3,
                        child: _isLoadingStep3
                            ? const SizedBox(
                                width: 20,
                                height: 20,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                ),
                              )
                            : const Text('レストランを検索'),
                      ),
                      if (_restaurantResults != null)
                        Padding(
                          padding: const EdgeInsets.only(top: 16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Divider(),
                              const SizedBox(height: 8),
                              const Text(
                                '検索結果:',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(height: 8),
                              _buildRestaurantsResult(),
                            ],
                          ),
                        ),
                    ],
                  ),
                ),
              ),

              // Step 4: レストラン選択最適化
              Card(
                elevation: 2,
                margin: const EdgeInsets.only(bottom: 16),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 24,
                            height: 24,
                            decoration: BoxDecoration(
                              color: _optimizedResults != null
                                  ? Colors.green
                                  : Colors.grey,
                              shape: BoxShape.circle,
                            ),
                            child: const Center(
                              child: Text(
                                '4',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          const Text(
                            'レストラン選択最適化',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      const Text('生成されたレストランを最適化します'),
                      const SizedBox(height: 12),
                      ElevatedButton(
                        onPressed:
                            (_isLoadingStep4 ||
                                _isLoadingAllSteps ||
                                _restaurantResults == null ||
                                _eventId == null)
                            ? null
                            : _executeStep4,
                        child: _isLoadingStep4
                            ? const SizedBox(
                                width: 20,
                                height: 20,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                ),
                              )
                            : const Text('レストランを最適化'),
                      ),
                      if (_optimizedResults != null)
                        Padding(
                          padding: const EdgeInsets.only(top: 16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Divider(),
                              const SizedBox(height: 8),
                              const Text(
                                '最適化結果:',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(height: 8),
                              _buildOptimizedResultsResult(),
                            ],
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEventSummaryCard() {
    if (_eventData == null) {
      return Card(
        elevation: 2,
        color: Colors.amber.shade100,
        margin: const EdgeInsets.only(bottom: 24),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Icon(Icons.warning_amber_rounded, color: Colors.amber.shade800),
              const SizedBox(width: 12),
              const Expanded(
                child: Text('分析対象のイベントが見つかりません。\nデバッグメニューからテストデータを作成してください。'),
              ),
            ],
          ),
        ),
      );
    }

    final purpose = _eventData!['purpose'] ?? '目的未設定';
    final budget = _eventData!['budgetUpperLimit'] ?? 0;

    return Card(
      elevation: 2,
      margin: const EdgeInsets.only(bottom: 24),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'イベント概要',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const Divider(height: 20),
            _buildSummaryRow(Icons.flag, 'イベント名', purpose.toString()),
            _buildSummaryRow(Icons.wallet_giftcard, '予算（上限）', '$budget 円/人'),
            if (_eventId != null)
              _buildSummaryRow(Icons.vpn_key, 'イベントID', _eventId!),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryRow(IconData icon, String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 18, color: Colors.grey.shade600),
          const SizedBox(width: 12),
          SizedBox(
            width: 90,
            child: Text(
              title,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }

  Future<void> _testFirebaseConnection() async {
    try {
      const testEventId = 'test-event-123';

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Firebase接続テスト開始...'),
          duration: Duration(seconds: 1),
        ),
      );

      // Event情報を取得テスト
      final eventDoc = FirebaseFirestore.instance
          .collection('events')
          .doc(testEventId);
      final eventSnapshot = await eventDoc.get();

      debugPrint('=== Firebase Debug Info ===');
      debugPrint('Event exists: ${eventSnapshot.exists}');
      if (eventSnapshot.exists) {
        debugPrint('Event data: ${eventSnapshot.data()}');
      }

      // Participants情報を取得テスト
      final participantsCollection = FirebaseFirestore.instance
          .collection('events')
          .doc(testEventId)
          .collection('participants');
      final participantsSnapshot = await participantsCollection.get();

      debugPrint('Participants count: ${participantsSnapshot.docs.length}');
      for (final doc in participantsSnapshot.docs) {
        debugPrint('Participant ${doc.id}: ${doc.data()}');
      }

      if (!mounted) return;

      final message = eventSnapshot.exists
          ? 'Event発見! 参加者: ${participantsSnapshot.docs.length}人'
          : 'Event未発見 (テストデータなし)';

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Firebase接続成功!\n$message'),
          duration: const Duration(seconds: 3),
          backgroundColor: Colors.green,
        ),
      );
    } catch (e) {
      debugPrint('Firebase connection error: $e');
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Firebase接続エラー: $e'),
          duration: const Duration(seconds: 3),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  Future<void> _createTestData() async {
    try {
      const testEventId = 'test-event-lab-party';
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        throw Exception('ログインしていません');
      }

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('研究室飲み会テストデータ作成中...'),
          duration: Duration(seconds: 1),
        ),
      );

      // --- Participants データ準備 ---
      final positions = [
        '教授',
        '准教授',
        '博士課程3年',
        '博士課程1年',
        '修士2年',
        '修士2年',
        '修士2年',
        '修士1年',
        '修士1年',
        '修士1年',
        '学部4年',
        '学部4年',
        '学部4年',
        '学部4年',
        '研究生',
      ];
      final names = [
        '佐藤 大輔',
        '鈴木 健一',
        '高橋 優子',
        '田中 雅彦',
        '渡辺 恵',
        '伊藤 誠',
        '山本 沙織',
        '中村 浩',
        '小林 あゆみ',
        '加藤 龍平',
        '吉田 直樹',
        '山田 香織',
        '佐々木 翼',
        '山口 拓也',
        '松本 美咲',
      ];
      final participantUids = List.generate(
        positions.length,
        (i) => 'participant-user-id-$i',
      );

      // --- Event データ作成 ---
      final eventData = {
        'organizerId': [user.uid],
        'participantId': participantUids, // 参加者のUIDリストを追加
        'eventName': '情報工学研究室 歓迎会',
        'dueDate': Timestamp.now(),
        'minutes': 120,
        'budgetUpperLimit': 6000,
        'purpose': '新メンバー歓迎会',
        'fixedQuestion': ['アレルギーはありますか？', '二次会は参加しますか？'],
        'candidateDateTimes': [
          // List<Map> 形式に変更
          {
            'start': Timestamp.fromDate(
              DateTime.now().add(const Duration(days: 14, hours: 19)),
            ),
          },
          {
            'start': Timestamp.fromDate(
              DateTime.now().add(const Duration(days: 15, hours: 18)),
            ),
          },
        ],
        'candidateAreas': {
          'area1': {
            'center': const GeoPoint(35.6909, 139.7003),
            'radius': 1500,
          },
        },
        'createdAt': FieldValue.serverTimestamp(),
        'updatedAt': FieldValue.serverTimestamp(),
      };

      await FirebaseFirestore.instance
          .collection('events')
          .doc(testEventId)
          .set(eventData);
      debugPrint('✅ Event created: $testEventId');

      // --- Participants サブコレクション作成 ---
      final desiredLocationsList = [
        ['新宿', '渋谷'],
        ['新宿西口', '個室'],
        ['渋谷', '居酒屋'],
        ['新宿', '和食'],
        ['渋谷', 'おしゃれ'],
        ['新宿三丁目'],
        ['渋谷', '肉'],
        ['新宿', '魚'],
        ['渋谷', '野菜'],
        ['新宿'],
        ['渋谷'],
        ['新宿', '安い'],
        ['渋谷', '飲み放題'],
        ['新宿', '駅近'],
        ['渋谷', '静か'],
      ];
      final allergiesList = [
        '特になし',
        '甲殻類アレルギー',
        '特になし',
        'そばアレルギー',
        '特になし',
        '特になし',
        'ナッツ類に注意',
        '特になし',
        '特になし',
        '特になし',
        '特になし',
        '特になし',
        '特になし',
        '生卵が苦手',
        '特になし',
      ];

      final participantsCollection = FirebaseFirestore.instance
          .collection('events')
          .doc(testEventId)
          .collection('participants');

      for (var i = 0; i < positions.length; i++) {
        final participantData = {
          'name': names[i],
          'phoneNumber': '090-1234-${i.toString().padLeft(4, '0')}',
          'positionOrGrade': positions[i],
          'desiredBudget': 5000 + (i % 3 - 1) * 500, // 4500, 5000, 5500
          'desiredLocations': desiredLocationsList[i],
          'desiredDates': [
            Timestamp.fromDate(
              DateTime.now().add(const Duration(days: 14, hours: 19)),
            ),
          ],
          'allergiesEtc': allergiesList[i],
          // List<Map>形式に変更
          'fixedQuestionAnswers': [
            {'question': 'アレルギーはありますか？', 'answer': allergiesList[i]},
            {'question': '二次会は参加しますか？', 'answer': i.isEven ? '参加します' : '未定です'},
          ],
          'customQuestionAnswers': [
            {'question': '好きな料理のジャンルは？', 'answer': i.isEven ? '和食' : '中華'},
          ],
          'submittedAt': Timestamp.now(),
          'updatedAt': FieldValue.serverTimestamp(),
        };
        // ドキュメントIDをUIDに変更
        await participantsCollection
            .doc(participantUids[i])
            .set(participantData);
      }
      debugPrint('✅ ${positions.length} participants created.');

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            '研究室飲み会データ作成完了! ($testEventId)\n'
            'Eventと${positions.length}人の参加者を作成しました',
          ),
          backgroundColor: Colors.green,
        ),
      );
    } catch (e) {
      debugPrint('Test data creation error: $e');
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('テストデータ作成エラー: $e'),
          duration: const Duration(seconds: 3),
          backgroundColor: Colors.red,
        ),
      );
    }
  }
}
