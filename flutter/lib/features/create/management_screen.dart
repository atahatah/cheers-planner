import 'package:cheers_planner/core/app/snackbar_repo.dart';
import 'package:cheers_planner/features/create/event_entry.dart';
import 'package:cheers_planner/features/create/event_entry_repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ManagementScreen extends HookConsumerWidget {
  const ManagementScreen({super.key, required this.eventId});
  final String eventId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncEventEntry = ref.watch(eventEntryProvider(eventId));

    return switch (asyncEventEntry) {
      AsyncLoading() => Scaffold(
        appBar: AppBar(
          title: const Text('イベント管理'),
          backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        ),
        body: const Center(child: CircularProgressIndicator()),
      ),
      AsyncError(:final error, stackTrace: _) => Scaffold(
        appBar: AppBar(
          title: const Text('イベント管理'),
          backgroundColor: Theme.of(context).colorScheme.errorContainer,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.error_outline,
                size: 64,
                color: Theme.of(context).colorScheme.error,
              ),
              const SizedBox(height: 16),
              Text(
                'エラーが発生しました',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: 8),
              Text(
                error.toString(),
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Theme.of(context).colorScheme.error,
                ),
              ),
            ],
          ),
        ),
      ),
      AsyncData(:final value) => Scaffold(
        appBar: AppBar(
          title: Text(value.purpose),
          backgroundColor: Theme.of(context).colorScheme.primaryContainer,
          actions: [
            IconButton(
              icon: const Icon(Icons.edit),
              onPressed: () {
                ref.read(snackBarRepoProvider).show('編集機能は今後実装予定です');
              },
              tooltip: 'イベントを編集',
            ),
          ],
        ),
        body: ManagementBody(value: value),
      ),
      _ => const SizedBox.shrink(),
    };
  }
}

class ManagementBody extends HookConsumerWidget {
  const ManagementBody({super.key, required this.value});

  final EventEntry value;

  String _formatCurrency(int amount) {
    // 簡単な数値フォーマット
    if (amount >= 10000) {
      return '${(amount / 10000).toStringAsFixed(amount % 10000 == 0 ? 0 : 1)}万円';
    } else if (amount >= 1000) {
      final thousands = amount ~/ 1000;
      final remainder = amount % 1000;
      if (remainder == 0) {
        return '$thousands,000円';
      } else {
        return '$thousands,${remainder.toString().padLeft(3, '0')}円';
      }
    }
    return '$amount円';
  }

