import 'package:cheers_planner/core/firebase/firebase_ai_repo.dart';
import 'package:cheers_planner/features/chat/chat.dart';
import 'package:cheers_planner/features/chat/chat_exception.dart';
import 'package:cheers_planner/features/create/event_draft.dart';
import 'package:cheers_planner/features/create/event_draft_controller.dart';
import 'package:firebase_ai/firebase_ai.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'consult_event_controller.g.dart';

@riverpod
class ConsultEventController extends _$ConsultEventController {
  ChatSession? _session;
  EventDraft? _pendingDraft;

  @override
  ChatState build() {
    final firebaseAI = ref.watch(firebaseAiProvider);
    final model = ref.watch(generativeAIModelProvider);
    final generativeModel = firebaseAI.generativeModel(
      model: model.fullName,
      tools: [
        Tool.functionDeclarations([_updateDraftDeclaration]),
      ],
      toolConfig: ToolConfig(
        functionCallingConfig: FunctionCallingConfig.auto(),
      ),
    );
    _session = generativeModel.startChat();
    return ChatState(session: _ChatSessionRepoImpl(_session!));
  }

  static final _updateDraftDeclaration = FunctionDeclaration(
    'updateEventDraft',
    'Update the event draft fields. All parameters are optional.',
    parameters: {
      'purpose': Schema.string(description: 'Event name'),
      'candidateDateTimes': Schema.array(
        items: Schema.string(format: 'date-time'),
        description: 'Candidate date times in ISO8601 format',
      ),
      'allergiesEtc': Schema.string(description: 'Notes about allergies etc'),
      'budgetUpperLimit': Schema.integer(
        description: 'Budget upper limit in yen',
      ),
      'fixedQuestion': Schema.array(
        items: Schema.string(),
        description: 'Questions for participants',
      ),
      'minutes': Schema.integer(description: 'Event duration in minutes'),
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

  Future<void> addMessage(String message) async {
    if (state.isLoading) {
      throw ChatAlreadyWaitingForResponseException(message);
    }
    state = state.copyWith(
      isLoading: true,
      messages: [
        ...state.messages,
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
    final responses = _session!.sendMessageStream(Content.text(message));
    final whole = StringBuffer();
    await for (final response in responses) {
      if (response.text != null) {
        whole.write(response.text);
      }
      if (response.functionCalls.isNotEmpty) {
        final call = response.functionCalls.first;
        _pendingDraft = _mergeDraft(call.args);
      }
      state = state.copyWith(
        messages: [
          ...state.messages.sublist(0, state.messages.length - 1),
          ChatMessage.receivingMessage(
            role: Role.model,
            message: whole.toString(),
            sentAt: DateTime.now(),
          ),
        ],
      );
    }
    state = state.copyWith(
      isLoading: false,
      messages: [
        ...state.messages.sublist(0, state.messages.length - 1),
        ChatMessage.completedMessage(
          role: Role.model,
          message: whole.toString(),
          sentAt: DateTime.now(),
        ),
      ],
    );
  }

  EventDraft? get pendingDraft => _pendingDraft;

  void applyPendingDraft() {
    final draft = _pendingDraft;
    if (draft == null) {
      return;
    }
    ref.read(eventDraftControllerProvider.notifier).update(draft);
    _pendingDraft = null;
  }

  EventDraft _mergeDraft(Map<String, Object?> args) {
    final current = ref.read(eventDraftControllerProvider);
    List<DateTime>? candidateDateTimes;
    if (args['candidateDateTimes'] case final List<dynamic> list) {
      candidateDateTimes = list
          .map((e) => DateTime.parse(e as String))
          .toList();
    }
    return current.copyWith(
      purpose: args['purpose'] as String? ?? current.purpose,
      allergiesEtc: args['allergiesEtc'] as String? ?? current.allergiesEtc,
      budgetUpperLimit:
          args['budgetUpperLimit'] as int? ?? current.budgetUpperLimit,
      fixedQuestion: args['fixedQuestion'] != null
          ? List<String>.from(args['fixedQuestion'] as List)
          : current.fixedQuestion,
      minutes: args['minutes'] as int? ?? current.minutes,
      candidateDateTimes: candidateDateTimes ?? current.candidateDateTimes,
    );
  }
}

class _ChatSessionRepoImpl implements ChatSessionRepo {
  _ChatSessionRepoImpl(this._session);
  final ChatSession _session;

  @override
  Future<GenerateContentResponse> sendMessage(Content message) =>
      _session.sendMessage(message);

  @override
  Stream<GenerateContentResponse> sendMessageStream(Content message) =>
      _session.sendMessageStream(message);
}
