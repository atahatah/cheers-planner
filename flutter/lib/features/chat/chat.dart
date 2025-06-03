import 'package:cheers_planner/core/firebase/firebase_ai_repo.dart';
import 'package:cheers_planner/core/firebase/firestore_converters.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'chat.freezed.dart';

enum Role { user, model }

@freezed
sealed class ChatMessage with _$ChatMessage {
  const factory ChatMessage.completedMessage({
    required Role role,
    required String message,
    @DateTimeToTimestampConverter() DateTime? sentAt,
  }) = _ChatMessage;

  const factory ChatMessage.receivingMessage({
    required Role role,
    required String message,
    @DateTimeToTimestampConverter() DateTime? sentAt,
  }) = _ChatMessageReceiving;

  const factory ChatMessage.exception({
    required Role role,
    required String message,
    @DateTimeToTimestampConverter() DateTime? sentAt,
  }) = _ChatMessageException;
}

@freezed
sealed class ChatState with _$ChatState {
  const factory ChatState({
    required ChatSessionRepo session,
    @Default(false) bool isLoading,
    @Default([]) List<ChatMessage> messages,
    @CreatedAtField() DateTime? createdAt,
    @UpdatedAtField() DateTime? updatedAt,
  }) = _ChatState;

  // factory ChatState.fromJson(Map<String, dynamic> json) =>
  //     _$ChatStateFromJson(json);
}
