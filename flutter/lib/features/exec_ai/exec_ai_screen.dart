import 'package:cheers_planner/core/firebase/firestore_repo.dart';
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

class _ExecuteAiButton extends StatelessWidget {
  const _ExecuteAiButton();

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: () {
        // TODO(feature): AI実行処理を実装
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('AI実行処理を実装予定'),
            duration: Duration(seconds: 2),
          ),
        );
      },
      icon: const Icon(Icons.smart_toy),
      label: const Text('Execute AI'),
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
        textStyle: const TextStyle(fontSize: 18),
      ),
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
