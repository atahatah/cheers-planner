import 'package:cheers_planner/core/firebase/firebase_ai_repo.dart';
import 'package:cheers_planner/features/chat/chat.dart';
import 'package:cheers_planner/features/chat/chat_exception.dart';
import 'package:cheers_planner/features/create/event_entry.dart';
import 'package:firebase_ai/firebase_ai.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'consult_event_controller.freezed.dart';
part 'consult_event_controller.g.dart';

@freezed
sealed class ConsultEventState with _$ConsultEventState {
  const factory ConsultEventState({
    required ChatState chatState,
    required EventEntry? event,
    EventEntry? proposed,
  }) = _ConsultEventState;
}

@riverpod
class ConsultEventController extends _$ConsultEventController {
  static final _updateEventTool = FunctionDeclaration(
    'updateEvent',
    'この関数は必ずイベント改善の提案時に使用してください。イベントの具体的な変更内容を示すために使用します。',
    parameters: {
      'purpose': Schema.string(
        description: 'イベントの目的や名前（例：歓迎会、送別会、チームビルディングなど）',
      ),
      'candidateDateTimes': Schema.array(
        description: '開始日時の候補をISO8601形式で指定（例：2024-01-15T18:00:00）',
        items: Schema.string(),
      ),
      'allergiesEtc': Schema.string(description: 'アレルギーや食事制限、その他の注意事項'),
      'budgetUpperLimit': Schema.integer(description: '一人当たりの予算上限（円単位）'),
      'fixedQuestion': Schema.array(
        description: '参加者全員に聞く質問（例：好きな食べ物、苦手な食べ物など）',
        items: Schema.string(),
      ),
      'minutes': Schema.integer(description: 'イベントの所要時間（分単位）'),
    },
    optionalParameters: [
      'purpose',
      'candidateDateTimes',
      'allergiesEtc',
      'budgetUpperLimit',
      'fixedQuestion',
      'minutes',
    ],
  );

  @override
  ConsultEventState build() {
    final session = ref.watch(
      geminiFunctionCallSessionProvider([
        Tool.functionDeclarations([_updateEventTool]),
      ]),
    );
    final chatState = ChatState(session: session);
    return ConsultEventState(chatState: chatState, event: null);
  }

  Future<void> startConsult(EventEntry entry) async {
    // eventを状態に設定
    state = state.copyWith(event: entry);

    final summary = [
      '目的: ${entry.purpose}',
      '日程候補: ${entry.candidateDateTimes.map((e) => e.start.toIso8601String()).join(', ')}',
      '予算上限: ${entry.budgetUpperLimit}円',
      '長さ: ${entry.minutes}分',
      if (entry.allergiesEtc.isNotEmpty) 'その他: ${entry.allergiesEtc}',
      if (entry.fixedQuestion.isNotEmpty)
        '全員への質問: ${entry.fixedQuestion.join(' / ')}',
    ].join('\n');
    final prompt =
        '''このイベント企画について改善提案をお願いします。

現在のイベント内容:
$summary

あなたのタスク:
1. この企画の改善点を1つ提案してください
2. 改善案を提示する際は、必ずupdateEvent関数を使って具体的な変更内容を示してください
3. 一度に複数の改善点を提案せず、1つずつ段階的に進めてください

改善案がある場合は、updateEvent関数を呼び出して変更内容を具体的に示してください。


付加情報:
- 今日の日付は ${DateTime.now().toIso8601String()} です。
''';
    await sendMessage(prompt);
  }

  Future<void> sendMessage(String message) async {
    final value = state;
    final chatState = value.chatState;
    if (chatState.isLoading) {
      throw ChatAlreadyWaitingForResponseException(message);
    }

    // ユーザーメッセージに関数呼び出しを促す指示を追加
    final enhancedMessage = '''$message

重要: 改善提案をする場合は、必ずupdateEvent関数を使って具体的な変更内容を示してください。テキストでの説明だけでなく、関数呼び出しによる実際の変更案を提示してください。''';

    var newChatState = chatState.copyWith(
      isLoading: true,
      messages: [
        ...chatState.messages,
        ChatMessage.completedMessage(
          role: Role.user,
          message: message, // 元のメッセージを表示用に保持
          sentAt: DateTime.now(),
        ),
        ChatMessage.receivingMessage(
          role: Role.model,
          message: '',
          sentAt: DateTime.now(),
        ),
      ],
    );
    state = value.copyWith(chatState: newChatState);

    final responses = newChatState.session.sendMessageStream(
      Content.text(enhancedMessage), // 拡張メッセージを送信
    );
    final buffer = StringBuffer();
    EventEntry? proposed;
    await for (final response in responses) {
      if (response.text != null) {
        buffer.write(response.text);
      }
      if (response.functionCalls.isNotEmpty) {
        print('関数呼び出しが検出されました: ${response.functionCalls.length}個');
        final call = response.functionCalls.first;
        print('関数名: ${call.name}');
        print('引数: ${call.args}');
        if (call.name == 'updateEvent') {
          if (state.event != null) {
            proposed = _mergeEvent(state.event!, call.args);
            print('提案されたイベント: ${proposed.purpose}');
          } else {
            print('警告: state.eventがnullです');
          }
        }
      }
      newChatState = newChatState.copyWith(
        messages: [
          ...newChatState.messages.sublist(0, newChatState.messages.length - 1),
          ChatMessage.receivingMessage(
            role: Role.model,
            message: buffer.isNotEmpty
                ? buffer.toString()
                : 'No text message received',
            sentAt: DateTime.now(),
          ),
        ],
      );
      state = state.copyWith(chatState: newChatState);
    }

    newChatState = newChatState.copyWith(
      isLoading: false,
      messages: [
        ...newChatState.messages.sublist(0, newChatState.messages.length - 1),
        ChatMessage.completedMessage(
          role: Role.model,
          message: buffer.toString(),
          sentAt: DateTime.now(),
        ),
      ],
    );
    state = state.copyWith(chatState: newChatState, proposed: proposed);
  }

  void applyProposed() {
    final proposed = state.proposed;
    if (proposed != null) {
      state = state.copyWith(event: proposed, proposed: null);
    }
  }

  void clearProposed() {
    state = state.copyWith(proposed: null);
  }

  void clearAll() {
    final session = ref.watch(
      geminiFunctionCallSessionProvider([
        Tool.functionDeclarations([_updateEventTool]),
      ]),
    );
    state = ConsultEventState(
      chatState: ChatState(session: session),
      event: null,
    );
  }

  EventEntry _mergeEvent(EventEntry current, Map<String, Object?> args) {
    return current.copyWith(
      purpose: (args['purpose'] as String?) ?? current.purpose,
      candidateDateTimes: args['candidateDateTimes'] != null
          ? (args['candidateDateTimes']! as List)
                .whereType<String>()
                .map((e) => CandidateDateTime(start: DateTime.parse(e)))
                .toList()
          : current.candidateDateTimes,
      allergiesEtc: (args['allergiesEtc'] as String?) ?? current.allergiesEtc,
      budgetUpperLimit:
          (args['budgetUpperLimit'] as int?) ?? current.budgetUpperLimit,
      fixedQuestion: args['fixedQuestion'] != null
          ? List<String>.from(args['fixedQuestion']! as List)
          : current.fixedQuestion,
      minutes: (args['minutes'] as int?) ?? current.minutes,
    );
  }
}
