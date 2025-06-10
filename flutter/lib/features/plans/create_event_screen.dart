import 'package:cheers_planner/core/app/snackbar_repo.dart';
import 'package:cheers_planner/core/firebase/auth_exception.dart';
import 'package:cheers_planner/core/firebase/auth_repo.dart';
import 'package:cheers_planner/core/router/root.dart';
import 'package:cheers_planner/features/plans/event_entry.dart';
import 'package:cheers_planner/features/plans/event_entry_repo.dart';
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
    final candidateDateTimes = useState<List<(DateTime start, DateTime end)>>(
      [],
    );
    final candidateAreas = useState<List<String>>([]);
    final allergiesEtc = useTextEditingController();

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

    Future<void> submit() async {
      try {
        loading.value = true;
        final uid = ref.read(requireUserProvider).uid;
        await ref
            .read(eventEntryRepoProvider)
            .add(
              EventEntry(
                eventName: eventName.text,
                dueDate: deadline.value ?? DateTime.now(),
                candidateDateTimes: candidateDateTimes.value,
                candidateAreas: candidateAreas.value,
                allergiesEtc: allergiesEtc.text,
                organizerId: [uid],
                participantId: [uid],
              ),
            );
        const EventListRoute().go(context);
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
              ElevatedButton(
                onPressed: () {
                  // Logic to add candidate date times
                  // For example, you can show a dialog to select start and end times
                  // and then add them to candidateDateTimes.value
                },
                child: const Text('Add Candidate Date Times'),
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
                  itemCount: candidateDateTimes.value.length,
                  itemBuilder: (context, index) {
                    final (start, end) = candidateDateTimes.value[index];
                    return ListTile(
                      title: Text(
                        'From ${start.toLocal()} to ${end.toLocal()}',
                      ),
                    );
                  },
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: candidateAreas.value.length,
                  itemBuilder: (context, index) {
                    return ListTile(title: Text(candidateAreas.value[index]));
                  },
                ),
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
