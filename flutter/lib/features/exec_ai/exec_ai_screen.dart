import 'package:cheers_planner/core/ai/location_generator_repo.dart';
import 'package:cheers_planner/core/firebase/firestore_repo.dart';
import 'package:cheers_planner/core/services/restaurant_search_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ExecAiScreen extends HookConsumerWidget {
  const ExecAiScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AI Execution'),
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'AI Execution Screen',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 32),
            const _ExecuteAiButton(),
            const SizedBox(height: 16),
            _DebugFirebaseButton(ref: ref),
            const SizedBox(height: 16),
            _CreateTestDataButton(ref: ref),
          ],
        ),
      ),
    );
  }
}

class _ExecuteAiButton extends HookConsumerWidget {
  const _ExecuteAiButton();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ElevatedButton.icon(
      onPressed: () async {
        await _executeAI(context, ref);
      },
      icon: const Icon(Icons.smart_toy),
      label: const Text('Execute AI'),
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
        textStyle: const TextStyle(fontSize: 18),
      ),
    );
  }

  Future<void> _executeAI(BuildContext context, WidgetRef ref) async {
    try {
      const testEventId = 'test-event-123';
      final firestore = ref.read(firestoreProvider);
      final locationGeneratorRepo = ref.read(locationGeneratorRepoProvider);
      final restaurantSearchService = ref.read(restaurantSearchServiceProvider);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('AI場所候補生成を開始...'),
          duration: Duration(seconds: 2),
        ),
      );

      // イベントデータを取得
      final eventDoc = await firestore
          .collection('events')
          .doc(testEventId)
          .get();
      if (!eventDoc.exists) {
        if (!context.mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('テストデータが見つかりません。Create Test Dataを先に実行してください。'),
            duration: Duration(seconds: 3),
            backgroundColor: Colors.orange,
          ),
        );
        return;
      }

      final eventData = eventDoc.data()!;

      // 参加者データを取得
      final participantsSnapshot = await firestore
          .collection('events')
          .doc(testEventId)
          .collection('participants')
          .get();

      if (participantsSnapshot.docs.isEmpty) {
        if (!context.mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('参加者データが見つかりません。'),
            duration: Duration(seconds: 3),
            backgroundColor: Colors.orange,
          ),
        );
        return;
      }

      print('Event data found: ${eventData['eventName']}'); // Debug用
      print(
        'Participants count: ${participantsSnapshot.docs.length}',
      ); // Debug用

      // データを整理
      final desiredLocations = <String>[];
      final participantPositions = <String>[];
      final specialConsiderations = <String>[];

      for (final doc in participantsSnapshot.docs) {
        final data = doc.data();

        // 希望場所を集約
        if (data['desiredLocations'] is List) {
          desiredLocations.addAll(
            (data['desiredLocations'] as List).cast<String>(),
          );
        }

        // 役職を集約
        if (data['positionOrGrade'] is String) {
          participantPositions.add(data['positionOrGrade'] as String);
        }

        // アレルギー等を集約
        if (data['allergiesEtc'] is String &&
            data['allergiesEtc'] != 'なし' &&
            data['allergiesEtc'] != '') {
          specialConsiderations.add(data['allergiesEtc'] as String);
        }
      }

      // STEP 1: AIで場所候補を生成
      final locationCandidates = await locationGeneratorRepo
          .generateLocationCandidates(
            desiredLocations: desiredLocations.toSet().toList(),
            participantPositions: participantPositions.toSet().toList(),
            budgetUpperLimit: eventData['budgetUpperLimit'] as int,
            purpose: eventData['purpose'] as String,
            specialConsiderations: specialConsiderations.toSet().toList(),
          );

      if (!context.mounted) return;

      print(
        'Generated ${locationCandidates.length} location candidates:',
      ); // Debug用
      for (final candidate in locationCandidates) {
        print('- ${candidate['name']}: ${candidate['reason']}'); // Debug用
      }

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('店舗検索を開始...'),
          duration: Duration(seconds: 2),
        ),
      );

      // STEP 2: 各場所候補で店舗検索
      final restaurantsByLocation = await restaurantSearchService
          .searchAllLocations(
            locationCandidates: locationCandidates,
            eventData: eventData,
          );

      if (!context.mounted) return;

      final totalRestaurants = restaurantsByLocation.values
          .expand((restaurants) => restaurants)
          .length;

      print('Total restaurants found: $totalRestaurants'); // Debug用
      for (final entry in restaurantsByLocation.entries) {
        print('${entry.key}: ${entry.value.length} restaurants'); // Debug用
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'AI処理完了!\n${locationCandidates.length}個の場所候補、$totalRestaurants個の店舗候補を生成しました',
          ),
          duration: const Duration(seconds: 5),
          backgroundColor: Colors.green,
          action: SnackBarAction(
            label: '詳細',
            onPressed: () {
              _showFullResultsDialog(
                context,
                locationCandidates,
                restaurantsByLocation,
              );
            },
          ),
        ),
      );
    } catch (e) {
      print('AI execution error: $e'); // Debug用
      if (!context.mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('AI処理エラー: $e'),
          duration: const Duration(seconds: 5),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  void _showFullResultsDialog(
    BuildContext context,
    List<Map<String, dynamic>> locationCandidates,
    Map<String, List<Map<String, dynamic>>> restaurantsByLocation,
  ) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('AI処理結果'),
        content: SizedBox(
          width: double.maxFinite,
          height: 500,
          child: DefaultTabController(
            length: 2,
            child: Column(
              children: [
                const TabBar(
                  tabs: [
                    Tab(text: '場所候補'),
                    Tab(text: '店舗候補'),
                  ],
                ),
                Expanded(
                  child: TabBarView(
                    children: [
                      _buildLocationCandidatesTab(locationCandidates),
                      _buildRestaurantCandidatesTab(restaurantsByLocation),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('閉じる'),
          ),
        ],
      ),
    );
  }

  Widget _buildLocationCandidatesTab(List<Map<String, dynamic>> candidates) {
    return ListView.builder(
      itemCount: candidates.length,
      itemBuilder: (context, index) {
        final candidate = candidates[index];
        final center = candidate['center'] as Map<String, dynamic>;
        return Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  candidate['name'] as String,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Text('理由: ${candidate['reason']}'),
                Text('適合: ${candidate['suitableFor']}'),
                Text('位置: ${center['lat']}, ${center['lng']}'),
                Text('半径: ${candidate['radius']}m'),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildRestaurantCandidatesTab(
    Map<String, List<Map<String, dynamic>>> restaurantsByLocation,
  ) {
    final entries = restaurantsByLocation.entries.toList();

    return ListView.builder(
      itemCount: entries.length,
      itemBuilder: (context, index) {
        final entry = entries[index];
        final locationName = entry.key;
        final restaurants = entry.value;

        return ExpansionTile(
          title: Text('$locationName (${restaurants.length}件)'),
          children: restaurants.take(5).map((restaurant) {
            final priceLevel = restaurant['priceLevel'] as int? ?? 0;
            final priceLevelStr = priceLevel > 0 ? '¥' * priceLevel : '価格情報なし';

            return ListTile(
              title: Text(restaurant['name'] as String),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '評価: ${restaurant['rating']} (${restaurant['userRatingsTotal']}件)',
                  ),
                  Text('価格帯: $priceLevelStr'),
                  Text(restaurant['formattedAddress'] as String),
                ],
              ),
              dense: true,
            );
          }).toList(),
        );
      },
    );
  }
}

class _DebugFirebaseButton extends StatelessWidget {
  const _DebugFirebaseButton({required this.ref});

  final WidgetRef ref;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: () async {
        await _testFirebaseConnection(context);
      },
      icon: const Icon(Icons.cloud),
      label: const Text('Test Firebase'),
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
        textStyle: const TextStyle(fontSize: 18),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
    );
  }

  Future<void> _testFirebaseConnection(BuildContext context) async {
    try {
      // テスト用のEventID（実際のデータがない場合でもエラーハンドリングで確認可能）
      const testEventId = 'test-event-123';

      final firestore = ref.read(firestoreProvider);

      // Firestore接続テスト
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Firestore接続テスト開始...'),
          duration: Duration(seconds: 1),
        ),
      );

      // Event情報を取得テスト
      final eventDoc = firestore.collection('events').doc(testEventId);
      final eventSnapshot = await eventDoc.get();

      print('=== Firebase Debug Info ==='); // Debug用
      print('Event exists: ${eventSnapshot.exists}'); // Debug用
      if (eventSnapshot.exists) {
        print('Event data: ${eventSnapshot.data()}'); // Debug用
      }

      // Participants情報を取得テスト
      final participantsCollection = firestore
          .collection('events')
          .doc(testEventId)
          .collection('participants');
      final participantsSnapshot = await participantsCollection.get();

      print(
        'Participants count: ${participantsSnapshot.docs.length}',
      ); // Debug用
      for (final doc in participantsSnapshot.docs) {
        print('Participant ${doc.id}: ${doc.data()}'); // Debug用
      }

      // 結果表示
      if (!context.mounted) {
        return;
      }

      final message = eventSnapshot.exists
          ? 'Event発見! 参加者: ${participantsSnapshot.docs.length}人'
          : 'Event未発見 (テストデータなし)';

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Firebase接続成功!\n$message'),
          duration: const Duration(seconds: 3),
          backgroundColor: Colors.green,
        ),
      );
    } on FirebaseException catch (e) {
      print('Firebase connection error: $e'); // Debug用
      if (!context.mounted) {
        return;
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Firebase接続エラー: $e'),
          duration: const Duration(seconds: 3),
          backgroundColor: Colors.red,
        ),
      );
    } catch (e) {
      print('General error: $e'); // Debug用
      if (!context.mounted) {
        return;
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('予期しないエラー: $e'),
          duration: const Duration(seconds: 3),
          backgroundColor: Colors.red,
        ),
      );
    }
  }
}

