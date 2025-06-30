// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event_draft.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_EventDraft _$EventDraftFromJson(Map<String, dynamic> json) =>
    $checkedCreate('_EventDraft', json, ($checkedConvert) {
      final val = _EventDraft(
        purpose: $checkedConvert('purpose', (v) => v as String),
        candidateDateTimes: $checkedConvert(
          'candidateDateTimes',
          (v) => (v as List<dynamic>)
              .map((e) => DateTime.parse(e as String))
              .toList(),
        ),
        allergiesEtc: $checkedConvert('allergiesEtc', (v) => v as String),
        budgetUpperLimit: $checkedConvert(
          'budgetUpperLimit',
          (v) => (v as num).toInt(),
        ),
        fixedQuestion: $checkedConvert(
          'fixedQuestion',
          (v) => (v as List<dynamic>).map((e) => e as String).toList(),
        ),
        minutes: $checkedConvert('minutes', (v) => (v as num).toInt()),
      );
      return val;
    });

Map<String, dynamic> _$EventDraftToJson(_EventDraft instance) =>
    <String, dynamic>{
      'purpose': instance.purpose,
      'candidateDateTimes': instance.candidateDateTimes
          .map((e) => e.toIso8601String())
          .toList(),
      'allergiesEtc': instance.allergiesEtc,
      'budgetUpperLimit': instance.budgetUpperLimit,
      'fixedQuestion': instance.fixedQuestion,
      'minutes': instance.minutes,
    };
