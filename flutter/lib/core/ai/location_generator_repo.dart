import 'dart:convert';

import 'package:cheers_planner/core/firebase/firebase_ai_repo.dart';
import 'package:cheers_planner/core/models/event.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'location_generator_repo.g.dart';

@riverpod
LocationGeneratorRepo locationGeneratorRepo(Ref ref) {
  final geminiRepo = ref.watch(geminiModelRepoProvider);
  return LocationGeneratorRepo(geminiRepo);
}

class LocationGeneratorRepo {
  LocationGeneratorRepo(this._geminiRepo);

  final GeminiModelRepo _geminiRepo;

  /// 参加者情報をもとにLLMで場所候補を生成する
  Future<List<Map<String, dynamic>>> generateLocationCandidates({
    required List<String> desiredLocations,
    required List<String> participantPositions,
    required int budgetUpperLimit,
    required String purpose,
    required List<String> specialConsiderations,
  }) async {
    final prompt = _buildLocationCandidatePrompt(
      desiredLocations: desiredLocations,
      participantPositions: participantPositions,
      budgetUpperLimit: budgetUpperLimit,
      purpose: purpose,
      specialConsiderations: specialConsiderations,
    );

    try {
      final response = await _geminiRepo.generateResponse(prompt);
      if (response == null) {
        throw LocationGeneratorException('Geminiからの応答がnullでした');
      }

      // JSONレスポンスをパース
      final candidates = _parseLocationCandidatesResponse(response);
      return candidates;
    } catch (e) {
      throw LocationGeneratorException('場所候補生成に失敗しました: $e');
    }
  }

  /// EventとParticipantsからLocationCandidateRequestを生成する便利メソッド
  Future<List<Map<String, dynamic>>> generateFromEventData({
    required Event event,
    required List<Participant> participants,
  }) async {
    // 参加者の希望場所を集約
    final desiredLocations = participants
        .expand((p) => p.desiredLocations)
        .toSet()
        .toList();

    // 参加者の役職・学年を集約
    final participantPositions = participants
        .map((p) => p.positionOrGrade)
        .toSet()
        .toList();

    // アレルギー等の特別考慮事項を集約
    final specialConsiderations = participants
        .map((p) => p.allergiesEtc)
        .where((allergy) => allergy.isNotEmpty && allergy != 'なし')
        .toSet()
        .toList();

    return generateLocationCandidates(
      desiredLocations: desiredLocations,
      participantPositions: participantPositions,
      budgetUpperLimit: event.budgetUpperLimit,
      purpose: event.purpose,
      specialConsiderations: specialConsiderations,
    );
  }

  /// 場所候補生成用のプロンプトを構築
  String _buildLocationCandidatePrompt({
    required List<String> desiredLocations,
    required List<String> participantPositions,
    required int budgetUpperLimit,
    required String purpose,
    required List<String> specialConsiderations,
  }) {
    return '''
以下の参加者情報をもとに、飲み会開催に最適な 3つの場所候補 を提案してください。

**参加者情報:**
- 希望場所: ${desiredLocations.join(', ')}
- 参加者構成: ${participantPositions.join(', ')}
- 予算範囲: $budgetUpperLimit円/人
- 目的: $purpose
- 特別な考慮事項: ${specialConsiderations.isEmpty ? 'なし' : specialConsiderations.join(', ')}

**選定基準:**
- 交通アクセスの良さ（複数路線利用可能）
- 参加者の年齢層・立場に適した雰囲気
- 予算に見合った店舗密度
- エリアの治安・安全性

JSON配列で以下の形式で返してください（他の説明は不要です）：
```json
[
  {
    "name": "エリア名",
    "center": {"lat": 緯度, "lng": 経度},
    "radius": 検索半径(m),
    "reason": "選定理由",
    "suitableFor": "適している参加者層"
  }
]
```
''';
  }

  /// Geminiからの応答をMap形式のリストにパース
  List<Map<String, dynamic>> _parseLocationCandidatesResponse(String response) {
    try {
      // JSONブロックを抽出（マークダウンの場合があるため）
      final jsonMatch = RegExp(
        r'```json\s*(\[.*?\])\s*```',
        dotAll: true,
      ).firstMatch(response);

      String jsonString;
      if (jsonMatch != null) {
        jsonString = jsonMatch.group(1)!;
      } else {
        // JSONブロックがない場合、配列の部分を直接抽出
        final arrayMatch = RegExp(r'\[.*\]', dotAll: true).firstMatch(response);
        if (arrayMatch != null) {
          jsonString = arrayMatch.group(0)!;
        } else {
          throw LocationGeneratorException('JSON形式の応答が見つかりません: $response');
        }
      }

      final decoded = json.decode(jsonString);
      if (decoded is! List) {
        throw LocationGeneratorException('応答がJSON配列ではありません: $decoded');
      }
      final jsonList = decoded;

      return jsonList.map((json) {
        try {
          return json as Map<String, dynamic>;
        } catch (e) {
          throw LocationGeneratorException(
            'LocationCandidateのパースに失敗: $json, エラー: $e',
          );
        }
      }).toList();
    } catch (e) {
      throw LocationGeneratorException(
        'JSON応答のパースに失敗しました: $e\n応答内容: $response',
      );
    }
  }
}

/// 場所候補生成時の例外
class LocationGeneratorException implements Exception {
  LocationGeneratorException(this.message);
  final String message;

  @override
  String toString() => 'LocationGeneratorException: $message';
}
