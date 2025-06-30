import 'package:freezed_annotation/freezed_annotation.dart';

part 'event_draft.freezed.dart';
part 'event_draft.g.dart';

@freezed
sealed class EventDraft with _$EventDraft {
  const factory EventDraft({
    required String purpose,
    required List<DateTime> candidateDateTimes,
    required String allergiesEtc,
    required int budgetUpperLimit,
    required List<String> fixedQuestion,
    required int minutes,
  }) = _EventDraft;

  factory EventDraft.fromJson(Map<String, dynamic> json) =>
      _$EventDraftFromJson(json);
}
