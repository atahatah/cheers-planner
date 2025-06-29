import 'package:cheers_planner/core/app/snackbar_repo.dart';
import 'package:cheers_planner/core/router/root.dart';
import 'package:cheers_planner/features/create/event_entry.dart';
import 'package:cheers_planner/features/create/event_entry_repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ManagementScreen extends HookConsumerWidget {
  const ManagementScreen({super.key, required this.eventId});
  final String eventId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncEventEntry = ref.watch(eventEntryProvider(eventId));

    return switch (asyncEventEntry) {
      AsyncLoading() => Scaffold(
        appBar: AppBar(title: const Text('管理画面')),
        body: const Center(child: CircularProgressIndicator()),
      ),
      AsyncError(:final error, stackTrace: _) => Scaffold(
        appBar: AppBar(title: const Text('管理画面')),
        body: Center(child: Text('エラーが発生しました: $error')),
      ),
      AsyncData(:final value) => Scaffold(
        appBar: AppBar(title: Text(value.eventName)),
        body: ManagementBody(value: value),
      ),
      _ => const SizedBox.shrink(),
    };
  }
}

class ManagementBody extends HookConsumerWidget {
  const ManagementBody({super.key, required this.value});

  final EventEntry value;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Center(
      child: Column(
        children: [
          ElevatedButton(
            child: const Text('リンクをコピー'),
            onPressed: () {
              Clipboard.setData(
                ClipboardData(text: '${Uri.base.origin}/vote/${value.id}'),
              );
              ref
                  .read(snackBarRepoProvider)
                  .show('リンクをコピーしました: ${Uri.base.origin}/vote/${value.id}');
            },
          ),
          ElevatedButton(
            onPressed: () => VoteRoute(value.id!).go(context),
            child: const Text('投票する'),
          ),
          ElevatedButton(
            onPressed: () {
              ref.read(snackBarRepoProvider).show('未実装です。');
            },
            child: const Text('レコメンドを生成'),
          ),
        ],
      ),
    );
  }
}
