import 'package:cheers_planner/core/app/snackbar_repo.dart';
import 'package:cheers_planner/core/firebase/auth_exception.dart';
import 'package:cheers_planner/core/firebase/auth_repo.dart';
import 'package:cheers_planner/core/hooks/google_map_controller_hook.dart';
import 'package:cheers_planner/core/hooks/use_areas_selection.dart';
import 'package:cheers_planner/core/router/root.dart';
import 'package:cheers_planner/features/create/event_entry.dart';
import 'package:cheers_planner/features/create/event_entry_repo.dart';
import 'package:cheers_planner/features/create/geolocator_repo.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class CreateEventScreen extends HookConsumerWidget {
  const CreateEventScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loading = useState(false);
    final eventName = useTextEditingController();
    final deadline = useState<DateTime?>(null);
    final candidateDateTimes = useState<List<DateTime>>([]);
    final allergiesEtc = useTextEditingController();
    final budgetUpperLimit = useTextEditingController();
    final fixedQuestion = useState<List<String>>([]);
    final minutes = useTextEditingController(text: '60');
    final areasController = useAreasSelection();
    final map = useGoogleMapController();

    final getCurrentLocation = useMemoized(getCurrentLatLng);
    final currentPosition = useFuture(getCurrentLocation);

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
                candidateAreas: areasController.areas,
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
              ElevatedButton(
                onPressed: selectDeadline,
                child: Text(
                  deadline.value == null
                      ? '締切を選択'
                      : '締切: ${deadline.value!.toLocal()}',
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
              SizedBox(
                height: 300,
                width: double.infinity,
                child: currentPosition.connectionState == ConnectionState.done
                    ? GoogleMap(
                        initialCameraPosition: CameraPosition(
                          target:
                              currentPosition.data ??
                              const LatLng(35.681236, 139.767125),
                          zoom: 10,
                        ),
                        mapType: MapType.hybrid,
                        onMapCreated: map.onMapCreated,
                        onTap: areasController.add,
                        markers: {
                          for (var i = 0; i < areasController.areas.length; i++)
                            Marker(
                              markerId: MarkerId(i.toString()),
                              position: LatLng(
                                areasController.areas[i].location.latitude,
                                areasController.areas[i].location.longitude,
                              ),
                            ),
                        },
                        circles: {
                          for (var i = 0; i < areasController.areas.length; i++)
                            Circle(
                              circleId: CircleId(i.toString()),
                              center: LatLng(
                                areasController.areas[i].location.latitude,
                                areasController.areas[i].location.longitude,
                              ),
                              radius: areasController.areas[i].radius
                                  .toDouble(),
                              strokeWidth: 2,
                              strokeColor: Colors.blue,
                              fillColor: Colors.blue.withOpacity(0.15),
                            ),
                        },
                      )
                    : const Center(child: CircularProgressIndicator()),
              ),
              // panel for adjusting each selected area
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  for (var i = 0; i < areasController.areas.length; i++)
                    ListTile(
                      title: Text('R = ${areasController.areas[i].radius} m'),
                      subtitle: Slider(
                        min: 100,
                        max: 3000,
                        value: areasController.areas[i].radius.toDouble(),
                        onChanged: (v) => areasController.update(i, v),
                      ),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () => areasController.remove(i),
                      ),
                    ),
                ],
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
