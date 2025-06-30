import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'event_entry.dart';

part 'event_draft_provider.g.dart';

@riverpod
class EventDraft extends _$EventDraft {
  @override
  EventEntry build() => const EventEntry(
    purpose: '',
    candidateDateTimes: [],
    allergiesEtc: '',
    organizerId: [],
    budgetUpperLimit: 0,
    fixedQuestion: [],
    minutes: 60,
  );

  void update(EventEntry newDraft) {
    state = newDraft;
  }
}
