import 'package:cheers_planner/features/create/event_entry.dart';
import 'package:cheers_planner/features/create/event_entry_repo.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

class ResultScreen extends HookConsumerWidget {
  const ResultScreen({super.key, required this.eventId});
  final String eventId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncEventEntry = ref.watch(eventEntryProvider(eventId));
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('投票結果'),
        backgroundColor: theme.colorScheme.primaryContainer,
      ),
      body: switch (asyncEventEntry) {
        AsyncLoading() => const Center(child: CircularProgressIndicator()),
        AsyncError(:final error, stackTrace: _) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.error_outline,
                size: 64,
                color: theme.colorScheme.error,
              ),
              const SizedBox(height: 16),
              Text(
                'エラーが発生しました',
                style: theme.textTheme.titleMedium?.copyWith(
                  color: theme.colorScheme.error,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                '$error',
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.colorScheme.outline,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
        AsyncData(:final value) => _buildResultBody(context, value, theme),
        _ => const SizedBox.shrink(),
      },
    );
  }

  Widget _buildResultBody(
    BuildContext context,
    EventEntry event,
    ThemeData theme,
  ) {
    // EventEntryのaiResultsフィールドからAI分析結果を取得
    final aiResults = event.aiResults;
    final hasAiResults = aiResults != null;
    final isOptimizationCompleted =
        aiResults?['status'] == 'optimization_completed';
    final optimizedResults =
        aiResults?['optimizedResults'] as Map<String, dynamic>?;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // イベント概要カード
          _buildEventSummaryCard(event, theme),
          const SizedBox(height: 24),

          // 分析状況
          _buildAnalysisStatusCard(
            hasAiResults,
            isOptimizationCompleted,
            theme,
          ),
          const SizedBox(height: 24),

          // AI分析結果の表示
          if (isOptimizationCompleted && optimizedResults != null) ...[
            _buildOverallRecommendationCard(optimizedResults, theme),
            const SizedBox(height: 24),
            _buildLocationRankingsCard(optimizedResults, theme),
          ] else if (hasAiResults) ...[
            _buildPartialResultsCard(aiResults, theme),
          ] else ...[
            _buildNoResultsCard(theme),
          ],
        ],
      ),
    );
  }

  Widget _buildEventSummaryCard(EventEntry event, ThemeData theme) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.event, color: theme.colorScheme.primary),
                const SizedBox(width: 8),
                Text(
                  'イベント概要',
                  style: theme.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            _buildInfoRow(
              icon: Icons.flag,
              label: 'イベント名',
              value: event.purpose,
              theme: theme,
            ),
            const SizedBox(height: 8),
            _buildInfoRow(
              icon: Icons.schedule,
              label: '所要時間',
              value: '${event.minutes}分',
              theme: theme,
            ),
            const SizedBox(height: 8),
            _buildInfoRow(
              icon: Icons.payments,
              label: '予算上限',
              value:
                  '¥${NumberFormat('#,###').format(event.budgetUpperLimit)}/人',
              theme: theme,
            ),
            const SizedBox(height: 8),
            _buildInfoRow(
              icon: Icons.group,
              label: '投票者数',
              value: '${event.participantId.length}人',
              theme: theme,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAnalysisStatusCard(
    bool hasAiResults,
    bool isOptimizationCompleted,
    ThemeData theme,
  ) {
    Color statusColor;
    IconData statusIcon;
    String statusText;
    String description;

    if (isOptimizationCompleted) {
      statusColor = Colors.green;
      statusIcon = Icons.check_circle;
      statusText = 'AI分析完了';
      description = '最適な会場の推奨が完了しました';
    } else if (hasAiResults) {
      statusColor = Colors.orange;
      statusIcon = Icons.hourglass_empty;
      statusText = 'AI分析進行中';
      description = '分析を実行中です。しばらくお待ちください';
    } else {
      statusColor = Colors.grey;
      statusIcon = Icons.pending;
      statusText = 'AI分析未実行';
      description = '幹事がAI分析を実行するまでお待ちください';
    }

    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Icon(statusIcon, color: statusColor, size: 32),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    statusText,
                    style: theme.textTheme.titleMedium?.copyWith(
                      color: statusColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    description,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: theme.colorScheme.outline,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOverallRecommendationCard(
    Map<String, dynamic> optimizedResults,
    ThemeData theme,
  ) {
    final overallRecommendation =
        optimizedResults['overallRecommendation'] as Map<String, dynamic>?;
    final bestChoice =
        overallRecommendation?['bestChoice'] as Map<String, dynamic>?;

    // bestChoiceの中に RestaurantEvaluation が入っている
    final restaurantEvaluation =
        bestChoice?['restaurant'] as Map<String, dynamic>?;
    // RestaurantEvaluation内の実際のレストランデータを取得
    final restaurantData =
        restaurantEvaluation?['restaurant'] as Map<String, dynamic>?;

    if (restaurantData == null || restaurantEvaluation == null) {
      return const SizedBox.shrink();
    }

    return Card(
      elevation: 3,
      color: theme.colorScheme.primaryContainer,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.star, color: theme.colorScheme.primary, size: 28),
                const SizedBox(width: 12),
                Text(
                  'AIおすすめ No.1',
                  style: theme.textTheme.headlineSmall?.copyWith(
                    color: theme.colorScheme.primary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            _buildRestaurantCard(
              restaurantData,
              restaurantEvaluation,
              theme,
              isRecommended: true,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLocationRankingsCard(
    Map<String, dynamic> optimizedResults,
    ThemeData theme,
  ) {
    final locationRankings =
        optimizedResults['locationRankings'] as Map<String, dynamic>?;
    if (locationRankings == null || locationRankings.isEmpty) {
      return const SizedBox.shrink();
    }

    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.location_on, color: theme.colorScheme.secondary),
                const SizedBox(width: 8),
                Text(
                  'エリア別おすすめ',
                  style: theme.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            ...locationRankings.entries.map(
              (entry) => _buildLocationSection(entry.key, entry.value, theme),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLocationSection(
    String locationName,
    dynamic locationData,
    ThemeData theme,
  ) {
    if (locationData is! Map<String, dynamic>) {
      return const SizedBox.shrink();
    }

    final topRestaurants = locationData['topRestaurants'] as List<dynamic>?;
    if (topRestaurants == null || topRestaurants.isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: Text(
            locationName,
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: theme.colorScheme.secondary,
            ),
          ),
        ),
        ...topRestaurants.take(3).map((restaurant) {
          final index = topRestaurants.indexOf(restaurant);
          return Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: _buildRestaurantCard(
              restaurant['restaurant'],
              restaurant,
              theme,
              rank: index + 1,
            ),
          );
        }),
        const Divider(height: 24),
      ],
    );
  }

  Widget _buildRestaurantCard(
    dynamic restaurantData,
    dynamic fullData,
    ThemeData theme, {
    int? rank,
    bool isRecommended = false,
  }) {
    if (restaurantData is! Map<String, dynamic>) {
      debugPrint('❌ Restaurant data is not Map: ${restaurantData.runtimeType}');
      debugPrint('Restaurant data content: $restaurantData');
      return const SizedBox.shrink();
    }

    // データの安全な取得
    final name =
        restaurantData['name']?.toString() ??
        fullData?['name']?.toString() ??
        '店舗名不明';
    final rating =
        restaurantData['rating']?.toString() ??
        fullData?['rating']?.toString() ??
        'N/A';
    final priceLevel = restaurantData['priceLevel'] ?? fullData?['priceLevel'];
    final vicinity =
        restaurantData['vicinity']?.toString() ??
        restaurantData['formattedAddress']?.toString() ??
        fullData?['vicinity']?.toString() ??
        fullData?['formattedAddress']?.toString() ??
        '住所不明';
    final placeId =
        restaurantData['placeId']?.toString() ??
        fullData?['placeId']?.toString();
    final phoneNumber =
        restaurantData['phoneNumber']?.toString() ??
        fullData?['phoneNumber']?.toString();
    final totalScore = fullData?['totalScore']?.toString();

    // デバッグ情報
    debugPrint('🏪 Restaurant name: $name');
    debugPrint('📍 Restaurant vicinity: $vicinity');
    debugPrint('⭐ Restaurant rating: $rating');

    // アピールポイントと懸念点
    final appealPoints = fullData?['appealPoints'] as List<dynamic>? ?? [];
    final concerns = fullData?['concerns'] as List<dynamic>? ?? [];

    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: isRecommended
              ? theme.colorScheme.primary
              : theme.colorScheme.outline.withOpacity(0.3),
          width: isRecommended ? 2 : 1,
        ),
        borderRadius: BorderRadius.circular(12),
        color: isRecommended
            ? theme.colorScheme.primaryContainer.withOpacity(0.3)
            : null,
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ヘッダー
          Row(
            children: [
              if (rank != null) ...[
                Container(
                  width: 28,
                  height: 28,
                  decoration: BoxDecoration(
                    color: rank == 1
                        ? const Color(0xFFFFD700)
                        : theme.colorScheme.secondary,
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Text(
                      '$rank',
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
              ],
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: isRecommended ? theme.colorScheme.primary : null,
                      ),
                    ),
                    if (totalScore != null)
                      Text(
                        'AIスコア: $totalScore点',
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: theme.colorScheme.secondary,
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
          Row(
            children: [
              Icon(
                Icons.location_on,
                size: 16,
                color: theme.colorScheme.outline,
              ),
              const SizedBox(width: 4),
              Expanded(
                child: Text(
                  vicinity,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.outline,
                  ),
                ),
              ),
            ],
          ),

          // アピールポイント
          if (appealPoints.isNotEmpty) ...[
            const SizedBox(height: 12),
            Row(
              children: [
                const Icon(Icons.thumb_up, color: Colors.green, size: 16),
                const SizedBox(width: 4),
                Text(
                  'おすすめポイント',
                  style: theme.textTheme.bodySmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 4),
            ...appealPoints
                .take(3)
                .map(
                  (point) => Padding(
                    padding: const EdgeInsets.only(left: 20, bottom: 2),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('• ', style: TextStyle(color: Colors.green)),
                        Expanded(
                          child: Text(
                            point.toString(),
                            style: theme.textTheme.bodySmall,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
          ],

          // 懸念点
          if (concerns.isNotEmpty) ...[
            const SizedBox(height: 8),
            Row(
              children: [
                const Icon(Icons.warning, color: Colors.orange, size: 16),
                const SizedBox(width: 4),
                Text(
                  '注意点',
                  style: theme.textTheme.bodySmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.orange,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 4),
            ...concerns
                .take(2)
                .map(
                  (concern) => Padding(
                    padding: const EdgeInsets.only(left: 20, bottom: 2),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          '• ',
                          style: TextStyle(color: Colors.orange),
                        ),
                        Expanded(
                          child: Text(
                            concern.toString(),
                            style: theme.textTheme.bodySmall,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
          ],

          // アクションボタン
          const SizedBox(height: 12),
          Row(
            children: [
              if (placeId != null) ...[
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () => _openGoogleMap(placeId),
                    icon: const Icon(Icons.map, size: 16),
                    label: const Text('地図で見る'),
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                    ),
                  ),
                ),
                if (phoneNumber != null) const SizedBox(width: 8),
              ],
              if (phoneNumber != null) ...[
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () => _makePhoneCall(phoneNumber),
                    icon: const Icon(Icons.phone, size: 16),
                    label: const Text('電話する'),
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                    ),
                  ),
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPartialResultsCard(
    Map<String, dynamic> aiResults,
    ThemeData theme,
  ) {
    final status = aiResults['status']?.toString() ?? '';
    final locationCandidates =
        aiResults['locationCandidates'] as List<dynamic>? ?? [];
    final keywords = aiResults['keywords'] as List<dynamic>? ?? [];

    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.info, color: theme.colorScheme.primary),
                const SizedBox(width: 8),
                Text(
                  '分析進行状況',
                  style: theme.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text('現在の状況: ${_getStatusDescription(status)}'),
            if (locationCandidates.isNotEmpty) ...[
              const SizedBox(height: 12),
              Text('場所候補: ${locationCandidates.length}箇所を分析中'),
            ],
            if (keywords.isNotEmpty) ...[
              const SizedBox(height: 8),
              Text('検索キーワード: ${keywords.join(', ')}'),
            ],
            const SizedBox(height: 16),
            const LinearProgressIndicator(),
            const SizedBox(height: 8),
            Text(
              '分析完了まで今しばらくお待ちください',
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.outline,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNoResultsCard(ThemeData theme) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            Icon(
              Icons.hourglass_empty,
              size: 48,
              color: theme.colorScheme.outline,
            ),
            const SizedBox(height: 16),
            Text(
              'AI分析を準備中です',
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'イベントの幹事がAI分析を実行すると、\nおすすめの会場が表示されます',
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.outline,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow({
    required IconData icon,
    required String label,
    required String value,
    required ThemeData theme,
  }) {
    return Row(
      children: [
        Icon(icon, size: 16, color: theme.colorScheme.outline),
        const SizedBox(width: 8),
        Text(
          '$label: ',
          style: theme.textTheme.bodyMedium?.copyWith(
            fontWeight: FontWeight.w500,
          ),
        ),
        Expanded(child: Text(value, style: theme.textTheme.bodyMedium)),
      ],
    );
  }

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

  String _getStatusDescription(String status) {
    switch (status) {
      case 'processing':
        return '分析を開始しています...';
      case 'location_generated':
        return '場所候補を生成しました（ステップ1/4完了）';
      case 'keywords_generated':
        return '検索キーワードを生成しました（ステップ2/4完了）';
      case 'restaurants_searched':
        return 'レストランを検索しました（ステップ3/4完了）';
      case 'optimization_completed':
        return '最適化が完了しました（全ステップ完了）';
      case 'completed':
        return 'AI分析が正常に完了しました';
      case 'error':
        return '分析中にエラーが発生しました';
      default:
        return '分析状況：$status';
    }
  }

  Future<void> _openGoogleMap(String placeId) async {
    try {
      final googleMapsUrl =
          'https://www.google.com/maps/place/?q=place_id:$placeId';
      final uri = Uri.parse(googleMapsUrl);
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } catch (e) {
      debugPrint('Google Map開くエラー: $e');
    }
  }

  Future<void> _makePhoneCall(String phoneNumber) async {
    try {
      final uri = Uri.parse('tel:$phoneNumber');
      await launchUrl(uri);
    } catch (e) {
      debugPrint('電話発信エラー: $e');
    }
  }
}
