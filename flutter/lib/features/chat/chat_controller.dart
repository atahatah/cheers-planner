import 'package:cheers_planner/index.dart';
import 'package:firebase_ai/firebase_ai.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'chat_controller.g.dart';

@riverpod
class ChatController extends _$ChatController {
  @override
  ChatState build() {
    final gemini = ref.watch(geminiModelRepoProvider);
    return ChatState(session: gemini.startChat());
  }

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
    final responses = state.session.sendMessageStream(Content.text(message));
    final wholeResponseMessage = StringBuffer();
    await for (final response in responses) {
      if (response.text != null) {
        wholeResponseMessage.write(response.text);
      }
      state = state.copyWith(
        messages: [
          ...state.messages.sublist(0, state.messages.length - 1),
          ChatMessage.receivingMessage(
            role: Role.model,
            message: wholeResponseMessage.length > 0
                ? wholeResponseMessage.toString()
                : 'No text message received',
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
          message: wholeResponseMessage.toString(),
          sentAt: DateTime.now(),
        ),
      ],
    );
  }

  void clearMessages() {
    final gemini = ref.read(geminiModelRepoProvider);
    state = ChatState(session: gemini.startChat());
  }
}
