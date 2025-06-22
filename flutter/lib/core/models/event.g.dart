// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Event _$EventFromJson(Map<String, dynamic> json) =>
    $checkedCreate('_Event', json, ($checkedConvert) {
      final val = _Event(
        id: $checkedConvert('id', (v) => v as String),
        organizerId: $checkedConvert(
          'organizerId',
          (v) => (v as List<dynamic>).map((e) => e as String).toList(),
        ),
        eventName: $checkedConvert('eventName', (v) => v as String),
        dueDate: $checkedConvert(
          'dueDate',
          (v) => const DateTimeToTimestampConverter().fromJson(v),
        ),
        minutes: $checkedConvert('minutes', (v) => (v as num).toInt()),
        budgetUpperLimit: $checkedConvert(
          'budgetUpperLimit',
          (v) => (v as num).toInt(),
        ),
        purpose: $checkedConvert('purpose', (v) => v as String),
        fixedQuestion: $checkedConvert(
          'fixedQuestion',
          (v) => (v as List<dynamic>).map((e) => e as String).toList(),
        ),
        candidateDateTimes: $checkedConvert(
          'candidateDateTimes',
          (v) => (v as Map<String, dynamic>?)?.map(
            (k, e) => MapEntry(
              k,
              CandidateDateTime.fromJson(e as Map<String, dynamic>),
            ),
          ),
        ),
        candidateAreas: $checkedConvert(
          'candidateAreas',
          (v) => (v as Map<String, dynamic>?)?.map(
            (k, e) =>
                MapEntry(k, CandidateArea.fromJson(e as Map<String, dynamic>)),
          ),
        ),
        aiRecArea: $checkedConvert('aiRecArea', (v) => v as String?),
        aiRecDate: $checkedConvert(
          'aiRecDate',
          (v) => const NullableDateTimeToTimestampConverter().fromJson(v),
        ),
        aiRecStore: $checkedConvert(
          'aiRecStore',
          (v) => (v as List<dynamic>?)?.map((e) => e as String).toList(),
        ),
        createdAt: $checkedConvert(
          'createdAt',
          (v) => const CreatedAtField().fromJson(v),
        ),
        updatedAt: $checkedConvert(
          'updatedAt',
          (v) => const UpdatedAtField().fromJson(v),
        ),
      );
      return val;
    });

Map<String, dynamic> _$EventToJson(_Event instance) => <String, dynamic>{
  'id': instance.id,
  'organizerId': instance.organizerId,
  'eventName': instance.eventName,
  'dueDate': const DateTimeToTimestampConverter().toJson(instance.dueDate),
  'minutes': instance.minutes,
  'budgetUpperLimit': instance.budgetUpperLimit,
  'purpose': instance.purpose,
  'fixedQuestion': instance.fixedQuestion,
  'candidateDateTimes': instance.candidateDateTimes?.map(
    (k, e) => MapEntry(k, e.toJson()),
  ),
  'candidateAreas': instance.candidateAreas?.map(
    (k, e) => MapEntry(k, e.toJson()),
  ),
  'aiRecArea': instance.aiRecArea,
  'aiRecDate': const NullableDateTimeToTimestampConverter().toJson(
    instance.aiRecDate,
  ),
  'aiRecStore': instance.aiRecStore,
  'createdAt': const CreatedAtField().toJson(instance.createdAt),
  'updatedAt': const UpdatedAtField().toJson(instance.updatedAt),
};

_CandidateDateTime _$CandidateDateTimeFromJson(Map<String, dynamic> json) =>
    $checkedCreate('_CandidateDateTime', json, ($checkedConvert) {
      final val = _CandidateDateTime(
        start: $checkedConvert(
          'start',
          (v) => const DateTimeToTimestampConverter().fromJson(v),
        ),
        end: $checkedConvert(
          'end',
          (v) => const DateTimeToTimestampConverter().fromJson(v),
        ),
      );
      return val;
    });

