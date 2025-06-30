import 'package:cheers_planner/core/app/snackbar_repo.dart';
import 'package:cheers_planner/core/firebase/auth_repo.dart';
import 'package:cheers_planner/core/router/root.dart';
import 'package:cheers_planner/features/create/event_entry.dart';
import 'package:cheers_planner/features/create/event_entry_repo.dart';
import 'package:cheers_planner/features/vote/participant.dart';
import 'package:cheers_planner/features/vote/participant_repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class VoteScreen extends HookConsumerWidget {
  const VoteScreen({super.key, required this.eventId});
  final String eventId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncEventEntry = ref.watch(eventEntryProvider(eventId));
    return switch (asyncEventEntry) {
      AsyncLoading() => Scaffold(
        appBar: AppBar(title: const Text('投票画面')),
        body: const Center(child: CircularProgressIndicator()),
      ),
      AsyncError(:final error, stackTrace: _) => Scaffold(
        appBar: AppBar(title: const Text('投票画面')),
        body: Center(child: Text('エラーが発生しました: $error')),
      ),
      AsyncData(:final value) => Scaffold(
        appBar: AppBar(title: Text('${value.purpose}の投票')),
        body: VoteBody(value: value),
      ),
      _ => const SizedBox.shrink(),
    };
  }
}

class VoteBody extends HookConsumerWidget {
  const VoteBody({super.key, required this.value});

  final EventEntry value;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // --- フォームコントローラと状態管理 ---
    final nameController = useTextEditingController();
    final phoneController = useTextEditingController();
    final positionController = useTextEditingController();
    final budgetController = useTextEditingController();
    final allergiesController = useTextEditingController();
    // 選択用状態
    final desiredDates = useState<List<DateTime>>([]);
    final desiredLocations = useState<List<String>>([]);
    final answerControllers = useMemoized(() {
      return Map<String, TextEditingController>.fromEntries(
        value.fixedQuestion.map((q) => MapEntry(q, TextEditingController())),
      );
    }, [value.fixedQuestion]);
    final customQuestionController = useTextEditingController();
    final customAnswerController = useTextEditingController();
    final customQuestions = useState<List<QuestionAnswer>>([]);

    // カスタム質問追加
    void addCustomQA() {
      final q = customQuestionController.text;
      final a = customAnswerController.text;
      if (q.isEmpty || a.isEmpty) {
        return;
      }
      customQuestions.value = [
        ...customQuestions.value,
        QuestionAnswer(question: q, answer: a),
      ];
      customQuestionController.clear();
      customAnswerController.clear();
    }

    // 投票送信
    Future<void> submit() async {
      final participant = EventParticipant(
        eventId: value.id,
        name: nameController.text,
        phoneNumber: phoneController.text,
        positionOrGrade: positionController.text,
        desiredBudget: int.tryParse(budgetController.text) ?? 0,
        desiredDates: desiredDates.value,
        desiredLocations: desiredLocations.value,
        fixedQuestionAnswers: value.fixedQuestion
            .map(
              (q) => QuestionAnswer(
                question: q,
                answer: answerControllers[q]!.text,
              ),
            )
            .toList(),
        customQuestions: customQuestions.value,
        allergiesEtc: allergiesController.text,
      );
      // 参加者情報を Firestore に保存
      final eid = value.id!;
      final uid = ref.read(requireUserProvider).uid;
      await ref.read(participantRepoProvider(eid)).set(uid, participant);
      await ref.read(eventEntryRepoProvider(eid)).addParticipant(eid, uid);
      ref.read(snackBarRepoProvider).show('投票が完了しました！');
      const VotedListRoute().go(context);
    }

    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 名前
            TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: '名前'),
            ),
            const SizedBox(height: 8),
            // 電話番号
            TextField(
              controller: phoneController,
              keyboardType: TextInputType.phone,
              decoration: const InputDecoration(labelText: '電話番号'),
            ),
            const SizedBox(height: 8),
            // 学年/役職
            TextField(
              controller: positionController,
              decoration: const InputDecoration(labelText: '学年/役職'),
            ),
            const SizedBox(height: 8),
            // 希望予算
            TextField(
              controller: budgetController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: '希望予算'),
            ),
            const SizedBox(height: 16),
            // 候補日時から選択
            const Text('日時候補', style: TextStyle(fontWeight: FontWeight.bold)),
            Card(
              child: Column(
                children: [
                  for (final cd in value.candidateDateTimes)
                    CheckboxListTile(
                      title: Text(
                        '${cd.start.toLocal()} - ${cd.start.add(Duration(minutes: value.minutes)).toLocal()}',
                      ),
                      value: desiredDates.value.contains(cd.start),
                      onChanged: (selected) {
                        final list = List<DateTime>.from(desiredDates.value);
                        if (selected == true) {
                          list.add(cd.start);
                        } else {
                          list.remove(cd.start);
                        }
                        desiredDates.value = list;
                      },
                    ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            // 場所候補を文字列で追加
            const Text('場所候補', style: TextStyle(fontWeight: FontWeight.bold)),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Column(
                  children: [
                    TextField(
                      decoration: const InputDecoration(labelText: '場所候補を入力'),
                      onSubmitted: (value) {
                        if (value.isNotEmpty) {
                          desiredLocations.value = List.from(
                            desiredLocations.value,
                          )..add(value);
                        }
                      },
                    ),
                    for (final location in desiredLocations.value)
                      ListTile(
                        title: Text(location),
                        trailing: const Icon(Icons.delete),
                        onTap: () {
                          desiredLocations.value = List.from(
                            desiredLocations.value,
                          )..remove(location);
                        },
                      ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 16),
            // 質問への回答
            for (final q in value.fixedQuestion)
              Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: TextField(
                  controller: answerControllers[q],
                  decoration: InputDecoration(labelText: q),
                ),
              ),
            const SizedBox(height: 16),
            // カスタム質問追加
            Card(
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Column(
                  children: [
                    TextField(
                      controller: customQuestionController,
                      decoration: const InputDecoration(labelText: '追加質問'),
                    ),
                    const SizedBox(height: 8),
                    TextField(
                      controller: customAnswerController,
                      decoration: const InputDecoration(labelText: '回答'),
                    ),
                    const SizedBox(height: 8),
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton.icon(
                        onPressed: addCustomQA,
                        icon: const Icon(Icons.add),
                        label: const Text('カスタム質問を追加'),
                      ),
                    ),
                    for (final qa in customQuestions.value)
                      ListTile(
                        title: Text('${qa.question}: ${qa.answer}'),
                        trailing: const Icon(Icons.delete),
                        onTap: () => customQuestions.value = List.from(
                          customQuestions.value,
                        )..remove(qa),
                      ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            // アレルギー等
            TextField(
              controller: allergiesController,
              decoration: const InputDecoration(labelText: 'アレルギー等'),
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: submit,
                child: const Text('投票する'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
