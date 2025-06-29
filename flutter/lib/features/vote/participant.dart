import 'package:cheers_planner/core/firebase/firestore_converters.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'participant.freezed.dart';
part 'participant.g.dart';

@freezed
sealed class EventParticipant with _$EventParticipant {
  const factory EventParticipant({
    String? id,
    String? eventId,
    required String name,
    required String phoneNumber,
    required String? positionOrGrade,
    required int desiredBudget,
    @DateTimeListToTimestampListConverter()
    required List<DateTime> desiredDates,
    required List<String> desiredLocations,
    @ListToMapConverter<QuestionAnswer>(prefix: 'custom-')
    required List<QuestionAnswer> customQuestions,
    @ListToMapConverter<QuestionAnswer>(prefix: 'question-')
    required List<QuestionAnswer> questions,
    required String allergiesEtc,
    @CreatedAtField() DateTime? submittedAt,
    @UpdatedAtField() DateTime? updatedAt,
  }) = _EventParticipant;
  factory EventParticipant.fromJson(Map<String, dynamic> json) =>
      _$EventParticipantFromJson(json);
}

@freezed
sealed class QuestionAnswer with _$QuestionAnswer {
  const factory QuestionAnswer({
    String? id,
    required String question,
    required String answer,
  }) = _QuestionAnswer;
  factory QuestionAnswer.fromJson(Map<String, dynamic> json) =>
      _$QuestionAnswerFromJson(json);
}