Map<String, dynamic> _$CandidateDateTimeToJson(_CandidateDateTime instance) =>
    <String, dynamic>{
      'start': const DateTimeToTimestampConverter().toJson(instance.start),
      'end': const DateTimeToTimestampConverter().toJson(instance.end),
    };

_CandidateArea _$CandidateAreaFromJson(Map<String, dynamic> json) =>
    $checkedCreate('_CandidateArea', json, ($checkedConvert) {
      final val = _CandidateArea(
        center: $checkedConvert(
          'center',
          (v) => const _GeoPointConverter().fromJson(v as Map<String, dynamic>),
        ),
        radius: $checkedConvert('radius', (v) => (v as num).toDouble()),
      );
      return val;
    });

Map<String, dynamic> _$CandidateAreaToJson(_CandidateArea instance) =>
    <String, dynamic>{
      'center': const _GeoPointConverter().toJson(instance.center),
      'radius': instance.radius,
    };

_Participant _$ParticipantFromJson(Map<String, dynamic> json) =>
    $checkedCreate('_Participant', json, ($checkedConvert) {
      final val = _Participant(
        id: $checkedConvert('id', (v) => v as String),
        name: $checkedConvert('name', (v) => v as String),
        phoneNumber: $checkedConvert('phoneNumber', (v) => v as String),
        positionOrGrade: $checkedConvert('positionOrGrade', (v) => v as String),
        desiredBudget: $checkedConvert(
          'desiredBudget',
          (v) => (v as num).toInt(),
        ),
        desiredDates: $checkedConvert(
          'desiredDates',
          (v) => const _DateTimeListConverter().fromJson(v as List),
        ),
        desiredLocations: $checkedConvert(
          'desiredLocations',
          (v) => (v as List<dynamic>).map((e) => e as String).toList(),
        ),
        allergiesEtc: $checkedConvert('allergiesEtc', (v) => v as String),
        submittedAt: $checkedConvert(
          'submittedAt',
          (v) => const DateTimeToTimestampConverter().fromJson(v),
        ),
        fixedQuestionAnswers: $checkedConvert(
          'fixedQuestionAnswers',
          (v) => (v as Map<String, dynamic>?)?.map(
            (k, e) => MapEntry(
              k,
              FixedQuestionAnswer.fromJson(e as Map<String, dynamic>),
            ),
          ),
        ),
        customQuestionAnswers: $checkedConvert(
          'customQuestionAnswers',
          (v) => (v as Map<String, dynamic>?)?.map(
            (k, e) => MapEntry(
              k,
              CustomQuestionAnswer.fromJson(e as Map<String, dynamic>),
            ),
          ),
        ),
        createdAt: $checkedConvert(
          'createdAt',
          (v) => const CreatedAtField().fromJson(v),
        ),
        updatedAt: $checkedConvert(
          'updatedAt',
          (v) => const UpdatedAtField().fromJson(v),
        ),
      );
      return val;
    });

Map<String, dynamic> _$ParticipantToJson(
  _Participant instance,
) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'phoneNumber': instance.phoneNumber,
  'positionOrGrade': instance.positionOrGrade,
  'desiredBudget': instance.desiredBudget,
  'desiredDates': const _DateTimeListConverter().toJson(instance.desiredDates),
  'desiredLocations': instance.desiredLocations,
  'allergiesEtc': instance.allergiesEtc,
  'submittedAt': const DateTimeToTimestampConverter().toJson(
    instance.submittedAt,
  ),
  'fixedQuestionAnswers': instance.fixedQuestionAnswers?.map(
    (k, e) => MapEntry(k, e.toJson()),
  ),
  'customQuestionAnswers': instance.customQuestionAnswers?.map(
    (k, e) => MapEntry(k, e.toJson()),
  ),
  'createdAt': const CreatedAtField().toJson(instance.createdAt),
  'updatedAt': const UpdatedAtField().toJson(instance.updatedAt),
};

