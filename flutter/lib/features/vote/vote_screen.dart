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
    final formKey = useMemoized(GlobalKey<FormState>.new);
    final nameController = useTextEditingController();
    final phoneController = useTextEditingController();
    final positionController = useTextEditingController();
    final budgetController = useTextEditingController();
    final allergiesController = useTextEditingController();

    // 選択用状態
    final desiredDates = useState<List<DateTime>>([]);
    final desiredLocations = useState<List<String>>([]);

    // 質問への回答用コントローラを生成
    final answerControllers = useMemoized(() {
      return {for (final q in value.fixedQuestion) q: TextEditingController()};
    }, [value.fixedQuestion]);

    // カスタムQA
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

    return Form(
      key: formKey,
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // ----- 基本情報カード -----
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
                      controller: nameController,
                      label: '名前',
                      validator: (v) =>
                          v == null || v.isEmpty ? '必須項目です' : null,
                    ),
                    const SizedBox(height: 12),
                    _buildTextForm(
                      controller: phoneController,
                      label: '電話番号',
                      keyboardType: TextInputType.phone,
                    ),
                    const SizedBox(height: 12),
                    _buildTextForm(
                      controller: positionController,
                      label: '学年/役職',
                    ),
                  ],
                ),
              ),
            ),

            // ----- 予算 & アレルギー -----
            Card(
              elevation: 2,
              margin: const EdgeInsets.only(bottom: 16),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '予算・アレルギー',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 12),
                    _buildTextForm(
                      controller: budgetController,
                      label: '希望予算 (円/人)',
                      keyboardType: TextInputType.number,
                    ),
                    const SizedBox(height: 12),
                    _buildTextForm(
                      controller: allergiesController,
                      label: 'アレルギー・その他',
                      maxLines: 2,
                    ),
                  ],
                ),
              ),
            ),

            // ----- 日時候補 -----
            Card(
              elevation: 2,
              margin: const EdgeInsets.only(bottom: 16),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '日時を選択',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 12),
                    for (final cd in value.candidateDateTimes)
                      CheckboxListTile(
                        contentPadding: EdgeInsets.zero,
                        title: Text(
                          '${_formatDateTime(cd.start)} – ${_formatDateTime(cd.start.add(Duration(minutes: value.minutes)))}',
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
                    if (desiredDates.value.isEmpty)
                      Padding(
                        padding: const EdgeInsets.only(top: 8),
                        child: Text(
                          '※ 少なくとも1つ選択してください',
                          style: Theme.of(context).textTheme.bodySmall
                              ?.copyWith(
                                color: Theme.of(context).colorScheme.error,
                              ),
                        ),
                      ),
                  ],
                ),
              ),
            ),

            // ----- 場所候補 -----
            Card(
              elevation: 2,
              margin: const EdgeInsets.only(bottom: 16),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '場所候補',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 12),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: [
                        for (final loc in desiredLocations.value)
                          Chip(
                            label: Text(loc),
                            onDeleted: () {
                              desiredLocations.value = List.from(
                                desiredLocations.value,
                              )..remove(loc);
                            },
                          ),
                        ActionChip(
                          label: const Text('追加'),
                          avatar: const Icon(Icons.add, size: 16),
                          onPressed: () async {
                            final text = await _showAddDialog(context);
                            if (text != null && text.isNotEmpty) {
                              desiredLocations.value = List.from(
                                desiredLocations.value,
                              )..add(text);
                            }
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            // ----- 固定質問への回答 -----
            if (value.fixedQuestion.isNotEmpty)
              Card(
                elevation: 2,
                margin: const EdgeInsets.only(bottom: 16),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'アンケート',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const SizedBox(height: 12),
                      for (final q in value.fixedQuestion)
                        Padding(
                          padding: const EdgeInsets.only(bottom: 12),
                          child: _buildTextForm(
                            controller: answerControllers[q]!,
                            label: q,
                          ),
                        ),
                    ],
                  ),
                ),
              ),

            // ----- カスタム質問 -----
            Card(
              elevation: 2,
              margin: const EdgeInsets.only(bottom: 24),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'カスタム質問',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 12),
                    _buildTextForm(
                      controller: customQuestionController,
                      label: '質問',
                    ),
                    const SizedBox(height: 8),
                    _buildTextForm(
                      controller: customAnswerController,
                      label: '回答',
                    ),
                    const SizedBox(height: 8),
                    Align(
                      alignment: Alignment.centerRight,
                      child: ElevatedButton.icon(
                        onPressed: addCustomQA,
                        icon: const Icon(Icons.add),
                        label: const Text('追加'),
                      ),
                    ),
                    const SizedBox(height: 8),
                    for (final qa in customQuestions.value)
                      ListTile(
                        title: Text(qa.question),
                        subtitle: Text(qa.answer),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () => customQuestions.value = List.from(
                            customQuestions.value,
                          )..remove(qa),
                        ),
                      ),
                  ],
                ),
              ),
            ),

            // ----- 送信ボタン -----
            ElevatedButton.icon(
              onPressed: () {
                if (formKey.currentState?.validate() != true) return;
                if (desiredDates.value.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('日時を少なくとも1つ選択してください')),
                  );
                  return;
                }
                submit();
              },
              icon: const Icon(Icons.how_to_vote),
              label: const Text('投票する'),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // --- ヘルパーWidget / メソッド ---
  Widget _buildTextForm({
    required TextEditingController controller,
    required String label,
    TextInputType? keyboardType,
    String? Function(String?)? validator,
    int maxLines = 1,
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

  Future<String?> _showAddDialog(BuildContext context) async {
    final controller = TextEditingController();
    return showDialog<String>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('場所を追加'),
        content: TextField(
          controller: controller,
          decoration: const InputDecoration(hintText: '例: 新宿'),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('キャンセル'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, controller.text),
            child: const Text('追加'),
          ),
        ],
      ),
    );
  }
}
