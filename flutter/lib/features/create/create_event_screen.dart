import 'package:cheers_planner/core/app/snackbar_repo.dart';
import 'package:cheers_planner/core/firebase/auth_exception.dart';
import 'package:cheers_planner/core/firebase/auth_repo.dart';
import 'package:cheers_planner/core/router/root.dart';
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
    final deadline = useState<DateTime?>(null);
    final candidateDateTimes = useState<List<DateTime>>([]);
    final candidateAreas = useState<List<CandidateArea>>([]);
    final allergiesEtc = useTextEditingController();
    final budgetUpperLimit = useTextEditingController();
    final fixedQuestion = useState<List<String>>([]);
    final minutes = useTextEditingController();

    final selectDeadline = useCallback(() async {
      final selected = await showDatePicker(
        context: context,
        initialDate: deadline.value ?? DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime(2100),
      );
      if (selected != null) {
        deadline.value = selected;
      }
    }, [context, deadline]);

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

    Future<void> submit() async {
      try {
        loading.value = true;
        final parsedMinutes = int.parse(minutes.text);
        final uid = ref.read(requireUserProvider).uid;
        final id = await ref
            .read(eventEntriesRepoProvider)
            .add(
              EventEntry(
                purpose: eventName.text,
                dueDate: deadline.value ?? DateTime.now(),
                candidateDateTimes: candidateDateTimes.value
                    .map(
                      (e) => CandidateDateTime(
                        start: e,
                        end: e.add(Duration(minutes: parsedMinutes)),
                      ),
                    )
                    .toList(),
                candidateAreas: candidateAreas.value,
                allergiesEtc: allergiesEtc.text,
                organizerId: [uid],
                participantId: [uid],
                budgetUpperLimit: int.tryParse(budgetUpperLimit.text) ?? 0,
                fixedQuestion: fixedQuestion.value,
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
      appBar: AppBar(title: const Text('Create Plan')),
      body: Stack(
        alignment: Alignment.center,
        children: [
          Column(
            children: [
              TextField(
                controller: eventName,
                decoration: const InputDecoration(labelText: 'Event Name'),
              ),
              ElevatedButton(
                onPressed: selectDeadline,
                child: Text(
                  deadline.value == null
                      ? 'Select Deadline'
                      : 'Deadline: ${deadline.value!.toLocal()}',
                ),
              ),
              ValueListenableBuilder(
                valueListenable: minutes,
                builder: (context, value, child) {
                  return Column(
                    children: [
                      for (final candidateDateTime in candidateDateTimes.value)
                        Row(
                          children: [
                            Text(
                              '${candidateDateTime.toLocal()} - ${candidateDateTime.add(Duration(minutes: int.tryParse(minutes.text) ?? 0)).toLocal()}',
                            ),
                            IconButton(
                              icon: const Icon(Icons.delete),
                              onPressed: () =>
                                  deleteCandidateDateTime(candidateDateTime),
                            ),
                          ],
                        ),
                    ],
                  );
                },
              ),
              ElevatedButton(
                onPressed: addCandidateDateTime,
                child: const Text('日程候補を追加'),
              ),
              ElevatedButton(
                onPressed: () {
                  // Logic to add candidate areas
                  // For example, you can show a dialog to select areas
                  // and then add them to candidateAreas.value
                },
                child: const Text('Add Candidate Areas'),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: candidateAreas.value.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(candidateAreas.value[index].toString()),
                    );
                  },
                ),
              ),
              // 追加の質問を入力するためのテキストフィールド
              TextField(
                controller: budgetUpperLimit,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Budget Upper Limit',
                ),
              ),
              TextField(
                controller: minutes,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'Minutes'),
              ),
              TextField(
                controller: allergiesEtc,
                decoration: const InputDecoration(labelText: 'Allergies, etc.'),
              ),
              ElevatedButton(
                onPressed: submit,
                child: const Text('Submit Plan'),
              ),
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
