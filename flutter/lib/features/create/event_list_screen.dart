import 'package:cheers_planner/core/firebase/auth_repo.dart';
import 'package:cheers_planner/core/router/root.dart';
import 'package:cheers_planner/features/create/event_entry_repo.dart';
import 'package:firebase_ui_firestore/firebase_ui_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class EventListScreen extends HookConsumerWidget {
  const EventListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final uid = ref.watch(requireUserProvider).uid;
    final eventEntriesRepo = ref.watch(eventEntriesRepoProvider);
    return Scaffold(
      appBar: AppBar(title: const Text('作成したイベント')),
      body: FirestoreListView(
        query: eventEntriesRepo.organizeEventListQuery(uid),
        itemBuilder: (context, snapshot) {
          final event = snapshot.data();
          return ListTile(
            title: Text(event.purpose),
            onTap: () => ManagementRoute(event.id!).go(context),
            trailing: IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () async {
                final shouldDelete = await showDialog<bool>(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text('イベントを削除'),
                    content: const Text('このイベントを削除しますか？'),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context, false),
                        child: const Text('キャンセル'),
                      ),
                      TextButton(
                        onPressed: () => Navigator.pop(context, true),
                        child: const Text('削除'),
                      ),
                    ],
                  ),
                );
                if (shouldDelete ?? false) {
                  await ref.read(eventEntryRepoProvider(event.id!)).delete();
                }
              },
            ),
          );
        },
        emptyBuilder: (context) =>
            const Center(child: Text('作成したイベントはまだありません。')),
        loadingBuilder: (context) =>
            const Center(child: CircularProgressIndicator()),
        errorBuilder: (context, error, stackTrace) =>
            const Center(child: Text('問題が発生しました。時間をおいて再度読み込んでください。')),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => const CreateEventRoute().go(context),
        child: const Icon(Icons.add),
      ),
    );
  }
}
