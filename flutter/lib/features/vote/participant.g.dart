// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'participant.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_EventParticipant _$EventParticipantFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('_EventParticipant', json, ($checkedConvert) {
  final val = _EventParticipant(
    id: $checkedConvert('id', (v) => v as String?),
    eventId: $checkedConvert('eventId', (v) => v as String?),
    name: $checkedConvert('name', (v) => v as String),
    phoneNumber: $checkedConvert('phoneNumber', (v) => v as String),
    positionOrGrade: $checkedConvert('positionOrGrade', (v) => v as String?),
    desiredBudget: $checkedConvert('desiredBudget', (v) => (v as num).toInt()),
    desiredDates: $checkedConvert(
      'desiredDates',
      (v) => const DateTimeListToTimestampListConverter().fromJson(v as List),
    ),
    desiredLocations: $checkedConvert(
      'desiredLocations',
      (v) => (v as List<dynamic>).map((e) => e as String).toList(),
    ),
    customQuestions: $checkedConvert(
      'customQuestions',
      (v) => (v as List<dynamic>)
          .map((e) => QuestionAnswer.fromJson(e as Map<String, dynamic>))
          .toList(),
    ),
    questions: $checkedConvert(
      'questions',
      (v) => (v as List<dynamic>)
          .map((e) => QuestionAnswer.fromJson(e as Map<String, dynamic>))
          .toList(),
    ),
    allergiesEtc: $checkedConvert('allergiesEtc', (v) => v as String),
    submittedAt: $checkedConvert(
      'submittedAt',
      (v) => const CreatedAtField().fromJson(v),
    ),
    updatedAt: $checkedConvert(
      'updatedAt',
      (v) => const UpdatedAtField().fromJson(v),
    ),
  );
  return val;
});

Map<String, dynamic> _$EventParticipantToJson(
  _EventParticipant instance,
) => <String, dynamic>{
  'id': instance.id,
  'eventId': instance.eventId,
  'name': instance.name,
  'phoneNumber': instance.phoneNumber,
  'positionOrGrade': instance.positionOrGrade,
  'desiredBudget': instance.desiredBudget,
  'desiredDates': const DateTimeListToTimestampListConverter().toJson(
    instance.desiredDates,
  ),
  'desiredLocations': instance.desiredLocations,
  'customQuestions': instance.customQuestions.map((e) => e.toJson()).toList(),
  'questions': instance.questions.map((e) => e.toJson()).toList(),
  'allergiesEtc': instance.allergiesEtc,
  'submittedAt': const CreatedAtField().toJson(instance.submittedAt),
  'updatedAt': const UpdatedAtField().toJson(instance.updatedAt),
};

_QuestionAnswer _$QuestionAnswerFromJson(Map<String, dynamic> json) =>
    $checkedCreate('_QuestionAnswer', json, ($checkedConvert) {
      final val = _QuestionAnswer(
        id: $checkedConvert('id', (v) => v as String?),
        question: $checkedConvert('question', (v) => v as String),
        answer: $checkedConvert('answer', (v) => v as String),
      );
      return val;
    });

Map<String, dynamic> _$QuestionAnswerToJson(_QuestionAnswer instance) =>
    <String, dynamic>{
      'id': instance.id,
      'question': instance.question,
      'answer': instance.answer,
    };
