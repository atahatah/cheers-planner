import 'package:cheers_planner/features/create/consult_event_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ConsultEventScreen extends HookConsumerWidget {
  const ConsultEventScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textController = useTextEditingController();
    final scrollController = useScrollController();
    final consultState = ref.watch(consultEventControllerProvider);

    useEffect(() {
      if (consultState.messages.isNotEmpty) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (scrollController.hasClients) {
            scrollController.jumpTo(scrollController.position.maxScrollExtent);
          }
        });
      }
      return null;
    }, [consultState.messages, scrollController]);

    void send() {
      final message = textController.text.trim();
      if (message.isNotEmpty) {
        ref.read(consultEventControllerProvider.notifier).addMessage(message);
        textController.clear();
      }
    }

    final pending = ref
        .watch(consultEventControllerProvider.notifier)
        .pendingDraft;

    return Scaffold(
      appBar: AppBar(title: const Text('Geminiと相談')),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              controller: scrollController,
              itemCount: consultState.messages.length,
              itemBuilder: (context, index) {
                final msg = consultState.messages[index];
                return ListTile(
                  title: Text(msg.message),
                  subtitle: Text(msg.sentAt?.toString() ?? ''),
                );
              },
            ),
          ),
          if (pending != null)
            Card(
              color: Colors.amber.shade100,
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Geminiの提案'),
                    Text('イベント名: ${pending.purpose}'),
                    Text('予算上限: ${pending.budgetUpperLimit}'),
                    Text('長さ: ${pending.minutes} 分'),
                    Text('その他: ${pending.allergiesEtc}'),
                    ElevatedButton(
                      onPressed: () {
                        ref
                            .read(consultEventControllerProvider.notifier)
                            .applyPendingDraft();
                      },
                      child: const Text('提案を反映'),
                    ),
                  ],
                ),
              ),
            ),
          Padding(
            padding: const EdgeInsets.all(8),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: textController,
                    onSubmitted: (_) => send(),
                    decoration: const InputDecoration(
                      labelText: 'メッセージを入力',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                IconButton(icon: const Icon(Icons.send), onPressed: send),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
