class NotSignedInException implements Exception {
  NotSignedInException([this.stackTrace]);
  StackTrace? stackTrace;
}
