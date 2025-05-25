class ChatException implements Exception {}

/// 既にメッセージを送信しGeminiからの応答を待っている場合に発生する例外
/// 例えば、Geminiからの応答を待っている間に再度メッセージを送信しようとした場合など
class ChatAlreadyWaitingForResponseException implements ChatException {
  const ChatAlreadyWaitingForResponseException(this.newMessage);
  final String newMessage;

  @override
  String toString() => 'ChatAlreadyWaitingForResponseException: $newMessage';
}
