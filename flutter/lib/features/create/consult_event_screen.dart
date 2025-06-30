import 'package:cheers_planner/features/chat/chat.dart';
import 'package:cheers_planner/features/create/consult_event_controller.dart';
import 'package:cheers_planner/features/create/event_entry.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ConsultEventScreen extends HookConsumerWidget {
  const ConsultEventScreen({super.key, required this.entry});

  final EventEntry entry;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(consultEventControllerProvider);
    final notifier = ref.read(consultEventControllerProvider.notifier);
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
      WidgetsBinding.instance.addPostFrameCallback((_) {
        notifier.startConsult(entry);
      });
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ref.read(consultEventControllerProvider.notifier).clearAll();
          ref.read(consultEventControllerProvider.notifier).startConsult(entry);
        },
        child: const Icon(Icons.clear_all),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8),
            child: Card(
              elevation: 2,
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.event,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'イベント概要',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    _buildInfoRow(
                      context,
                      'イベント名',
                      state.event?.purpose ?? '未設定',
                    ),
                    _buildInfoRow(
                      context,
                      '候補日時',
                      state.event == null
                          ? '-'
                          : state.event!.candidateDateTimes
                                .map((e) => _fmt(e.start))
                                .join(' / '),
                    ),
                    _buildInfoRow(
                      context,
                      '予算上限',
                      '${state.event?.budgetUpperLimit ?? '-'} 円',
                    ),
                    _buildInfoRow(
                      context,
                      '長さ',
                      '${state.event?.minutes ?? '-'} 分',
                    ),
                    if (state.event?.fixedQuestion.isNotEmpty == true)
                      _buildInfoRow(
                        context,
                        '質問',
                        state.event!.fixedQuestion.join(' / '),
                      ),
                    if (state.event?.allergiesEtc?.isNotEmpty == true)
                      _buildInfoRow(context, 'その他', state.event!.allergiesEtc!),
                  ],
                ),
              ),
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
                    Text(
                      '候補日時: ${state.proposed!.candidateDateTimes.map((e) => e.start.toIso8601String()).join(', ')}',
                    ),
                    Text('予算上限: ${state.proposed!.budgetUpperLimit}'),
                    Text('長さ: ${state.proposed!.minutes}分'),
                    Text('参加者への質問: ${state.event?.fixedQuestion.join(' / ')}'),
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
                return _buildChatBubble(context, message);
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

  // --- UI Helper Widgets ---
  Widget _buildInfoRow(BuildContext context, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$label: ',
            style: Theme.of(
              context,
            ).textTheme.labelMedium?.copyWith(fontWeight: FontWeight.bold),
          ),
          Expanded(
            child: Text(value, style: Theme.of(context).textTheme.bodyMedium),
          ),
        ],
      ),
    );
  }

  String _fmt(DateTime dt) {
    return '${dt.month}/${dt.day} ${dt.hour.toString().padLeft(2, '0')}:${dt.minute.toString().padLeft(2, '0')}';
  }

  Widget _buildChatBubble(BuildContext context, ChatMessage message) {
    final isUser = message.role == Role.user;
    final bubbleColor = isUser
        ? Theme.of(context).colorScheme.primaryContainer
        : Theme.of(context).colorScheme.surfaceContainerHighest;
    final align = isUser ? CrossAxisAlignment.end : CrossAxisAlignment.start;
    final radius = BorderRadius.only(
      topLeft: const Radius.circular(12),
      topRight: const Radius.circular(12),
      bottomLeft: isUser ? const Radius.circular(12) : const Radius.circular(0),
      bottomRight: isUser
          ? const Radius.circular(0)
          : const Radius.circular(12),
    );

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
      child: Column(
        crossAxisAlignment: align,
        children: [
          Container(
            constraints: const BoxConstraints(maxWidth: 280),
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
            decoration: BoxDecoration(color: bubbleColor, borderRadius: radius),
            child: Text(
              message.message,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            isUser ? 'あなた' : 'Gemini',
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
              color: Theme.of(context).colorScheme.outline,
            ),
          ),
        ],
      ),
    );
  }
}
