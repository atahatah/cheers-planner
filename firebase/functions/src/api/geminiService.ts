import {
  GoogleGenerativeAI,
  HarmBlockThreshold,
  HarmCategory,
} from "@google/generative-ai";
import * as logger from "firebase-functions/logger";
import { Event, LocationCandidate, Participant } from "../types/common";
import { AIProcessingError, ErrorCodes } from "../utils/errorHandler";

// --- Gemini APIの共通設定 ---

const MODEL_NAME = "gemini-1.5-flash";
let genAI: GoogleGenerativeAI | undefined;

/**
 * 環境変数からAPIキーを取得します。
 * @return {string} APIキー。
 */
function getApiKey(): string {
  const apiKey = process.env.GEMINI_API_KEY;
  if (!apiKey) {
    throw new Error("GEMINI_API_KEY is not configured in .env");
  }
  return apiKey;
}

/**
 * Gemini AIクライアントをシングルトンとして取得します。
 * @return {GoogleGenerativeAI} Gemini AIクライアントインスタンス。
 */
function getGenAIClient(): GoogleGenerativeAI {
  if (!genAI) {
    genAI = new GoogleGenerativeAI(getApiKey());
  }
  return genAI;
}

const generationConfig = {
  temperature: 0.2,
  topK: 1,
  topP: 1,
  maxOutputTokens: 2048,
};

const safetySettings = [
  {
    category: HarmCategory.HARM_CATEGORY_HARASSMENT,
    threshold: HarmBlockThreshold.BLOCK_MEDIUM_AND_ABOVE,
  },
  {
    category: HarmCategory.HARM_CATEGORY_HATE_SPEECH,
    threshold: HarmBlockThreshold.BLOCK_MEDIUM_AND_ABOVE,
  },
  {
    category: HarmCategory.HARM_CATEGORY_SEXUALLY_EXPLICIT,
    threshold: HarmBlockThreshold.BLOCK_MEDIUM_AND_ABOVE,
  },
  {
    category: HarmCategory.HARM_CATEGORY_DANGEROUS_CONTENT,
    threshold: HarmBlockThreshold.BLOCK_MEDIUM_AND_ABOVE,
  },
];

/**
 * 参加者情報から場所候補を生成
 * @param {Event} eventData イベントデータ
 * @param {Participant[]} participants 参加者データ
 * @return {Promise<LocationCandidate[]>} 場所候補リスト
 */
export async function generateLocationCandidates(
  eventData: Event,
  participants: Participant[]
): Promise<LocationCandidate[]> {
  try {
    const client = getGenAIClient();
    logger.info("Generating location candidates with Gemini AI");

    // プロンプト生成
    const prompt = createLocationPrompt(eventData, participants);
    logger.debug("Generated prompt:", {prompt});

    // Gemini API呼び出し
    const model = client.getGenerativeModel({model: MODEL_NAME});
    const result = await model.generateContent(prompt);
    const response = await result.response;
    const text = response.text();

    logger.debug("Gemini response:", {text});

    // JSON解析
    const locationCandidates = parseLocationResponse(text);
    logger.info(`Generated ${locationCandidates.length} location candidates`);

    return locationCandidates;
  } catch (error) {
    logger.error("Failed to generate location candidates:", error);
    throw new AIProcessingError(
      "Failed to generate location candidates",
      ErrorCodes.GEMINI_API_ERROR,
      error
    );
  }
}

/**
 * 場所候補生成用のプロンプトを作成
 * @param {Event} eventData イベントデータ
 * @param {Participant[]} participants 参加者データ
 * @return {string} プロンプト文字列
 */