  String _formatDateTime(DateTime dateTime) {
    final months = [
      '1月',
      '2月',
      '3月',
      '4月',
      '5月',
      '6月',
      '7月',
      '8月',
      '9月',
      '10月',
      '11月',
      '12月',
    ];
    final weekdays = ['月', '火', '水', '木', '金', '土', '日'];

    final month = months[dateTime.month - 1];
    final day = dateTime.day;
    final weekday = weekdays[dateTime.weekday - 1];
    final hour = dateTime.hour.toString().padLeft(2, '0');
    final minute = dateTime.minute.toString().padLeft(2, '0');

    return '${dateTime.year}年$month$day日($weekday) $hour:$minute';
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // イベント詳細情報カード
          Card(
            elevation: 2,
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.event, color: colorScheme.primary, size: 24),
                      const SizedBox(width: 8),
                      Text(
                        'イベント詳細',
                        style: theme.textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  _buildInfoRow(
                    icon: Icons.title,
                    label: 'イベント名',
                    value: value.purpose,
                    theme: theme,
                  ),
                  const SizedBox(height: 12),
                  _buildInfoRow(
                    icon: Icons.schedule,
                    label: '所要時間',
                    value: '${value.minutes}分',
                    theme: theme,
                  ),
                  const SizedBox(height: 12),
                  _buildInfoRow(
                    icon: Icons.attach_money,
                    label: '予算上限',
                    value: _formatCurrency(value.budgetUpperLimit),
                    theme: theme,
                  ),
                  const SizedBox(height: 12),
                  _buildInfoRow(
                    icon: Icons.calendar_today,
                    label: '候補日時',
                    value: value.candidateDateTimes.isNotEmpty
                        ? '${value.candidateDateTimes.length}件の候補'
                        : '候補なし',
                    theme: theme,
                  ),
                  if (value.candidateDateTimes.isNotEmpty) ...[
                    const SizedBox(height: 8),
                    ...value.candidateDateTimes
                        .take(3)
                        .map(
                          (dateTime) => Padding(
                            padding: const EdgeInsets.only(left: 32, bottom: 4),
                            child: Text(
                              _formatDateTime(dateTime.start),
                              style: theme.textTheme.bodySmall?.copyWith(
                                color: colorScheme.onSurfaceVariant,
                              ),
                            ),
                          ),
                        ),
                    if (value.candidateDateTimes.length > 3)
                      Padding(
                        padding: const EdgeInsets.only(left: 32),
                        child: Text(
                          '他${value.candidateDateTimes.length - 3}件...',
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: colorScheme.onSurfaceVariant,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ),
                  ],
                  if (value.allergiesEtc?.isNotEmpty ?? false) ...[
                    const SizedBox(height: 12),
                    _buildInfoRow(
                      icon: Icons.info_outline,
                      label: 'その他・アレルギー',
                      value: value.allergiesEtc!,
                      theme: theme,
                    ),
                  ],
                  if (value.fixedQuestion.isNotEmpty) ...[
                    const SizedBox(height: 12),
                    _buildInfoRow(
                      icon: Icons.quiz,
                      label: '参加者への質問',
                      value: '${value.fixedQuestion.length}件',
                      theme: theme,
                    ),
                  ],
                ],
              ),
            ),
          ),

          const SizedBox(height: 24),

          // アクションカード
          Text(
            '管理メニュー',
            style: theme.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),

          // 投票リンク共有カード
          _buildActionCard(
            context: context,
            icon: Icons.share,
            title: '投票リンクを共有',
            description: '参加者に投票用のリンクを送信できます',
            color: colorScheme.secondary,
            onTap: () {
              final link = '${Uri.base.origin}/vote/voting/${value.id}';
              Clipboard.setData(ClipboardData(text: link));
              ref.read(snackBarRepoProvider).show('投票リンクをコピーしました！');
            },
          ),

          const SizedBox(height: 12),

          // 参加者として投票カード
          _buildActionCard(
            context: context,
            icon: Icons.how_to_vote,
            title: '参加者として投票',
            description: '自分も参加者として希望日程や場所を投票できます',
            color: Colors.blue,
            onTap: () => context.go('/vote/voting/${value.id}'),
          ),

          const SizedBox(height: 12),

          // 投票状況確認カード
          _buildActionCard(
            context: context,
            icon: Icons.poll,
            title: '投票状況を確認',
            description: '参加者の投票結果や集計状況を確認できます',
            color: Colors.green,
            onTap: () => context.go('/vote/result/${value.id}'),
          ),

          const SizedBox(height: 12),

          // AIレコメンドカード
          _buildActionCard(
            context: context,
            icon: Icons.smart_toy,
            title: 'AIレコメンドを生成',
            description: 'AIが最適な会場や日程を提案します',
            color: colorScheme.primary,
            isHighlighted: true,
            onTap: () {
              context.go('/events/management/${value.id}/recommend');
            },
          ),

          const SizedBox(height: 12),

          // 日程調整カード
          _buildActionCard(
            context: context,
            icon: Icons.calendar_month,
            title: '日程調整状況',
            description: '候補日ごとの参加可能人数を確認できます',
            color: Colors.orange,
            onTap: () {
              context.go('/events/management/${value.id}/date_summary');
            },
          ),

          const SizedBox(height: 32),

          // 注意事項
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: colorScheme.surfaceContainerHighest.withOpacity(0.3),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: colorScheme.outline.withOpacity(0.2)),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  Icons.lightbulb_outline,
                  color: colorScheme.primary,
                  size: 20,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'ヒント',
                        style: theme.textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: colorScheme.primary,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '投票リンクを参加者に共有 → 参加者が投票 → 投票状況を確認 → AIレコメンドを生成の順番で進めると、最適な結果が得られます。',
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
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
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 20, color: theme.colorScheme.onSurfaceVariant),
        const SizedBox(width: 8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: theme.textTheme.bodySmall?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                value,
                style: theme.textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildActionCard({
    required BuildContext context,
    required IconData icon,
    required String title,
    required String description,
    required Color color,
    required VoidCallback onTap,
    bool isHighlighted = false,
  }) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Card(
      elevation: isHighlighted ? 4 : 2,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: isHighlighted
              ? BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [color.withOpacity(0.1), color.withOpacity(0.05)],
                  ),
                )
              : null,
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(icon, color: color, size: 24),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: isHighlighted ? color : null,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      description,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.arrow_forward_ios,
                size: 16,
                color: colorScheme.onSurfaceVariant,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
