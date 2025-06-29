import 'package:cheers_planner/core/app/snackbar_repo.dart';
import 'package:cheers_planner/core/hooks/google_map_controller_hook.dart';
import 'package:cheers_planner/core/router/root.dart';
import 'package:cheers_planner/features/create/event_entry.dart';
import 'package:cheers_planner/features/create/event_entry_repo.dart';
import 'package:cheers_planner/features/vote/participant.dart';
import 'package:cheers_planner/features/vote/participant_repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
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
    // 地図コントローラと選択状態
    final mapController = useGoogleMapController();
    final selectedAreaIds = useState<Set<int>>({});
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
      if (q.isEmpty || a.isEmpty) return;
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
        desiredLocations: selectedAreaIds.value
            .map(
              (i) =>
                  '${value.candidateAreas[i].location.latitude},${value.candidateAreas[i].location.longitude}',
            )
            .toList(),
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
      await ref.read(participantRepoProvider(eid)).add(participant);
      ref.read(snackBarRepoProvider).show('投票が完了しました！');
      const VotedListRoute().go(context);
    }

    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
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
            for (final cd in value.candidateDateTimes)
              CheckboxListTile(
                title: Text('${cd.start.toLocal()} - ${cd.end.toLocal()}'),
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
            const SizedBox(height: 16),
            // 候補場所マーカーをタップして選択
            const Text('場所候補', style: TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(
              height: 200,
              width: double.infinity,
              child: GoogleMap(
                initialCameraPosition: CameraPosition(
                  target: LatLng(
                    value.candidateAreas.first.location.latitude,
                    value.candidateAreas.first.location.longitude,
                  ),
                  zoom: 12,
                ),
                onMapCreated: mapController.onMapCreated,
                markers: {
                  for (var i = 0; i < value.candidateAreas.length; i++)
                    Marker(
                      markerId: MarkerId('area_$i'),
                      position: LatLng(
                        value.candidateAreas[i].location.latitude,
                        value.candidateAreas[i].location.longitude,
                      ),
                      icon: BitmapDescriptor.defaultMarkerWithHue(
                        selectedAreaIds.value.contains(i)
                            ? BitmapDescriptor.hueGreen
                            : BitmapDescriptor.hueRed,
                      ),
                      onTap: () {
                        final set = Set<int>.from(selectedAreaIds.value);
                        if (set.contains(i))
                          set.remove(i);
                        else
                          set.add(i);
                        selectedAreaIds.value = set;
                      },
                    ),
                },
                circles: {
                  for (final i in selectedAreaIds.value)
                    Circle(
                      circleId: CircleId('selected_area_$i'),
                      center: LatLng(
                        value.candidateAreas[i].location.latitude,
                        value.candidateAreas[i].location.longitude,
                      ),
                      radius: value.candidateAreas[i].radius.toDouble(),
                      strokeColor: Colors.green.withOpacity(0.8),
                      fillColor: Colors.green.withOpacity(0.3),
                    ),
                },
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
            ElevatedButton(
              onPressed: addCustomQA,
              child: const Text('カスタム質問を追加'),
            ),
            for (final qa in customQuestions.value)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('${qa.question}: ${qa.answer}'),
                  IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () =>
                        customQuestions.value = List.from(customQuestions.value)
                          ..remove(qa),
                  ),
                ],
              ),
            const SizedBox(height: 16),
            // アレルギー等
            TextField(
              controller: allergiesController,
              decoration: const InputDecoration(labelText: 'アレルギー等'),
            ),
            const SizedBox(height: 24),
            ElevatedButton(onPressed: submit, child: const Text('投票する')),
          ],
        ),
      ),
    );
  }
}
