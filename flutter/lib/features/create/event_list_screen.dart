import 'package:cheers_planner/core/firebase/auth_repo.dart';
import 'package:cheers_planner/core/router/root.dart';
import 'package:cheers_planner/features/create/event_entry.dart';
import 'package:cheers_planner/features/create/event_entry_repo.dart';
import 'package:firebase_ui_firestore/firebase_ui_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';

class EventListScreen extends HookConsumerWidget {
  const EventListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final uid = ref.watch(requireUserProvider).uid;
    final eventEntriesRepo = ref.watch(eventEntriesRepoProvider);
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('イベント一覧'),
        backgroundColor: theme.colorScheme.primaryContainer,
      ),
      body: FirestoreListView(
        query: eventEntriesRepo.organizeEventListQuery(uid),
        padding: const EdgeInsets.all(16),
        itemBuilder: (context, snapshot) {
          final event = snapshot.data();
          return Card(
            elevation: 2,
            margin: const EdgeInsets.only(bottom: 16),
            child: InkWell(
              onTap: () => ManagementRoute(event.id!).go(context),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.event, size: 24),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            event.purpose,
                            style: theme.textTheme.titleLarge,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    _buildInfoRow(
                      context,
                      Icons.schedule,
                      '所要時間: ${event.minutes}分',
                    ),
                    const SizedBox(height: 8),
                    _buildInfoRow(
                      context,
                      Icons.payments,
                      '予算上限: ¥${NumberFormat('#,###').format(event.budgetUpperLimit)}',
                    ),
                    const SizedBox(height: 8),
                    _buildInfoRow(
                      context,
                      Icons.group,
                      '投票者数: ${event.participantId.length}人',
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Flexible(child: _buildStatusChip(context, event)),
                        const SizedBox(width: 8),
                        TextButton.icon(
                          onPressed: () =>
                              ManagementRoute(event.id!).go(context),
                          icon: const Icon(Icons.arrow_forward),
                          label: const Text('管理'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
        emptyBuilder: (context) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.event_busy,
                size: 64,
                color: theme.colorScheme.outline,
              ),
              const SizedBox(height: 16),
              Text('イベントがまだありません', style: theme.textTheme.titleMedium),
              const SizedBox(height: 8),
              Text(
                '新しいイベントを作成してみましょう！',
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.colorScheme.outline,
                ),
              ),
            ],
          ),
        ),
        loadingBuilder: (context) =>
            const Center(child: CircularProgressIndicator()),
        errorBuilder: (context, error, stackTrace) => Center(
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
                '時間をおいて再度お試しください',
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.colorScheme.outline,
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => const CreateRoute().go(context),
        icon: const Icon(Icons.add),
        label: const Text('新規イベント'),
      ),
    );
  }

  Widget _buildInfoRow(BuildContext context, IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, size: 16, color: Theme.of(context).colorScheme.outline),
        const SizedBox(width: 8),
        Text(
          text,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: Theme.of(context).colorScheme.outline,
          ),
        ),
      ],
    );
  }

  Widget _buildStatusChip(BuildContext context, EventEntry event) {
    final aiResults = event.aiResults;
    final hasAiResults = aiResults != null;
    final status = aiResults?['status']?.toString();
    final hasParticipants = event.participantId.isNotEmpty;
    final theme = Theme.of(context);

    // AI分析のステータスを優先表示
    if (hasAiResults && status != null) {
      switch (status) {
        case 'optimization_completed':
        case 'completed':
          return Chip(
            backgroundColor: theme.colorScheme.tertiaryContainer,
            labelStyle: theme.textTheme.bodySmall,
            padding: EdgeInsets.zero,
            label: const Text('AI分析済み'),
            avatar: const Icon(Icons.psychology, size: 16),
            visualDensity: VisualDensity.compact,
          );

        case 'error':
          return Chip(
            backgroundColor: theme.colorScheme.errorContainer,
            labelStyle: theme.textTheme.bodySmall?.copyWith(
              color: theme.colorScheme.onErrorContainer,
            ),
            padding: EdgeInsets.zero,
            label: const Text('分析失敗'),
            avatar: Icon(Icons.error, size: 16, color: theme.colorScheme.error),
            visualDensity: VisualDensity.compact,
          );

        case 'processing':
        case 'location_generated':
        case 'keywords_generated':
        case 'restaurants_searched':
          return Chip(
            backgroundColor: theme.colorScheme.secondaryContainer,
            labelStyle: theme.textTheme.bodySmall,
            padding: EdgeInsets.zero,
            label: const Text('分析中'),
            avatar: const Icon(Icons.hourglass_empty, size: 16),
            visualDensity: VisualDensity.compact,
          );

        default:
          return Chip(
            backgroundColor: theme.colorScheme.surfaceContainerHighest,
            labelStyle: theme.textTheme.bodySmall,
            padding: EdgeInsets.zero,
            label: const Text('状態不明'),
            avatar: const Icon(Icons.help_outline, size: 16),
            visualDensity: VisualDensity.compact,
          );
      }
    }

    // AI分析未実行時は投票状況を表示
    if (hasParticipants) {
      return Chip(
        backgroundColor: theme.colorScheme.primaryContainer,
        labelStyle: theme.textTheme.bodySmall,
        padding: EdgeInsets.zero,
        label: const Text('投票受付中'),
        avatar: const Icon(Icons.how_to_vote, size: 16),
        visualDensity: VisualDensity.compact,
      );
    } else {
      return Chip(
        backgroundColor: theme.colorScheme.surfaceContainerHighest,
        labelStyle: theme.textTheme.bodySmall,
        padding: EdgeInsets.zero,
        label: const Text('未投票'),
        avatar: const Icon(Icons.pending, size: 16),
        visualDensity: VisualDensity.compact,
      );
    }
  }
}