_FixedQuestionAnswer _$FixedQuestionAnswerFromJson(Map<String, dynamic> json) =>
    $checkedCreate('_FixedQuestionAnswer', json, ($checkedConvert) {
      final val = _FixedQuestionAnswer(
        question: $checkedConvert('question', (v) => v as String),
        answer: $checkedConvert('answer', (v) => v as String),
      );
      return val;
    });

Map<String, dynamic> _$FixedQuestionAnswerToJson(
  _FixedQuestionAnswer instance,
) => <String, dynamic>{
  'question': instance.question,
  'answer': instance.answer,
};

_CustomQuestionAnswer _$CustomQuestionAnswerFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('_CustomQuestionAnswer', json, ($checkedConvert) {
  final val = _CustomQuestionAnswer(
    question: $checkedConvert('question', (v) => v as String),
    answer: $checkedConvert('answer', (v) => v as String),
  );
  return val;
});

Map<String, dynamic> _$CustomQuestionAnswerToJson(
  _CustomQuestionAnswer instance,
) => <String, dynamic>{
  'question': instance.question,
  'answer': instance.answer,
};

_EventResult _$EventResultFromJson(Map<String, dynamic> json) =>
    $checkedCreate('_EventResult', json, ($checkedConvert) {
      final val = _EventResult(
        optimalDate: $checkedConvert(
          'optimalDate',
          (v) => const DateTimeToTimestampConverter().fromJson(v),
        ),
        optimalEnd: $checkedConvert(
          'optimalEnd',
          (v) => const DateTimeToTimestampConverter().fromJson(v),
        ),
        restaurants: $checkedConvert(
          'restaurants',
          (v) => (v as List<dynamic>)
              .map((e) => Restaurant.fromJson(e as Map<String, dynamic>))
              .toList(),
        ),
        createdAt: $checkedConvert(
          'createdAt',
          (v) => const CreatedAtField().fromJson(v),
        ),
        updatedAt: $checkedConvert(
          'updatedAt',
          (v) => const UpdatedAtField().fromJson(v),
        ),
      );
      return val;
    });

Map<String, dynamic> _$EventResultToJson(_EventResult instance) =>
    <String, dynamic>{
      'optimalDate': const DateTimeToTimestampConverter().toJson(
        instance.optimalDate,
      ),
      'optimalEnd': const DateTimeToTimestampConverter().toJson(
        instance.optimalEnd,
      ),
      'restaurants': instance.restaurants.map((e) => e.toJson()).toList(),
      'createdAt': const CreatedAtField().toJson(instance.createdAt),
      'updatedAt': const UpdatedAtField().toJson(instance.updatedAt),
    };

_Restaurant _$RestaurantFromJson(Map<String, dynamic> json) => $checkedCreate(
  '_Restaurant',
  json,
  ($checkedConvert) {
    final val = _Restaurant(
      name: $checkedConvert('name', (v) => v as String),
      formattedAddress: $checkedConvert('formattedAddress', (v) => v as String),
      rating: $checkedConvert('rating', (v) => (v as num).toDouble()),
      priceLevel: $checkedConvert('priceLevel', (v) => (v as num).toInt()),
      menuHighlights: $checkedConvert('menuHighlights', (v) => v as String),
      accessInfo: $checkedConvert('accessInfo', (v) => v as String),
      placeId: $checkedConvert('placeId', (v) => v as String),
    );
    return val;
  },
);

Map<String, dynamic> _$RestaurantToJson(_Restaurant instance) =>
    <String, dynamic>{
      'name': instance.name,
      'formattedAddress': instance.formattedAddress,
      'rating': instance.rating,
      'priceLevel': instance.priceLevel,
      'menuHighlights': instance.menuHighlights,
      'accessInfo': instance.accessInfo,
      'placeId': instance.placeId,
    };
