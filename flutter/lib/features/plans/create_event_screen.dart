import 'package:cheers_planner/core/app/snackbar_repo.dart';
import 'package:cheers_planner/core/firebase/auth_exception.dart';
import 'package:cheers_planner/core/firebase/auth_repo.dart';
import 'package:cheers_planner/core/router/root.dart';
import 'package:cheers_planner/core/map/candidate_area.dart';
import 'package:cheers_planner/core/map/map_hooks.dart';
import 'package:cheers_planner/core/map/map_repo.dart';
import 'package:cheers_planner/features/plans/event_entry.dart';
import 'package:cheers_planner/features/plans/event_entry_repo.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
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
    final candidateAreas = useCandidateAreas();
    final allergiesEtc = useTextEditingController();
    final mapRepo = ref.watch(mapRepoProvider);

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
                candidateAreas: candidateAreas.areas,
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
                onPressed: () async {
                  final startDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2100),
                  );
                  if (startDate == null) return;
                  final startTime = await showTimePicker(
                    context: context,
                    initialTime: TimeOfDay.now(),
                  );
                  if (startTime == null) return;
                  final endDate = await showDatePicker(
                    context: context,
                    initialDate: startDate,
                    firstDate: startDate,
                    lastDate: DateTime(2100),
                  );
                  if (endDate == null) return;
                  final endTime = await showTimePicker(
                    context: context,
                    initialTime: TimeOfDay.fromDateTime(
                      DateTime.now().add(const Duration(hours: 1)),
                    ),
                  );
                  if (endTime == null) return;
                  final start = DateTime(
                    startDate.year,
                    startDate.month,
                    startDate.day,
                    startTime.hour,
                    startTime.minute,
                  );
                  final end = DateTime(
                    endDate.year,
                    endDate.month,
                    endDate.day,
                    endTime.hour,
                    endTime.minute,
                  );
                  if (!end.isBefore(start)) {
                    candidateDateTimes.value = [
                      ...candidateDateTimes.value,
                      (start, end),
                    ];
                  } else {
                    ref.read(snackBarRepoProvider).show('終了日時は開始日時より後にしてください');
                  }
                },
                child: const Text('Add Candidate Date Times'),
              ),
              SizedBox(
                height: 200,
                child: GoogleMap(
                  initialCameraPosition: const CameraPosition(
                    target: LatLng(35.681236, 139.767125),
                    zoom: 10,
                  ),
                  markers: {
                    for (var i = 0; i < candidateAreas.areas.length; i++)
                      Marker(
                        markerId: MarkerId('$i'),
                        position: candidateAreas.areas[i].latLng,
                      ),
                  },
                  circles: {
                    for (var i = 0; i < candidateAreas.areas.length; i++)
                      Circle(
                        circleId: CircleId('$i'),
                        center: candidateAreas.areas[i].latLng,
                        radius: candidateAreas.areas[i].radius,
                        strokeWidth: 1,
                        fillColor: Colors.blue.withOpacity(0.2),
                      ),
                  },
                  onTap: (pos) async {
                    var radius = 500.0;
                    final result = await showDialog<double>(
                      context: context,
                      builder: (context) {
                        var temp = radius;
                        return AlertDialog(
                          title: const Text('半径を選択'),
                          content: StatefulBuilder(
                            builder: (context, setState) {
                              return Slider(
                                value: temp,
                                min: 100,
                                max: 5000,
                                divisions: 49,
                                label: '${temp.round()}m',
                                onChanged: (v) => setState(() => temp = v),
                              );
                            },
                          ),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: const Text('キャンセル'),
                            ),
                            TextButton(
                              onPressed: () => Navigator.pop(context, temp),
                              child: const Text('追加'),
                            ),
                          ],
                        );
                      },
                    );
                    if (result != null) {
                      radius = result;
                      candidateAreas.add(pos, radius);
                    }
                  },
                  onMapCreated: (controller) {
                    // API key may be required for web. Use mapRepo.apiKey as needed.
                  },
                ),
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
                  itemCount: candidateAreas.areas.length,
                  itemBuilder: (context, index) {
                    final area = candidateAreas.areas[index];
                    return ListTile(
                      title: Text(
                        '(${area.latitude.toStringAsFixed(4)}, ${area.longitude.toStringAsFixed(4)}) - ${area.radius.round()}m',
                      ),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () => candidateAreas.removeAt(index),
                      ),
                    );
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
