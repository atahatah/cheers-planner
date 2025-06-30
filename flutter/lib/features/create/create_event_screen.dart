import 'package:cheers_planner/core/app/snackbar_repo.dart';
import 'package:cheers_planner/core/firebase/auth_exception.dart';
import 'package:cheers_planner/core/firebase/auth_repo.dart';
import 'package:cheers_planner/core/router/root.dart';
import 'package:cheers_planner/features/create/event_draft.dart';
import 'package:cheers_planner/features/create/event_draft_controller.dart';
import 'package:cheers_planner/features/create/event_entry.dart';
import 'package:cheers_planner/features/create/event_entry_repo.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class CreateEventScreen extends HookConsumerWidget {
  const CreateEventScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loading = useState(false);
    final eventName = useTextEditingController();
    final candidateDateTimes = useState<List<DateTime>>([]);
    final allergiesEtc = useTextEditingController();
    final budgetUpperLimit = useTextEditingController();
    final minutes = useTextEditingController(text: '60');
    // 固定質問用のTextEditingControllerリスト
    final questionControllers = useState<List<TextEditingController>>([]);

    final draft = ref.watch(eventDraftControllerProvider);

    useEffect(() {
      eventName.text = draft.purpose;
      allergiesEtc.text = draft.allergiesEtc;
      budgetUpperLimit.text = draft.budgetUpperLimit.toString();
      minutes.text = draft.minutes.toString();
      candidateDateTimes.value = draft.candidateDateTimes;
      questionControllers.value = [
        for (final q in draft.fixedQuestion) TextEditingController(text: q),
      ];
      return null;
    }, [draft]);

    final deleteCandidateDateTime = useCallback((DateTime candidateDateTime) {
      candidateDateTimes.value = List.from(candidateDateTimes.value)
        ..removeAt(candidateDateTimes.value.indexOf(candidateDateTime));
    }, [candidateDateTimes]);

    final addCandidateDateTime = useCallback(() async {
      // 日付と時間を選択するためのダイアログを表示
      final selectedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime(2100),
      );
      if (selectedDate == null) {
        return;
      }
      final selectedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
      );
      if (selectedTime == null) {
        return;
      }
      // 選択された日付と時間を結合してDateTimeを作成
      final candidateDateTime = DateTime(
        selectedDate.year,
        selectedDate.month,
        selectedDate.day,
        selectedTime.hour,
        selectedTime.minute,
      );
      // 候補日時リストに追加
      candidateDateTimes.value = [
        ...candidateDateTimes.value,
        candidateDateTime,
      ];
    }, [context, candidateDateTimes]);

    void consultGemini() {
      final fixedQuestions = questionControllers.value
          .map((c) => c.text)
          .where((t) => t.isNotEmpty)
          .toList();
      final draft = EventDraft(
        purpose: eventName.text,
        candidateDateTimes: candidateDateTimes.value,
        allergiesEtc: allergiesEtc.text,
        budgetUpperLimit: int.tryParse(budgetUpperLimit.text) ?? 0,
        fixedQuestion: fixedQuestions,
        minutes: int.tryParse(minutes.text) ?? 60,
      );
      ref.read(eventDraftControllerProvider.notifier).update(draft);
      const ConsultEventRoute().push<void>(context);
    }

    Future<void> submit() async {
      try {
        loading.value = true;
        final parsedMinutes = int.parse(minutes.text);
        final uid = ref.read(requireUserProvider).uid;
        // 固定質問リストを取得
        final fixedQuestions = questionControllers.value
            .map((c) => c.text)
            .where((t) => t.isNotEmpty)
            .toList();
        final id = await ref
            .read(eventEntriesRepoProvider)
            .add(
              EventEntry(
                purpose: eventName.text,
                candidateDateTimes: candidateDateTimes.value
                    .map((e) => CandidateDateTime(start: e))
                    .toList(),
                allergiesEtc: allergiesEtc.text,
                organizerId: [uid],
                budgetUpperLimit: int.tryParse(budgetUpperLimit.text) ?? 0,
                fixedQuestion: fixedQuestions,
                minutes: parsedMinutes,
              ),
            );
        ManagementRoute(id).go(context);
      } on NotSignedInException {
        ref.read(snackBarRepoProvider).show('ログインしていません。ログインしてください。');
      } on FirebaseException {
        ref
            .read(snackBarRepoProvider)
            .show('サーバーに保存することができませんでした。時間をおいて再度お試しください。');
      } on Exception catch (e) {
        ref.read(snackBarRepoProvider).show('予期せぬエラーが発生しました。時間をおいて再度お試しください。');
        debugPrint('Error: $e');
      } finally {
        loading.value = false;
      }
    }

    return Scaffold(
      appBar: AppBar(title: const Text('イベント作成')),
      body: Stack(
        alignment: Alignment.center,
        children: [
          Column(
            children: [
              TextField(
                controller: eventName,
                decoration: const InputDecoration(labelText: 'イベント名'),
              ),
              Column(
                children: [
                  for (final candidateDateTime in candidateDateTimes.value)
                    Row(
                      children: [
                        Text('${candidateDateTime.toLocal()}'),
                        IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () =>
                              deleteCandidateDateTime(candidateDateTime),
                        ),
                      ],
                    ),
                ],
              ),
              ElevatedButton(
                onPressed: addCandidateDateTime,
                child: const Text('日程候補を追加'),
              ),
              TextField(
                controller: budgetUpperLimit,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: '予算の上限(円)'),
              ),
              TextField(
                controller: minutes,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: '長さ(分)'),
              ),
              TextField(
                controller: allergiesEtc,
                decoration: const InputDecoration(labelText: 'その他のアレルギー等'),
              ),
              // 固定質問の入力セクション
              Column(
                children: [
                  for (var i = 0; i < questionControllers.value.length; i++)
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: questionControllers.value[i],
                            decoration: InputDecoration(
                              labelText: '質問 ${i + 1}',
                            ),
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () {
                            questionControllers.value = List.from(
                              questionControllers.value,
                            )..removeAt(i);
                          },
                        ),
                      ],
                    ),
                  ElevatedButton(
                    onPressed: () {
                      questionControllers.value = [
                        ...questionControllers.value,
                        TextEditingController(),
                      ];
                    },
                    child: const Text('カスタムの質問を追加'),
                  ),
                  ElevatedButton(
                    onPressed: consultGemini,
                    child: const Text('Geminiと相談'),
                  ),
                ],
              ),
              ElevatedButton(onPressed: submit, child: const Text('イベントを作成')),
            ],
          ),
          if (loading.value) ...[
            ModalBarrier(
              dismissible: false,
              color: Theme.of(context).colorScheme.onSurface.withAlpha(150),
            ),
            const Center(child: CircularProgressIndicator()),
          ],
        ],
      ),
    );
  }
}
