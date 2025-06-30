import 'package:cheers_planner/core/app/snackbar_repo.dart';
import 'package:cheers_planner/core/firebase/auth_exception.dart';
import 'package:cheers_planner/core/firebase/auth_repo.dart';
import 'package:cheers_planner/core/router/root.dart';
import 'package:cheers_planner/features/create/consult_event_controller.dart';
import 'package:cheers_planner/features/create/event_entry.dart';
import 'package:cheers_planner/features/create/event_entry_repo.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class CreateEventScreen extends HookConsumerWidget {
  const CreateEventScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loading = useState(false);
    final formKey = useMemoized(GlobalKey<FormState>.new);
    final eventName = useTextEditingController();
    final candidateDateTimes = useState<List<DateTime>>([]);
    final allergiesEtc = useTextEditingController();
    final budgetUpperLimit = useTextEditingController();
    final minutes = useTextEditingController(text: '60');
    // 固定質問用のTextEditingControllerリスト
    final questionControllers = useState<List<TextEditingController>>([]);

    ref.listen(consultEventControllerProvider.select((e) => e.event), (
      _,
      event,
    ) {
      if (event != null) {
        // 相談結果が更新されたら、入力フィールドに反映
        eventName.text = event.purpose;
        candidateDateTimes.value = event.candidateDateTimes
            .map((e) => e.start)
            .toList();
        allergiesEtc.text = event.allergiesEtc ?? '';
        budgetUpperLimit.text = event.budgetUpperLimit.toString();
        minutes.text = event.minutes.toString();
        questionControllers.value = event.fixedQuestion
            .map((q) => TextEditingController(text: q))
            .toList();
      }
    });

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
          Form(
            key: formKey,
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // ------- 基本情報 -------
                  Card(
                    elevation: 2,
                    margin: const EdgeInsets.only(bottom: 16),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '基本情報',
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          const SizedBox(height: 12),
                          _buildTextForm(
                            controller: eventName,
                            label: 'イベント名',
                            validator: (v) =>
                                v == null || v.isEmpty ? '必須項目です' : null,
                          ),
                          const SizedBox(height: 12),
                          _buildTextForm(
                            controller: budgetUpperLimit,
                            label: '予算の上限(円)',
                            keyboardType: TextInputType.number,
                          ),
                          const SizedBox(height: 12),
                          _buildTextForm(
                            controller: minutes,
                            label: '長さ(分)',
                            keyboardType: TextInputType.number,
                          ),
                          const SizedBox(height: 12),
                          _buildTextForm(
                            controller: allergiesEtc,
                            label: 'アレルギー・備考',
                            maxLines: 2,
                          ),
                        ],
                      ),
                    ),
                  ),

                  // ------- 日時候補 -------
                  Card(
                    elevation: 2,
                    margin: const EdgeInsets.only(bottom: 16),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                '日時候補',
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                              TextButton.icon(
                                onPressed: addCandidateDateTime,
                                icon: const Icon(Icons.add),
                                label: const Text('追加'),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          if (candidateDateTimes.value.isEmpty)
                            Text(
                              '未登録',
                              style: Theme.of(context).textTheme.bodySmall
                                  ?.copyWith(
                                    color: Theme.of(
                                      context,
                                    ).colorScheme.outline,
                                  ),
                            ),
                          for (final dt in candidateDateTimes.value)
                            ListTile(
                              title: Text(_formatDateTime(dt)),
                              trailing: IconButton(
                                icon: const Icon(Icons.delete),
                                onPressed: () => deleteCandidateDateTime(dt),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),

                  // ------- 固定質問 -------
                  Card(
                    elevation: 2,
                    margin: const EdgeInsets.only(bottom: 24),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'アンケート質問',
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                              TextButton.icon(
                                onPressed: () {
                                  questionControllers.value = [
                                    ...questionControllers.value,
                                    TextEditingController(),
                                  ];
                                },
                                icon: const Icon(Icons.add),
                                label: const Text('追加'),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          if (questionControllers.value.isEmpty)
                            Text(
                              'なし',
                              style: Theme.of(context).textTheme.bodySmall
                                  ?.copyWith(
                                    color: Theme.of(
                                      context,
                                    ).colorScheme.outline,
                                  ),
                            ),
                          for (
                            var i = 0;
                            i < questionControllers.value.length;
                            i++
                          )
                            ListTile(
                              title: TextField(
                                controller: questionControllers.value[i],
                                decoration: InputDecoration(
                                  labelText: '質問 ${i + 1}',
                                ),
                              ),
                              trailing: IconButton(
                                icon: const Icon(Icons.delete),
                                onPressed: () {
                                  questionControllers.value = List.from(
                                    questionControllers.value,
                                  )..removeAt(i);
                                },
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),

                  // ------- ボタン -------
                  ElevatedButton.icon(
                    onPressed: () {
                      final draft = EventEntry(
                        purpose: eventName.text,
                        candidateDateTimes: candidateDateTimes.value
                            .map((e) => CandidateDateTime(start: e))
                            .toList(),
                        allergiesEtc: allergiesEtc.text,
                        organizerId: const [],
                        budgetUpperLimit:
                            int.tryParse(budgetUpperLimit.text) ?? 0,
                        fixedQuestion: questionControllers.value
                            .map((c) => c.text)
                            .where((t) => t.isNotEmpty)
                            .toList(),
                        minutes: int.tryParse(minutes.text) ?? 60,
                      );
                      context.push(const ConsultRoute().location, extra: draft);
                    },
                    icon: const Icon(Icons.chat),
                    label: const Text('Geminiと相談'),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                  ),
                  const SizedBox(height: 12),
                  ElevatedButton.icon(
                    onPressed: () {
                      if (formKey.currentState?.validate() != true) {
                        return;
                      }
                      submit();
                    },
                    icon: const Icon(Icons.check_circle),
                    label: const Text('イベントを作成'),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                  ),
                ],
              ),
            ),
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

  // ------- ヘルパー -------
  Widget _buildTextForm({
    required TextEditingController controller,
    required String label,
    TextInputType? keyboardType,
    int maxLines = 1,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      maxLines: maxLines,
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
      ),
      validator: validator,
    );
  }

  String _formatDateTime(DateTime dt) {
    return '${dt.month}/${dt.day} ${dt.hour.toString().padLeft(2, '0')}:${dt.minute.toString().padLeft(2, '0')}';
  }
}
