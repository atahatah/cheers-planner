import 'package:cheers_planner/core/firebase/auth_repo.dart';
import 'package:cheers_planner/core/router/root.dart';
import 'package:cheers_planner/features/create/event_entry_repo.dart';
import 'package:firebase_ui_firestore/firebase_ui_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class VotedListScreen extends HookConsumerWidget {
  const VotedListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final eventEntriesRepo = ref.watch(eventEntriesRepoProvider);
    final uid = ref.watch(requireUserProvider).uid;
    return Scaffold(
      appBar: AppBar(title: const Text('投票に参加したイベント')),
      body: FirestoreListView(
        query: eventEntriesRepo.votedEventListQuery(uid),
        itemBuilder: (context, snapshot) {
          final event = snapshot.data();
          return ListTile(
            title: Text(event.purpose),
            onTap: () => ResultRoute(event.id!).go(context),
          );
        },
        emptyBuilder: (context) =>
            const Center(child: Text('投票したイベントはまだありません。')),
        loadingBuilder: (context) =>
            const Center(child: CircularProgressIndicator()),
        errorBuilder: (context, error, stackTrace) =>
            const Center(child: Text('問題が発生しました。時間をおいて再度読み込んでください。')),
      ),
    );
  }
}
