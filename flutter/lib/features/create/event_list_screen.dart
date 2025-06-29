import 'package:cheers_planner/core/router/root.dart';
import 'package:cheers_planner/features/create/event_entry_repo.dart';
import 'package:firebase_ui_firestore/firebase_ui_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class EventListScreen extends HookConsumerWidget {
  const EventListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final eventEntriesRepo = ref.watch(eventEntriesRepoProvider);
    return Scaffold(
      appBar: AppBar(title: const Text('Event List')),
      body: FirestoreListView(
        query: eventEntriesRepo.listViewQuery(),
        itemBuilder: (context, snapshot) {
          final event = snapshot.data();
          return ListTile(
            title: Text(event.eventName),
            subtitle: Text('Due: ${event.dueDate.toLocal()}'),
            onTap: () => ManagementRoute(event.id!).go(context),
          );
        },
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
