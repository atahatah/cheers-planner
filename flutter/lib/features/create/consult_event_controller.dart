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
      if (entry.allergiesEtc?.isNotEmpty == true) 'その他: ${entry.allergiesEtc}',
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
    await _sendSystemMessage(prompt);
  }

  Future<void> sendMessage(String message) async {
    final value = state;
    final chatState = value.chatState;
    if (chatState.isLoading) {
      throw ChatAlreadyWaitingForResponseException(message);
    }

    // ユーザーメッセージの場合：チャット履歴に追加してから送信
    await _sendMessageInternal(
      message: message,
      addToHistory: true,
      enhanceWithSystemPrompt: true,
    );
  }

  // システムメッセージ用（チャット履歴に表示しない）
  Future<void> _sendSystemMessage(String message) async {
    final value = state;
    final chatState = value.chatState;
    if (chatState.isLoading) {
      throw ChatAlreadyWaitingForResponseException(message);
    }

    // システムメッセージの場合：チャット履歴に追加せずに送信
    await _sendMessageInternal(
      message: message,
      addToHistory: false,
      enhanceWithSystemPrompt: false,
    );
  }

  // 共通のメッセージ送信処理
  Future<void> _sendMessageInternal({
    required String message,
    required bool addToHistory,
    required bool enhanceWithSystemPrompt,
  }) async {
    final value = state;
    final chatState = value.chatState;

    // AIに送信するメッセージを構築
    final aiMessage = enhanceWithSystemPrompt
        ? '''$message

重要: 改善提案をする場合は、必ずupdateEvent関数を使って具体的な変更内容を示してください。テキストでの説明だけでなく、関数呼び出しによる実際の変更案を提示してください。'''
        : message;

    // チャット履歴の更新
    var newChatState = chatState.copyWith(
      isLoading: true,
      messages: [
        ...chatState.messages,
        // ユーザーメッセージの場合のみチャット履歴に追加
        if (addToHistory)
          ChatMessage.completedMessage(
            role: Role.user,
            message: message,
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
      Content.text(aiMessage),
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

  Future<void> applyProposed() async {
    final proposed = state.proposed;
    if (proposed != null) {
      // 提案を適用
      state = state.copyWith(event: proposed, proposed: null);

      // Geminiに承認を伝え、次の提案を求める
      final updatedEvent = proposed;
      final summary = [
        '目的: ${updatedEvent.purpose}',
        '日程候補: ${updatedEvent.candidateDateTimes.map((e) => e.start.toIso8601String()).join(', ')}',
        '予算上限: ${updatedEvent.budgetUpperLimit}円',
        '長さ: ${updatedEvent.minutes}分',
        if (updatedEvent.allergiesEtc?.isNotEmpty == true)
          'その他: ${updatedEvent.allergiesEtc}',
        if (updatedEvent.fixedQuestion.isNotEmpty)
          '全員への質問: ${updatedEvent.fixedQuestion.join(' / ')}',
      ].join('\n');

      final nextPrompt =
          '''前回の提案を承認いただきありがとうございます。

更新されたイベント内容:
$summary

次の改善提案をお願いします:
1. この企画の別の改善点を1つ提案してください
2. 改善案を提示する際は、必ずupdateEvent関数を使って具体的な変更内容を示してください
3. 一度に複数の改善点を提案せず、1つずつ段階的に進めてください

改善案がある場合は、updateEvent関数を呼び出して変更内容を具体的に示してください。''';

      await _sendSystemMessage(nextPrompt);
    }
  }

  Future<void> clearProposed() async {
    final currentEvent = state.event;
    state = state.copyWith(proposed: null);

    // Geminiに取り消しを伝え、別の提案を求める
    if (currentEvent != null) {
      final summary = [
        '目的: ${currentEvent.purpose}',
        '日程候補: ${currentEvent.candidateDateTimes.map((e) => e.start.toIso8601String()).join(', ')}',
        '予算上限: ${currentEvent.budgetUpperLimit}円',
        '長さ: ${currentEvent.minutes}分',
        if (currentEvent.allergiesEtc?.isNotEmpty == true)
          'その他: ${currentEvent.allergiesEtc}',
        if (currentEvent.fixedQuestion.isNotEmpty)
          '全員への質問: ${currentEvent.fixedQuestion.join(' / ')}',
      ].join('\n');

      final retryPrompt =
          '''前回の提案は採用されませんでした。

現在のイベント内容:
$summary

別の改善提案をお願いします:
1. 前回とは異なる改善点を1つ提案してください
2. 改善案を提示する際は、必ずupdateEvent関数を使って具体的な変更内容を示してください
3. 一度に複数の改善点を提案せず、1つずつ段階的に進めてください

改善案がある場合は、updateEvent関数を呼び出して変更内容を具体的に示してください。''';

      await _sendSystemMessage(retryPrompt);
    }
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
