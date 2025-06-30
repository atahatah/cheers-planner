import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'event_draft.dart';

part 'event_draft_controller.g.dart';

@riverpod
class EventDraftController extends _$EventDraftController {
  @override
  EventDraft build() {
    return const EventDraft(
      purpose: '',
      candidateDateTimes: [],
      allergiesEtc: '',
      budgetUpperLimit: 0,
      fixedQuestion: [],
      minutes: 60,
    );
  }

  void update(EventDraft draft) {
    state = draft;
  }
}
