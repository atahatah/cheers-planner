import 'dart:convert';

import 'package:cheers_planner/features/chat/chat.dart';
import 'package:cheers_planner/features/chat/chat_controller.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'event_draft_provider.dart';
import 'event_entry.dart';

class ConsultEventScreen extends HookConsumerWidget {
  const ConsultEventScreen({super.key});

  String _buildPrompt(EventEntry event) {
    final times = event.candidateDateTimes
        .map((e) => e.start.toIso8601String())
        .join(', ');
    final questions = event.fixedQuestion.join(', ');
    return '''イベント情報をより良くする提案をしてください。変更後の値をJSON形式で返してください。変更不要な項目はnullを設定してください。
{"purpose":string|null,"candidateDateTimes":[string]|null,"allergiesEtc":string|null,"budgetUpperLimit":number|null,"fixedQuestion":[string]|null,"minutes":number|null}
イベント名: ${event.purpose}
候補日時: $times
その他特記事項: ${event.allergiesEtc}
予算上限: ${event.budgetUpperLimit}
固定質問: $questions
長さ: ${event.minutes}分''';
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final draft = ref.watch(eventDraftProvider);
    final chatState = ref.watch(chatControllerProvider);
    final chatNotifier = ref.read(chatControllerProvider.notifier);
    final textController = useTextEditingController();
    final scrollController = useScrollController();

    useEffect(() {
      if (chatState.messages.isEmpty) {
        final prompt = _buildPrompt(draft);
        Future.microtask(() => chatNotifier.addMessage(prompt));
      }
      return null;
    }, [draft, chatNotifier]);

    useEffect(() {
      if (chatState.messages.isNotEmpty) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (scrollController.hasClients) {
            scrollController.jumpTo(scrollController.position.maxScrollExtent);
          }
        });
      }
      return null;
    }, [chatState.messages]);

    void sendMessage() {
      final message = textController.text.trim();
      if (message.isNotEmpty) {
        chatNotifier.addMessage(message);
        textController.clear();
      }
    }

    void applySuggestion() {
      final last = chatState.messages.lastWhereOrNull(
        (m) => m.role == Role.model,
      );
      if (last == null) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('提案が見つかりません')));
        return;
      }
      try {
        final data = jsonDecode(last.message) as Map<String, dynamic>;
        var newDraft = draft;
        if (data['purpose'] != null) {
          newDraft = newDraft.copyWith(purpose: data['purpose'] as String);
        }
        if (data['candidateDateTimes'] != null) {
          newDraft = newDraft.copyWith(
            candidateDateTimes: (data['candidateDateTimes'] as List)
                .map(
                  (e) => CandidateDateTime(start: DateTime.parse(e as String)),
                )
                .toList(),
          );
        }
        if (data['allergiesEtc'] != null) {
          newDraft = newDraft.copyWith(
            allergiesEtc: data['allergiesEtc'] as String,
          );
        }
        if (data['budgetUpperLimit'] != null) {
          newDraft = newDraft.copyWith(
            budgetUpperLimit: (data['budgetUpperLimit'] as num).toInt(),
          );
        }
        if (data['fixedQuestion'] != null) {
          newDraft = newDraft.copyWith(
            fixedQuestion: List<String>.from(data['fixedQuestion'] as List),
          );
        }
        if (data['minutes'] != null) {
          newDraft = newDraft.copyWith(
            minutes: (data['minutes'] as num).toInt(),
          );
        }
        ref.read(eventDraftProvider.notifier).update(newDraft);
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('提案を反映しました')));
      } catch (e) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('提案の解析に失敗しました')));
      }
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Geminiと相談')),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              controller: scrollController,
              itemCount: chatState.messages.length,
              itemBuilder: (context, index) {
                final message = chatState.messages[index];
                final isUser = message.role == Role.user;
                return ListTile(
                  title: Text(message.message),
                  subtitle: Text(isUser ? 'You' : 'Gemini'),
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
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: applySuggestion,
                  child: const Text('提案を反映'),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: ElevatedButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('戻る'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