function createLocationPrompt(
  eventData: Event,
  participants: Participant[]
): string {
  // 参加者の希望場所を集約
  const desiredLocations = participants
    .flatMap((p) => p.desiredLocations || [])
    .filter((loc) => loc && typeof loc === "string");

  // 参加者の役職・学年を集約
  const participantPositions = participants
    .map((p) => p.positionOrGrade)
    .filter((pos) => pos && typeof pos === "string");

  // 特別な考慮事項を集約
  const specialConsiderations = participants
    .map((p) => p.allergiesEtc)
    .filter((allergy) => allergy && typeof allergy === "string");

  const prompt = `
以下の参加者情報をもとに、飲み会開催に最適な 3つの場所候補 を提案してください。

**参加者情報:**
- 希望場所: ${JSON.stringify(desiredLocations)}
- 参加者構成: ${JSON.stringify(participantPositions)}
- 予算範囲: ${eventData.budgetUpperLimit || 5000}円/人
- 目的: ${eventData.purpose || "歓迎会"}
- 特別な考慮事項: ${JSON.stringify(specialConsiderations)}

**選定基準:**
- 交通アクセスの良さ（複数路線利用可能）
- 参加者の年齢層・立場に適した雰囲気
- 予算に見合った店舗密度
- エリアの治安・安全性

JSON配列で以下の形式で返してください：
\`\`\`json
[
  {
    "name": "エリア名",
    "center": {"lat": 緯度, "lng": 経度},
    "radius": 検索半径(m),
    "reason": "選定理由",
    "suitableFor": "適している参加者層"
  }
]
\`\`\`

注意: JSON以外の文字は含めず、配列のみを返してください。
`;

  return prompt.trim();
}

/**
 * Gemini APIレスポンスをパース
 * @param {string} responseText レスポンステキスト
 * @return {LocationCandidate[]} パース済み場所候補
 */
function parseLocationResponse(responseText: string): LocationCandidate[] {
  try {
    // マークダウンのコードブロックを除去
    let cleanedText = responseText.trim();

    // ```json および ``` を除去
    cleanedText = cleanedText.replace(/```json\s*/g, "");
    cleanedText = cleanedText.replace(/```\s*/g, "");

    // プレーンJSONを試行
    const parsed = JSON.parse(cleanedText);

    if (!Array.isArray(parsed)) {
      throw new Error("Response is not an array");
    }

    // 各候補の検証
    return parsed.map((candidate: any, index: number) => {
      if (!candidate.name || typeof candidate.name !== "string") {
        throw new Error(`Invalid name in candidate ${index}`);
      }
      if (!candidate.center ||
          typeof candidate.center.lat !== "number" ||
          typeof candidate.center.lng !== "number") {
        throw new Error(`Invalid center coordinates in candidate ${index}`);
      }
      if (typeof candidate.radius !== "number") {
        throw new Error(`Invalid radius in candidate ${index}`);
      }

      return {
        name: candidate.name,
        center: {
          lat: candidate.center.lat,
          lng: candidate.center.lng,
        },
        radius: candidate.radius,
        reason: candidate.reason || "AI推奨",
        suitableFor: candidate.suitableFor || "全参加者",
      };
    });
  } catch (error) {
    logger.error("Failed to parse location response:", {
      error,
      responseText,
    });

    // フォールバック: デフォルト候補を返す
    return getDefaultLocationCandidates();
  }
}

/**
 * デフォルトの場所候補を取得
 * @return {LocationCandidate[]} デフォルト場所候補
 */
function getDefaultLocationCandidates(): LocationCandidate[] {
  return [
    {
      name: "新宿三丁目エリア",
      center: {lat: 35.6938, lng: 139.7034},
      radius: 2000,
      reason: "JR・私鉄・地下鉄が集中し全員がアクセスしやすく、予算帯に応じた店舗が豊富",
      suitableFor: "多世代混在の歓迎会",
    },
    {
      name: "恵比寿駅周辺",
      center: {lat: 35.6467, lng: 139.7101},
      radius: 1500,
      reason: "落ち着いた大人の雰囲気で上司部下の距離感を保ちやすく、品質の高い店舗が多い",
      suitableFor: "年齢層高め・格式重視",
    },
    {
      name: "渋谷センター街周辺",
      center: {lat: 35.6595, lng: 139.7005},
      radius: 1800,
      reason: "若手社員に人気のエリアで活気があり、カジュアルな雰囲気作りに最適",
      suitableFor: "新入社員中心・カジュアル",
    },
  ];
}

/**
 * ユーザーレビューを分析し、良い点と懸念点を抽出します。
 * @param {string[]} reviews - 分析対象のレビューコメントの配列。
 * @return {Promise<{goodPoints: string[], badPoints: string[]}>}
 * 良い点と懸念点のリスト。
 */
