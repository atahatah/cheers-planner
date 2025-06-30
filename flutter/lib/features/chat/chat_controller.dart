import 'package:cheers_planner/core/firebase/firebase_ai_repo.dart';
import 'package:cheers_planner/features/chat/chat.dart';
import 'package:cheers_planner/features/chat/chat_exception.dart';
import 'package:firebase_ai/firebase_ai.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'chat_controller.g.dart';

@riverpod
class ChatController extends _$ChatController {
  @override
  ChatState build() {
    final session = ref.watch(geminiChatSessionProvider);
    return ChatState(session: session);
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
    final session = ref.read(geminiChatSessionProvider);
    state = ChatState(session: session);
  }
}
