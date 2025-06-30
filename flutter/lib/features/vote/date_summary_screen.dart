import 'package:cheers_planner/features/create/event_entry.dart';
import 'package:cheers_planner/features/create/event_entry_repo.dart';
import 'package:cheers_planner/features/vote/participant_repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';

class DateSummaryScreen extends HookConsumerWidget {
  const DateSummaryScreen({super.key, required this.eventId});
  final String eventId;

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
    final asyncEventEntry = ref.watch(eventEntryProvider(eventId));
    final theme = Theme.of(context);

    // 日程ごとの参加可能人数を取得
    final dateCounts = useState<Map<DateTime, int>>({});

    useEffect(() {
      Future<void> loadDateCounts() async {
        final counts = await ref
            .read(participantRepoProvider(eventId))
            .getDateParticipantCounts();
        dateCounts.value = counts;
      }

      loadDateCounts();
      return null;
    }, [eventId]);

    return Scaffold(
      appBar: AppBar(
        title: const Text('日程調整状況'),
        backgroundColor: theme.colorScheme.secondaryContainer,
      ),
      body: switch (asyncEventEntry) {
        AsyncData(:final value) => SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Card(
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
                            value.purpose,
                            style: theme.textTheme.titleLarge,
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Text(
                        '参加者数: ${value.participantId.length}人',
                        style: theme.textTheme.titleMedium,
                      ),
                      const SizedBox(height: 16),
                      const Text('日程候補ごとの参加可能人数'),
                      const SizedBox(height: 8),
                      for (final date in value.candidateDateTimes)
                        Padding(
                          padding: const EdgeInsets.only(bottom: 12),
                          child: Row(
                            children: [
                              Expanded(
                                child: Text(_formatDateTime(date.start)),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 4,
                                ),
                                decoration: BoxDecoration(
                                  color: theme.colorScheme.primaryContainer,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Text(
                                  // 日付を正規化して参加可能人数を取得
                                  '${dateCounts.value[DateTime(date.start.year, date.start.month, date.start.day, date.start.hour, date.start.minute)] ?? 0}人',
                                  style: theme.textTheme.bodyMedium?.copyWith(
                                    color: theme.colorScheme.onPrimaryContainer,
                                  ),
                                ),
                              ),
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
        AsyncError(:final error) => Center(
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
                error.toString(),
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.colorScheme.outline,
                ),
              ),
            ],
          ),
        ),
        _ => const Center(child: CircularProgressIndicator()),
      },
    );
  }
}