export async function analyzeReviewsWithGemini(
  reviews: string[],
): Promise<{ goodPoints: string[]; badPoints: string[] }> {
  if (reviews.length === 0) {
    return { goodPoints: [], badPoints: [] };
  }
  const client = getGenAIClient();
  const model = client.getGenerativeModel({
    model: MODEL_NAME,
    generationConfig,
    safetySettings,
  });

  const prompt = createReviewAnalysisPrompt(reviews);

  try {
    const result = await model.generateContent(prompt);
    const response = result.response;
    const text = response.text();

    const cleanedText = text.replace(/```json/g, "").replace(/```/g, "").trim();
    const parsed = JSON.parse(cleanedText);

    return {
      goodPoints: parsed.goodPoints || [],
      badPoints: parsed.badPoints || [],
    };
  } catch (error) {
    logger.error("Failed to analyze reviews with Gemini:", error);
    return {goodPoints: [], badPoints: []}; // エラー時は空の結果を返す
  }
}

/**
 * レビュー分析用のプロンプトを作成します。
 * @param {string[]} reviews レビューの配列
 * @return {string} 生成されたプロンプト
 */
function createReviewAnalysisPrompt(reviews: string[]): string {
  const promptParts = [
    "以下のレストランに関するユーザーレビューを分析し、",
    "このレストランの「良い点」と「懸念点」をそれぞれ3〜5個の箇条書きで",
    "簡潔にまとめてください。\n\n",
    "レビューが少ない、または内容が偏っている場合でも、",
    "提供された情報から総合的に判断してください。",
    "事実に基づき、客観的な表現を心がけてください。\n\n",
    "レビュー:\n",
    ...reviews.map((r) => `- ${r}`),
    "\n\n出力形式は以下のJSON形式で、日本語で記述してください。\n",
    "{\n",
    "  \"goodPoints\": [\"良い点1\", \"良い点2\", ...],\n",
    "  \"badPoints\": [\"懸念点1\", \"懸念点2\", ...]\n",
    "}",
  ];
  return promptParts.join("");
}

/**
 * ユーザーレビューとレストランのカテゴリ情報から、
 * 人気のあるメニュー項目を抽出します。
 * @param {string[]} reviews - 分析対象のレビューコメントの配列。
 * @param {string[]} types - レストランのカテゴリ（例: "ramen_restaurant"）。
 * @return {Promise<string[]>} 抽出されたメニュー項目のリスト。
 */
export async function extractMenuWithGemini(
  reviews: string[],
  types: string[],
): Promise<string[]> {
  if (reviews.length === 0) {
    return [];
  }
  const client = getGenAIClient();
  const model = client.getGenerativeModel({
    model: MODEL_NAME,
    generationConfig,
    safetySettings,
  });

  const prompt = createMenuExtractionPrompt(reviews, types);

  try {
    const result = await model.generateContent(prompt);
    const response = result.response;
    const text = response.text();

    const cleanedText = text.replace(/```json/g, "").replace(/```/g, "").trim();
    const parsed = JSON.parse(cleanedText);
    return parsed.menuItems || [];
  } catch (error) {
    logger.error("Failed to extract menu with Gemini:", error);
    return []; // エラー時は空の結果を返す
  }
}

/**
 * メニュー抽出用のプロンプトを作成します。
 * @param {string[]} reviews レビューの配列
 * @param {string[]} types レストランカテゴリの配列
 * @return {string} 生成されたプロンプト
 */
function createMenuExtractionPrompt(
  reviews: string[],
  types: string[],
): string {
  const promptParts = [
    "以下のレストランに関するユーザーレビューとカテゴリ情報を分析し、",
    "頻繁に言及されている、または特に評価の高いメニュー項目を",
    "5つまで特定してください。\n\n",
    "単にメニュー名をリストアップするだけでなく、",
    "「〇〇が人気」「〇〇が美味しいと評判」のように、",
    "簡潔で自然な日本語の文章で説明してください。",
    "メニューに関する言及がない場合は、空の配列を返してください。\n\n",
    "# レストランのカテゴリ情報\n",
    `- ${types.join(", ")}\n\n`,
    "# ユーザーレビュー\n",
    ...reviews.map((r) => `- ${r}`),
    "\n\n# 出力\n",
    "以下のJSON形式で、日本語で記述してください。\n",
    "{\n",
    "  \"menuItems\": [\"メニュー1の説明\", \"メニュー2の説明\", ...]\n",
    "}",
  ];
  return promptParts.join("");
}
