import 'package:cheers_planner/core/app/snackbar_repo.dart';
import 'package:cheers_planner/core/firebase/auth_repo.dart';
import 'package:cheers_planner/core/router/root.dart';
import 'package:cheers_planner/features/create/event_entry.dart';
import 'package:cheers_planner/features/create/event_entry_repo.dart';
import 'package:cheers_planner/features/vote/participant_repo.dart';
import 'package:firebase_ui_firestore/firebase_ui_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';

class VotedListScreen extends HookConsumerWidget {
  const VotedListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final eventEntriesRepo = ref.watch(eventEntriesRepoProvider);
    final uid = ref.watch(requireUserProvider).uid;
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('投票済みイベント'),
        backgroundColor: theme.colorScheme.secondaryContainer,
      ),
      body: FirestoreListView(
        query: eventEntriesRepo.votedEventListQuery(uid),
        padding: const EdgeInsets.all(16),
        itemBuilder: (context, snapshot) {
          final event = snapshot.data();
          return Card(
            elevation: 2,
            margin: const EdgeInsets.only(bottom: 16),
            child: InkWell(
              onTap: () => ResultRoute(event.id!).go(context),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.event_available, size: 24),
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
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        _buildStatusChip(context, event),
                        const Spacer(),
                        TextButton.icon(
                          onPressed: () => ResultRoute(event.id!).go(context),
                          icon: const Icon(Icons.poll),
                          label: const Text('結果を確認'),
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete_outline),
                          color: theme.colorScheme.error,
                          onPressed: () =>
                              _showDeleteDialog(context, ref, event, uid),
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
                Icons.how_to_vote_outlined,
                size: 64,
                color: theme.colorScheme.outline,
              ),
              const SizedBox(height: 16),
              Text('投票済みのイベントはありません', style: theme.textTheme.titleMedium),
              const SizedBox(height: 8),
              Text(
                'イベントに参加して投票してみましょう！',
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
    final theme = Theme.of(context);

    if (hasAiResults && status != null) {
      switch (status) {
        case 'optimization_completed':
        case 'completed':
          return Flexible(
            child: Chip(
              backgroundColor: theme.colorScheme.tertiaryContainer,
              labelStyle: theme.textTheme.bodySmall,
              padding: EdgeInsets.zero,
              label: const Text('結果確定'),
              avatar: const Icon(Icons.check_circle, size: 16),
              visualDensity: VisualDensity.compact,
            ),
          );

        case 'error':
          return Flexible(
            child: Chip(
              backgroundColor: theme.colorScheme.errorContainer,
              labelStyle: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.onErrorContainer,
              ),
              padding: EdgeInsets.zero,
              label: const Text('分析失敗'),
              avatar: Icon(
                Icons.error,
                size: 16,
                color: theme.colorScheme.error,
              ),
              visualDensity: VisualDensity.compact,
            ),
          );

        case 'processing':
        case 'location_generated':
        case 'keywords_generated':
        case 'restaurants_searched':
          return Flexible(
            child: Chip(
              backgroundColor: theme.colorScheme.secondaryContainer,
              labelStyle: theme.textTheme.bodySmall,
              padding: EdgeInsets.zero,
              label: const Text('分析中'),
              avatar: const Icon(Icons.hourglass_empty, size: 16),
              visualDensity: VisualDensity.compact,
            ),
          );

        default:
          // 未知のステータス
          return Flexible(
            child: Chip(
              backgroundColor: theme.colorScheme.surfaceContainerHighest,
              labelStyle: theme.textTheme.bodySmall,
              padding: EdgeInsets.zero,
              label: const Text('状態不明'),
              avatar: const Icon(Icons.help_outline, size: 16),
              visualDensity: VisualDensity.compact,
            ),
          );
      }
    } else {
      // AI分析未実行
      return Flexible(
        child: Chip(
          backgroundColor: theme.colorScheme.surfaceContainerHighest,
          labelStyle: theme.textTheme.bodySmall,
          padding: EdgeInsets.zero,
          label: const Text('投票済み'),
          avatar: const Icon(Icons.how_to_vote, size: 16),
          visualDensity: VisualDensity.compact,
        ),
      );
    }
  }

  Future<void> _showDeleteDialog(
    BuildContext context,
    WidgetRef ref,
    EventEntry event,
    String uid,
  ) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('投票を取り消しますか？'),
        content: const Text('この操作は取り消せません。'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('キャンセル'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            style: TextButton.styleFrom(
              foregroundColor: Theme.of(context).colorScheme.error,
            ),
            child: const Text('削除'),
          ),
        ],
      ),
    );

    if (confirm != true) return;

    final id = event.id!;
    await ref.read(participantRepoProvider(id)).delete(uid);
    await ref.read(eventEntryRepoProvider(id)).removeParticipant(id, uid);
    ref.read(snackBarRepoProvider).show('投票を取り消しました');
  }
}
