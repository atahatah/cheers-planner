import 'package:cheers_planner/core/app/snackbar_repo.dart';
import 'package:cheers_planner/core/firebase/auth_repo.dart';
import 'package:cheers_planner/core/router/root.dart';
import 'package:cheers_planner/features/vote/participant.dart';
import 'package:cheers_planner/features/vote/participant_repo.dart';
import 'package:cheers_planner/features/create/event_entry_repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class VoteConfirmScreen extends HookConsumerWidget {
  const VoteConfirmScreen({
    super.key,
    required this.eventId,
    required this.participant,
  });
  final String eventId;
  final EventParticipant participant;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loading = useState(false);

    Future<void> submit() async {
      try {
        loading.value = true;
        final uid = ref.read(requireUserProvider).uid;
        await ref.read(participantRepoProvider(eventId)).set(uid, participant);
        await ref
            .read(eventEntryRepoProvider(eventId))
            .addParticipant(eventId, uid);
        ref.read(snackBarRepoProvider).show('投票が完了しました！');
        const VotedListRoute().go(context);
      } finally {
        loading.value = false;
      }
    }

    return Scaffold(
      appBar: AppBar(title: const Text('内容確認')),
      body: Stack(
        alignment: Alignment.center,
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('名前: ${participant.name}'),
                Text('電話番号: ${participant.phoneNumber}'),
                if (participant.positionOrGrade != null)
                  Text('学年/役職: ${participant.positionOrGrade}'),
                Text('希望予算: ${participant.desiredBudget}'),
                const SizedBox(height: 8),
                const Text('希望日時'),
                for (final d in participant.desiredDates)
                  Text(d.toLocal().toString()),
                const SizedBox(height: 8),
                const Text('希望場所'),
                for (final l in participant.desiredLocations) Text(l),
                const SizedBox(height: 8),
                const Text('質問への回答'),
                for (final qa in participant.fixedQuestionAnswers)
                  Text('${qa.question}: ${qa.answer}'),
                const SizedBox(height: 8),
                const Text('追加質問'),
                for (final qa in participant.customQuestions)
                  Text('${qa.question}: ${qa.answer}'),
                const SizedBox(height: 8),
                Text('アレルギー等: ${participant.allergiesEtc}'),
                const SizedBox(height: 24),
                ElevatedButton(onPressed: submit, child: const Text('送信')),
              ],
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
}
