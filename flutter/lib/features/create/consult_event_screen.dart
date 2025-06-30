import 'package:cheers_planner/features/create/consult_event_controller.dart';
import 'package:cheers_planner/features/create/event_entry.dart';
import 'package:cheers_planner/features/chat/chat.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ConsultEventScreen extends HookConsumerWidget {
  const ConsultEventScreen({super.key, required this.entry});

  final EventEntry entry;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(consultEventControllerProvider(entry));
    final notifier = ref.read(consultEventControllerProvider(entry).notifier);
    final textController = useTextEditingController();
    final scrollController = useScrollController();

    useEffect(() {
      if (state.chatState.messages.isNotEmpty) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (scrollController.hasClients) {
            scrollController.jumpTo(scrollController.position.maxScrollExtent);
          }
        });
      }
      return null;
    }, [state.chatState.messages, scrollController]);

    useEffect(() {
      notifier.startConsult();
      return null;
    }, const []);

    void sendMessage() {
      final text = textController.text.trim();
      if (text.isNotEmpty) {
        notifier.sendMessage(text);
        textController.clear();
      }
    }

    return Scaffold(
      appBar: AppBar(title: const Text('イベント相談')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('イベント名: ${state.event.purpose}'),
                Text('予算上限: ${state.event.budgetUpperLimit}'),
                Text('長さ: ${state.event.minutes}分'),
                Text('その他: ${state.event.allergiesEtc}'),
              ],
            ),
          ),
          if (state.proposed != null) ...[
            Card(
              margin: const EdgeInsets.symmetric(horizontal: 8),
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('提案されたイベント名: ${state.proposed!.purpose}'),
                    Text('予算上限: ${state.proposed!.budgetUpperLimit}'),
                    Text('長さ: ${state.proposed!.minutes}分'),
                    Text('その他: ${state.proposed!.allergiesEtc}'),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                          onPressed: notifier.clearProposed,
                          child: const Text('取消'),
                        ),
                        const SizedBox(width: 8),
                        ElevatedButton(
                          onPressed: notifier.applyProposed,
                          child: const Text('反映する'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
          const Divider(),
          Expanded(
            child: ListView.builder(
              controller: scrollController,
              itemCount: state.chatState.messages.length,
              itemBuilder: (context, index) {
                final message = state.chatState.messages[index];
                return ListTile(
                  title: Text(message.message),
                  subtitle: Text(message.role == Role.user ? 'あなた' : 'Gemini'),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: textController,
                    onSubmitted: (_) => sendMessage(),
                    decoration: const InputDecoration(
                      labelText: 'メッセージを入力',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: sendMessage,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