class _CreateTestDataButton extends StatelessWidget {
  const _CreateTestDataButton({required this.ref});

  final WidgetRef ref;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: () async {
        await _createTestData(context);
      },
      icon: const Icon(Icons.add_circle),
      label: const Text('Create Test Data'),
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
        textStyle: const TextStyle(fontSize: 18),
        backgroundColor: Colors.orange,
        foregroundColor: Colors.white,
      ),
    );
  }

  Future<void> _createTestData(BuildContext context) async {
    try {
      const testEventId = 'test-event-123';
      final firestore = ref.read(firestoreProvider);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('テストデータ作成中...'),
          duration: Duration(seconds: 1),
        ),
      );

      // Event データ作成
      final eventData = {
        'organizerId': ['user123'],
        'eventName': '新歓飲み会',
        'dueDate': Timestamp.now(),
        'minutes': 120,
        'budgetUpperLimit': 5000,
        'purpose': '歓迎会',
        'fixedQuestion': ['アレルギーはありますか？', '飲酒は可能ですか？'],
        'candidateDateTimes': {
          'datetime1': {
            'start': Timestamp.fromDate(
              DateTime.now().add(const Duration(days: 7)),
            ),
            'end': Timestamp.fromDate(
              DateTime.now().add(const Duration(days: 7, hours: 2)),
            ),
          },
          'datetime2': {
            'start': Timestamp.fromDate(
              DateTime.now().add(const Duration(days: 14)),
            ),
            'end': Timestamp.fromDate(
              DateTime.now().add(const Duration(days: 14, hours: 2)),
            ),
          },
        },
        'candidateAreas': {
          'area1': {
            'center': const GeoPoint(35.6595, 139.7005), // 渋谷
            'radius': 1000,
          },
          'area2': {
            'center': const GeoPoint(35.6938, 139.7034), // 新宿
            'radius': 1500,
          },
        },
        'aiRecArea': null, // AI処理後に設定
        'aiRecDate': null, // AI処理後に設定
        'aiRecStore': null, // AI処理後に設定
        'createdAt': FieldValue.serverTimestamp(),
        'updatedAt': FieldValue.serverTimestamp(),
      };

      await firestore.collection('events').doc(testEventId).set(eventData);
      print('Event created: $eventData'); // Debug用

      // Participants データ作成
      final participants = [
        {
          'name': '田中太郎',
          'phoneNumber': '09012345678',
          'positionOrGrade': '新入社員',
          'desiredBudget': 4000,
          'desiredDates': [
            Timestamp.fromDate(DateTime.now().add(const Duration(days: 7))),
            Timestamp.fromDate(DateTime.now().add(const Duration(days: 14))),
          ],
          'desiredLocations': ['渋谷', '新宿'],
          'allergiesEtc': 'エビアレルギー',
          'submittedAt': Timestamp.now(),
          'fixedQuestionAnswers': {
            'question-1': {'question': 'アレルギーはありますか？', 'answer': 'エビアレルギーあり'},
            'question-2': {'question': '飲酒は可能ですか？', 'answer': 'はい、可能です'},
          },
          'customQuestionAnswers': {
            'custom-1': {'question': '好きな料理ジャンルは？', 'answer': '和食が好きです'},
          },
          'createdAt': FieldValue.serverTimestamp(),
          'updatedAt': FieldValue.serverTimestamp(),
        },
        {
          'name': '佐藤花子',
          'phoneNumber': '09087654321',
          'positionOrGrade': '先輩社員',
          'desiredBudget': 5000,
          'desiredDates': [
            Timestamp.fromDate(DateTime.now().add(const Duration(days: 7))),
            Timestamp.fromDate(DateTime.now().add(const Duration(days: 10))),
          ],
          'desiredLocations': ['恵比寿', '代官山'],
          'allergiesEtc': 'なし',
          'submittedAt': Timestamp.now(),
          'fixedQuestionAnswers': {
            'question-1': {'question': 'アレルギーはありますか？', 'answer': '特になし'},
            'question-2': {'question': '飲酒は可能ですか？', 'answer': 'はい、大丈夫です'},
          },
          'customQuestionAnswers': {
            'custom-1': {'question': '好きな料理ジャンルは？', 'answer': 'イタリアンが好きです'},
          },
          'createdAt': FieldValue.serverTimestamp(),
          'updatedAt': FieldValue.serverTimestamp(),
        },
      ];

      final participantsCollection = firestore
          .collection('events')
          .doc(testEventId)
          .collection('participants');

      for (var i = 0; i < participants.length; i++) {
        await participantsCollection.doc('participant-$i').set(participants[i]);
        print('Participant created: ${participants[i]}'); // Debug用
      }

      if (!context.mounted) {
        return;
      }

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('テストデータ作成完了!\nEventと2人の参加者を作成しました'),
          duration: Duration(seconds: 3),
          backgroundColor: Colors.green,
        ),
      );
    } on FirebaseException catch (e) {
      print('Firebase error creating test data: $e'); // Debug用
      if (!context.mounted) {
        return;
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Firebaseエラー: $e'),
          duration: const Duration(seconds: 3),
          backgroundColor: Colors.red,
        ),
      );
    } catch (e) {
      print('General error creating test data: $e'); // Debug用
      if (!context.mounted) {
        return;
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('予期しないエラー: $e'),
          duration: const Duration(seconds: 3),
          backgroundColor: Colors.red,
        ),
      );
    }
  }
}
