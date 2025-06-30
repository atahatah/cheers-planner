import 'package:cheers_planner/features/create/event_entry.dart';
import 'package:cheers_planner/features/create/event_entry_repo.dart';
import 'package:cheers_planner/features/vote/participant.dart';
import 'package:cheers_planner/features/vote/participant_repo.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final Provider<TestDataRepo> testDataRepoProvider = Provider(TestDataRepo.new);

class TestDataRepo {
  TestDataRepo(this._ref);
  final Ref _ref;

  Future<void> createWelcomePartyData(String organizerId) async {
    final eventRepo = _ref.read(eventEntriesRepoProvider);

    // 新人歓迎会のイベントを作成
    final eventEntry = EventEntry(
      purpose: '2024年度新人歓迎会🌸',
      candidateDateTimes: [
        CandidateDateTime(
          start: DateTime(2024, 4, 12, 19), // 4月第2金曜日 19:00
        ),
        CandidateDateTime(
          start: DateTime(2024, 4, 19, 19), // 4月第3金曜日 19:00
        ),
        CandidateDateTime(
          start: DateTime(2024, 4, 26, 19), // 4月第4金曜日 19:00
        ),
      ],
      allergiesEtc: '・食物アレルギーがある方は投票時にコメントをお願いします\n・会費は4000円程度を予定しています',
      organizerId: [organizerId],
      budgetUpperLimit: 5000, // 予算上限5000円
      minutes: 120, // 2時間
      fixedQuestion: ['所属部署を教えてください', '好きな食べ物を教えてください', '趣味や特技を教えてください'],
      participantId: [], // 初期値は空
    );

    final eventId = await eventRepo.add(eventEntry);
    final participantRepo = _ref.read(participantRepoProvider(eventId));
    final eventEntryRepo = _ref.read(eventEntryRepoProvider(eventId));

    // 参加者データを作成
    final participants = [
      // 新入社員（5名）
      _createParticipant(
        eventId: eventId,
        userId: 'test_user1',
        name: '山田太郎',
        phoneNumber: '090-1234-5678',
        positionOrGrade: '新入社員',
        department: '開発部',
        favoriteFood: 'ラーメン',
        hobby: 'ギター演奏',
        availableDates: [DateTime(2024, 4, 12, 19), DateTime(2024, 4, 19, 19)],
        desiredLocations: ['渋谷', '新宿'],
        comment: '楽しみにしています！',
      ),
      _createParticipant(
        eventId: eventId,
        userId: 'test_user2',
        name: '佐藤美咲',
        phoneNumber: '090-2345-6789',
        positionOrGrade: '新入社員',
        department: '営業部',
        favoriteFood: 'お寿司',
        hobby: 'カラオケ',
        availableDates: [DateTime(2024, 4, 19, 19), DateTime(2024, 4, 26, 19)],
        desiredLocations: ['新宿', '池袋'],
        comment: '皆さんと仲良くなれることを楽しみにしています！',
      ),
      _createParticipant(
        eventId: eventId,
        userId: 'test_user3',
        name: '田中健一',
        phoneNumber: '090-3456-7890',
        positionOrGrade: '新入社員',
        department: '人事部',
        favoriteFood: 'ハンバーグ',
        hobby: 'バスケットボール',
        availableDates: [DateTime(2024, 4, 12, 19), DateTime(2024, 4, 26, 19)],
        desiredLocations: ['渋谷', '新宿'],
        comment: '一緒に働けることを嬉しく思います。',
      ),
      _createParticipant(
        eventId: eventId,
        userId: 'test_user4',
        name: '中村優子',
        phoneNumber: '090-4567-8901',
        positionOrGrade: '新入社員',
        department: '経理部',
        favoriteFood: 'パスタ',
        hobby: 'ヨガ',
        availableDates: [DateTime(2024, 4, 19, 19)],
        desiredLocations: ['新宿'],
        comment: 'よろしくお願いいたします。',
      ),
      _createParticipant(
        eventId: eventId,
        userId: 'test_user5',
        name: '小林翔太',
        phoneNumber: '090-5678-9012',
        positionOrGrade: '新入社員',
        department: '開発部',
        favoriteFood: 'カレー',
        hobby: 'プログラミング',
        availableDates: [DateTime(2024, 4, 12, 19), DateTime(2024, 4, 19, 19)],
        desiredLocations: ['渋谷', '新宿'],
        comment: '技術の話で盛り上がれたら嬉しいです！',
      ),

      // 若手社員（4名）
      _createParticipant(
        eventId: eventId,
        userId: 'test_user6',
        name: '高橋直人',
        phoneNumber: '090-6789-0123',
        positionOrGrade: '入社2年目',
        department: '開発部',
        favoriteFood: '焼肉',
        hobby: 'サッカー',
        availableDates: [DateTime(2024, 4, 12, 19), DateTime(2024, 4, 26, 19)],
        desiredLocations: ['渋谷', '新宿'],
        comment: '去年の新入社員です。一緒に頑張りましょう！',
      ),
      _createParticipant(
        eventId: eventId,
        userId: 'test_user7',
        name: '渡辺明日香',
        phoneNumber: '090-7890-1234',
        positionOrGrade: '入社3年目',
        department: '営業部',
        favoriteFood: '天ぷら',
        hobby: 'テニス',
        availableDates: [DateTime(2024, 4, 19, 19), DateTime(2024, 4, 26, 19)],
        desiredLocations: ['新宿', '池袋'],
        comment: '営業のコツをお伝えできればと思います。',
      ),
      _createParticipant(
        eventId: eventId,
        userId: 'test_user8',
        name: '木村拓也',
        phoneNumber: '090-8901-2345',
        positionOrGrade: '入社2年目',
        department: '人事部',
        favoriteFood: '餃子',
        hobby: '読書',
        availableDates: [DateTime(2024, 4, 12, 19), DateTime(2024, 4, 19, 19)],
        desiredLocations: ['新宿'],
        comment: '人事部の雰囲気をお伝えできればと思います。',
      ),
      _createParticipant(
        eventId: eventId,
        userId: 'test_user9',
        name: '松本さくら',
        phoneNumber: '090-9012-3456',
        positionOrGrade: '入社3年目',
        department: '開発部',
        favoriteFood: 'ピザ',
        hobby: 'ダンス',
        availableDates: [DateTime(2024, 4, 19, 19), DateTime(2024, 4, 26, 19)],
        desiredLocations: ['渋谷', '新宿'],
        comment: '開発部の先輩として、いろいろサポートさせていただきます！',
      ),

      // 中堅社員（3名）
      _createParticipant(
        eventId: eventId,
        userId: 'test_user10',
        name: '井上雄太',
        phoneNumber: '090-0123-4567',
        positionOrGrade: '主任',
        department: '開発部',
        favoriteFood: '寿司',
        hobby: 'ゴルフ',
        availableDates: [DateTime(2024, 4, 12, 19), DateTime(2024, 4, 19, 19)],
        desiredLocations: ['新宿', '池袋'],
        comment: '開発部の主任です。技術的な相談はお任せください。',
      ),
      _createParticipant(
        eventId: eventId,
        userId: 'test_user11',
        name: '斎藤美穂',
        phoneNumber: '090-1234-5678',
        positionOrGrade: '主任',
        department: '営業部',
        favoriteFood: '焼き鳥',
        hobby: 'ワイン',
        availableDates: [DateTime(2024, 4, 19, 19), DateTime(2024, 4, 26, 19)],
        desiredLocations: ['渋谷', '新宿'],
        comment: '営業部での心構えなどをお話しできればと思います。',
      ),
      _createParticipant(
        eventId: eventId,
        userId: 'test_user12',
        name: '山本健二',
        phoneNumber: '090-2345-6789',
        positionOrGrade: '係長',
        department: '経理部',
        favoriteFood: 'うなぎ',
        hobby: '将棋',
        availableDates: [DateTime(2024, 4, 12, 19), DateTime(2024, 4, 26, 19)],
        desiredLocations: ['新宿'],
        comment: '経理部の雰囲気や仕事内容について、気軽に質問してください。',
      ),

      // 管理職（3名）
      _createParticipant(
        eventId: eventId,
        userId: 'test_user13',
        name: '佐々木誠',
        phoneNumber: '090-3456-7890',
        positionOrGrade: '開発部長',
        department: '開発部',
        favoriteFood: 'すき焼き',
        hobby: 'テニス',
        availableDates: [
          DateTime(2024, 4, 12, 19),
          DateTime(2024, 4, 19, 19),
          DateTime(2024, 4, 26, 19),
        ],
        desiredLocations: ['渋谷', '新宿', '池袋'],
        comment: '開発部長です。新しい仲間を歓迎します！',
      ),
      _createParticipant(
        eventId: eventId,
        userId: 'test_user14',
        name: '中島裕子',
        phoneNumber: '090-4567-8901',
        positionOrGrade: '人事部長',
        department: '人事部',
        favoriteFood: '天ぷら',
        hobby: 'ガーデニング',
        availableDates: [DateTime(2024, 4, 19, 19), DateTime(2024, 4, 26, 19)],
        desiredLocations: ['新宿'],
        comment: '人事部長です。皆さんの成長をサポートしていきたいと思います。',
      ),
      _createParticipant(
        eventId: eventId,
        userId: 'test_user15',
        name: '藤田雅彦',
        phoneNumber: '090-5678-9012',
        positionOrGrade: '営業部長',
        department: '営業部',
        favoriteFood: 'ステーキ',
        hobby: 'ゴルフ',
        availableDates: [DateTime(2024, 4, 12, 19), DateTime(2024, 4, 26, 19)],
        desiredLocations: ['新宿', '池袋'],
        comment: '営業部長です。新入社員の皆さんと交流できることを楽しみにしています。',
      ),
    ];

    // 参加者データを保存
    for (final participant in participants) {
      final userId = participant.id!;
      await participantRepo.set(userId, participant);
      await eventEntryRepo.addParticipant(eventId, userId);
    }
  }

  EventParticipant _createParticipant({
    required String eventId,
    required String userId,
    required String name,
    required String phoneNumber,
    required String positionOrGrade,
    required String department,
    required String favoriteFood,
    required String hobby,
    required List<DateTime> availableDates,
    required List<String> desiredLocations,
    required String comment,
  }) {
    return EventParticipant(
      id: userId,
      eventId: eventId,
      name: name,
      phoneNumber: phoneNumber,
      positionOrGrade: positionOrGrade,
      desiredBudget: 5000,
      desiredDates: availableDates,
      desiredLocations: desiredLocations,
      customQuestions: [],
      fixedQuestionAnswers: [
        QuestionAnswer(question: '所属部署を教えてください', answer: department),
        QuestionAnswer(question: '好きな食べ物を教えてください', answer: favoriteFood),
        QuestionAnswer(question: '趣味や特技を教えてください', answer: hobby),
      ],
      allergiesEtc: comment,
    );
  }
}
