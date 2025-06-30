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
    required EventEntry event,
    EventEntry? proposed,
  }) = _ConsultEventState;
}

@riverpod
class ConsultEventController extends _$ConsultEventController {
  static final _updateEventTool = FunctionDeclaration(
    'updateEvent',
    'Update the event fields with the provided values.',
    parameters: {
      'purpose': Schema.string(description: 'Event name'),
      'candidateDateTimes': Schema.array(
        description: 'Candidate start times in ISO8601 format',
        items: Schema.string(),
      ),
      'allergiesEtc': Schema.string(description: 'Additional notes'),
      'budgetUpperLimit': Schema.integer(description: 'Budget upper limit'),
      'fixedQuestion': Schema.array(
        description: 'Questions for all participants',
        items: Schema.string(),
      ),
      'minutes': Schema.integer(description: 'Duration in minutes'),
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

  bool _started = false;

  @override
  ConsultEventState build(EventEntry initialEvent) {
    final session = ref.watch(
      geminiFunctionCallSessionProvider([
        Tool.functionDeclarations([_updateEventTool]),
      ]),
    );
    final chatState = ChatState(session: session);
    return ConsultEventState(chatState: chatState, event: initialEvent);
  }

  Future<void> startConsult() async {
    if (_started) return;
    _started = true;
    final e = state.event;
    final summary = [
      '目的: ${e.purpose}',
      '日程候補: ${e.candidateDateTimes.map((e) => e.start.toIso8601String()).join(', ')}',
      '予算上限: ${e.budgetUpperLimit}',
      '長さ: ${e.minutes}分',
      if (e.allergiesEtc.isNotEmpty) 'その他: ${e.allergiesEtc}',
      if (e.fixedQuestion.isNotEmpty) '全員への質問: ${e.fixedQuestion.join(' / ')}',
    ].join('\n');
    final prompt =
        '次のイベント案をより良くするために改善点を提案してください。必要に応じて"updateEvent"関数を用いて修正内容を返してください。\n$summary';
    await sendMessage(prompt);
  }

  Future<void> sendMessage(String message) async {
    var value = state;
    final chatState = value.chatState;
    if (chatState.isLoading) {
      throw ChatAlreadyWaitingForResponseException(message);
    }
    var newChatState = chatState.copyWith(
      isLoading: true,
      messages: [
        ...chatState.messages,
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
      Content.text(message),
    );
    final buffer = StringBuffer();
    EventEntry? proposed;
    await for (final response in responses) {
      if (response.text != null) {
        buffer.write(response.text);
      }
      if (response.functionCalls.isNotEmpty) {
        final call = response.functionCalls.first;
        if (call.name == 'updateEvent') {
          proposed = _mergeEvent(state.event, call.args);
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

  EventEntry _mergeEvent(EventEntry current, Map<String, Object?> args) {
    return current.copyWith(
      purpose: (args['purpose'] as String?) ?? current.purpose,
      candidateDateTimes: args['candidateDateTimes'] != null
          ? (args['candidateDateTimes'] as List)
                .whereType<String>()
                .map((e) => CandidateDateTime(start: DateTime.parse(e)))
                .toList()
          : current.candidateDateTimes,
      allergiesEtc: (args['allergiesEtc'] as String?) ?? current.allergiesEtc,
      budgetUpperLimit:
          (args['budgetUpperLimit'] as int?) ?? current.budgetUpperLimit,
      fixedQuestion: args['fixedQuestion'] != null
          ? List<String>.from(args['fixedQuestion'] as List)
          : current.fixedQuestion,
      minutes: (args['minutes'] as int?) ?? current.minutes,
    );
  }
}
