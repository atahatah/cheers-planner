import { GoogleGenerativeAI } from "@google/generative-ai";
import { Timestamp } from "firebase-admin/firestore";
import * as logger from "firebase-functions/logger";
import {
  AnalysisCriteria,
  OptimizationInput,
  OptimizedRestaurantResults,
  ParticipantProfile,
  Restaurant,
  RestaurantEvaluation,
} from "../types/common";
import { AIProcessingError, ErrorCodes } from "../utils/errorHandler";

let genAI: GoogleGenerativeAI | undefined;

/**
 * 環境変数からGemini APIキーを取得
 * @return {string} Gemini APIキー
 */
function getGeminiApiKey(): string {
  const key = process.env.GEMINI_API_KEY;
  if (!key) {
    throw new Error(
      "GEMINI_API_KEY is not configured. Please set it in .env file."
    );
  }
  return key;
}

/**
 * Gemini AIクライアントをシングルトンとして取得します。
 * @return {GoogleGenerativeAI} Gemini AIクライアントインスタンス。
 */
function getGenAIClient(): GoogleGenerativeAI {
  if (!genAI) {
    genAI = new GoogleGenerativeAI(getGeminiApiKey());
  }
  return genAI;
}

/**
 * レストラン選択最適化のメイン関数
 * @param {OptimizationInput} input 最適化入力データ
 * @return {Promise<OptimizedRestaurantResults>} 最適化結果
 */
export async function optimizeRestaurantSelection(
  input: OptimizationInput
): Promise<OptimizedRestaurantResults> {
  try {
    logger.info("Starting restaurant optimization analysis");

    // 1. 参加者プロファイル分析
    const participantProfile = analyzeParticipantProfile(input.participants);
    logger.info("Participant profile analysis completed");

    // 2. 評価基準設定
    const evaluationCriteria = defineEvaluationCriteria(
      input.eventData,
      participantProfile
    );
    logger.info("Evaluation criteria defined");

    // 3. Gemini AI分析プロンプト生成
    const prompt = createOptimizationPrompt(
      input,
      participantProfile,
      evaluationCriteria
    );
    logger.debug("Generated optimization prompt");

    // 4. Gemini AI分析実行
    const client = getGenAIClient();
    const model = client.getGenerativeModel({model: "gemini-2.5-flash"});
    const result = await model.generateContent(prompt);
    const response = await result.response;
    const text = response.text();

    logger.debug("Gemini optimization response received");

    // 5. レスポンス解析
    const optimizedResults = parseOptimizationResponse(
      text,
      input,
      participantProfile,
      evaluationCriteria
    );

    logger.info("Restaurant optimization completed successfully");
    return optimizedResults;
  } catch (error) {
    logger.error("Failed to optimize restaurant selection:", error);
    throw new AIProcessingError(
      "Failed to optimize restaurant selection",
      ErrorCodes.GEMINI_API_ERROR,
      error
    );
  }
}

/**
 * 参加者プロファイルを分析
 * @param {any[]} participants 参加者データ
 * @return {ParticipantProfile} 参加者プロファイル
 */
function analyzeParticipantProfile(participants: any[]): ParticipantProfile {
  // 年齢分布分析
  const positions = participants
    .map((p) => p.positionOrGrade)
    .filter((pos) => pos && typeof pos === "string");

  const ageDistribution: string[] = [];
  const positionHierarchy: string[] = [];

  positions.forEach((position) => {
    if (position.includes("新人") || position.includes("1年目")) {
      ageDistribution.push("20代前半");
      positionHierarchy.push("新入社員");
    } else if (position.includes("中堅") || position.includes("主任")) {
      ageDistribution.push("20代後半-30代前半");
      positionHierarchy.push("中堅社員");
    } else if (position.includes("課長") || position.includes("係長")) {
      ageDistribution.push("30代-40代");
      positionHierarchy.push("管理職");
    } else if (position.includes("部長") || position.includes("取締役")) {
      ageDistribution.push("40代以上");
      positionHierarchy.push("上級管理職");
    }
  });

  // 関係性ダイナミクス分析
  const hasManagement = positionHierarchy.some((pos) =>
    pos.includes("管理職")
  );
  const hasNewEmployees = positionHierarchy.some((pos) =>
    pos.includes("新入")
  );

  let relationshipDynamics = "同僚中心";
  if (hasManagement && hasNewEmployees) {
    relationshipDynamics = "階層混在・配慮が必要";
  } else if (hasManagement) {
    relationshipDynamics = "管理職中心・フォーマル";
  } else if (hasNewEmployees) {
    relationshipDynamics = "若手中心・カジュアル";
  }

  // 希望・制約分析
  const cuisinePreferences = participants
    .flatMap((p) => p.desiredLocations || [])
    .filter((loc) => loc && typeof loc === "string");

  const specialRequirements = participants
    .map((p) => p.allergiesEtc)
    .filter((req) => req && typeof req === "string");

  return {
    demographicAnalysis: {
      ageDistribution: [...new Set(ageDistribution)],
      positionHierarchy: [...new Set(positionHierarchy)],
      relationshipDynamics,
    },
    preferenceAnalysis: {
      cuisinePreferences: [...new Set(cuisinePreferences)],
      atmospherePreferences: [relationshipDynamics.includes("フォーマル") ?
        "落ち着いた" : "親しみやすい"],
      budgetSensitivity: "標準",
      specialRequirements,
    },
    logisticalFactors: {
      transportationMethods: ["電車", "徒歩"],
      accessibilityNeeds: [],
      timeConstraints: ["平日夜間"],
    },
  };
}

/**
 * 評価基準を定義
 * @param {any} eventData イベントデータ
 * @param {ParticipantProfile} profile 参加者プロファイル
 * @return {AnalysisCriteria} 評価基準
 */
function defineEvaluationCriteria(
  eventData: any,
  profile: ParticipantProfile
): AnalysisCriteria {
  const isManagementPresent = profile.demographicAnalysis.positionHierarchy
    .some((pos) => pos.includes("管理職"));

  return {
    budgetCompatibility: 25, // 予算適合度重要
    accessibilityScore: 20, // アクセス重要
    capacityMatch: 15, // 収容能力
    dietaryRestrictions: 10, // 食事制限対応
    atmosphereMatch: isManagementPresent ? 20 : 15, // 雰囲気
    serviceQuality: isManagementPresent ? 15 : 10, // サービス品質
    menuVariety: 10, // メニュー多様性
    groupSuitability: 15, // グループ適性
    timeSlotAvailability: 10, // 時間帯適性
    reservationEase: 15, // 予約容易性
    weatherCompatibility: 5, // 天候対応
    seasonalRelevance: 5, // 季節適性
  };
}

/**
 * 最適化プロンプトを作成
 * @param {OptimizationInput} input 入力データ
 * @param {ParticipantProfile} profile 参加者プロファイル
 * @param {AnalysisCriteria} criteria 評価基準
 * @return {string} プロンプト文字列
 */
function createOptimizationPrompt(
  input: OptimizationInput,
  profile: ParticipantProfile,
  criteria: AnalysisCriteria
): string {
  const restaurantSummary = Object.entries(input.restaurantSearchResults)
    .map(([location, restaurants]) => {
      const restaurantList = restaurants.slice(0, 5).map((r, index) =>
        `${index + 1}. ${r.name} (評価:${r.rating}, 価格帯:${r.priceLevel})`
      ).join("\n");
      return `【${location}】\n${restaurantList}`;
    }).join("\n\n");

  const prompt = `
${input.eventData.purpose || "歓迎会"}（${input.participants.length}人、
予算${input.eventData.budgetUpperLimit || 5000}円/人）の最適レストランを選定してください。

参加者：${profile.demographicAnalysis.relationshipDynamics}

${restaurantSummary}

各エリア上位3店舗を以下JSON形式で回答：
{
  "locationRankings": {
    "エリア名": {
      "topRestaurants": [
        {
          "restaurantName": "店舗名",
          "totalScore": 85,
          "appealPoints": ["魅力1", "魅力2", "魅力3"],
          "concerns": ["懸念1", "懸念2"],
          "recommendation": "HIGHLY_RECOMMENDED"
        }
      ],
      "locationSummary": "エリア総評"
    }
  },
  "overallRecommendation": {
    "bestChoice": {
      "location": "最優秀エリア",
      "restaurantName": "最優秀店舗",
      "reason": "選択理由"
    }
  }
}
`;

  return prompt.trim();
}

/**
 * Gemini最適化レスポンスを解析
 * @param {string} responseText レスポンステキスト
 * @param {OptimizationInput} input 入力データ
 * @param {ParticipantProfile} profile 参加者プロファイル
 * @param {AnalysisCriteria} criteria 評価基準
 * @return {OptimizedRestaurantResults} 最適化結果
 */
function parseOptimizationResponse(
  responseText: string,
  input: OptimizationInput,
  profile: ParticipantProfile,
  criteria: AnalysisCriteria
): OptimizedRestaurantResults {
  try {
    logger.info("Raw Gemini response received", {
      length: responseText.length,
      preview: responseText.substring(0, 200),
    });

    // マークダウンのコードブロックを除去
    let cleanedText = responseText.trim();
    cleanedText = cleanedText.replace(/```json\s*/g, "");
    cleanedText = cleanedText.replace(/```\s*/g, "");
    cleanedText = cleanedText.replace(/^[^{]*/, ""); // JSON開始前の文字を除去
    cleanedText = cleanedText.replace(/[^}]*$/, ""); // JSON終了後の文字を除去

    logger.info("Cleaned text for JSON parsing", {
      length: cleanedText.length,
      preview: cleanedText.substring(0, 200),
    });

    const parsed = JSON.parse(cleanedText);
    logger.info("✅ JSON parsing successful");

    // レスポンスを内部形式に変換
    const locationRankings: {[locationName: string]: any} = {};

    logger.info("Processing location rankings", {
      locations: Object.keys(parsed.locationRankings || {}),
    });

    Object.entries(parsed.locationRankings || {}).forEach(
      ([location, data]: [string, any]) => {
        logger.info(`Processing location: ${location}`, {
          hasTopRestaurants: !!(data.topRestaurants),
          topRestaurantsLength: data.topRestaurants?.length || 0,
        });

        const topRestaurants: RestaurantEvaluation[] =
          (data.topRestaurants || [])
            .map((item: any) => {
              // 対応するレストラン情報を検索
              const matchingRestaurant = findMatchingRestaurant(
                item.restaurantName,
                input.restaurantSearchResults[location] || []
              );

              if (!matchingRestaurant) {
                logger.warn(
                  `Restaurant not found: ${item.restaurantName} in ${location}`
                );
                return null;
              }

              return {
                restaurant: matchingRestaurant,
                location,
                totalScore: item.totalScore || 0,
                scores: item.scores || {},
                appealPoints: item.appealPoints || [],
                concerns: item.concerns || [],
                recommendation: item.recommendation || "SUITABLE",
              };
            })
            .filter((item: any) => item !== null);

        logger.info(`Location ${location} processed`, {
          topRestaurantsCount: topRestaurants.length,
          topRestaurantsType: Array.isArray(topRestaurants) ?
            "Array" : typeof topRestaurants,
        });

        locationRankings[location] = {
          topRestaurants,
          alternativeOptions: [], // 必要に応じて後で実装
          locationSummary:
            data.locationSummary || `${location}エリアの分析結果`,
        };
      }
    );

    logger.info("Location rankings created", {
      locationCount: Object.keys(locationRankings).length,
      locationNames: Object.keys(locationRankings),
    });

    // 全体推奨を構築
    const bestChoice = parsed.overallRecommendation?.bestChoice;
    const bestRestaurant = bestChoice ?
      findMatchingRestaurant(
        bestChoice.restaurantName,
        input.restaurantSearchResults[bestChoice.location] || []
      ) : null;

    const overallRecommendation = {
      bestChoice: bestRestaurant ? {
        location: bestChoice.location,
        restaurant: {
          restaurant: bestRestaurant,
          location: bestChoice.location,
          totalScore: 95,
          scores: {},
          appealPoints: [],
          concerns: [],
          recommendation: "HIGHLY_RECOMMENDED" as const,
        },
        reason: bestChoice.reason || "総合的に最適な選択肢",
      } : getDefaultBestChoice(input),
      alternatives: (parsed.overallRecommendation?.alternatives || [])
        .map((alt: any) => {
          const altRestaurant = findMatchingRestaurant(
            alt.restaurantName,
            input.restaurantSearchResults[alt.location] || []
          );
          return altRestaurant ? {
            location: alt.location,
            restaurant: {
              restaurant: altRestaurant,
              location: alt.location,
              totalScore: 80,
              scores: {},
              appealPoints: [],
              concerns: [],
              recommendation: "RECOMMENDED" as const,
            },
            scenario: alt.scenario || "代替選択肢",
          } : null;
        })
        .filter((item: any) => item !== null),
    };

    const result = {
      locationRankings,
      overallRecommendation,
      analysisMetadata: {
        participantProfile: profile,
        evaluationCriteria: criteria,
        processingTimestamp: Timestamp.fromDate(new Date()),
        confidenceLevel: calculateConfidenceLevel(parsed),
      },
    };

    // JSON互換性を確保するため、結果を一度JSONに変換してから戻す
    // これによりFlutter側でのIdentityMapエラーを防ぐ
    logger.info("Ensuring JSON compatibility for Flutter");
    const jsonSafeResult = JSON.parse(JSON.stringify(result));

    // 🚨 CRITICAL FIX: 明示的にプリミティブ配列に変換
    // Cloud Functions プラットフォームによるIdentityMap変換を防ぐ
    logger.info("Converting to primitive arrays to prevent IdentityMap");
    Object.entries(jsonSafeResult.locationRankings).forEach(
      ([location, data]: [string, any]) => {
        if (data.topRestaurants && Array.isArray(data.topRestaurants)) {
          // 完全に新しい配列として作成し、各要素をプレーンオブジェクトに変換
          data.topRestaurants = data.topRestaurants.map((item: any) => {
            // 各オブジェクトを完全にプレーンオブジェクトに変換
            return JSON.parse(JSON.stringify(item));
          });

          // 配列自体も新しいArray インスタンスとして作成
          const newArray = [...data.topRestaurants];
          data.topRestaurants = newArray;

          logger.info(`✅ ${location}: Converted to primitive array`, {
            isArray: Array.isArray(data.topRestaurants),
            length: data.topRestaurants.length,
            constructor: data.topRestaurants.constructor.name,
          });
        }

        // alternativeOptionsも同様に処理
        if (data.alternativeOptions && Array.isArray(data.alternativeOptions)) {
          data.alternativeOptions = data.alternativeOptions.map((item: any) => {
            return JSON.parse(JSON.stringify(item));
          });
          const newAltArray = [...data.alternativeOptions];
          data.alternativeOptions = newAltArray;
        }
      }
    );

    // 最終的にlocationRankings自体も新しいオブジェクトとして作成
    const primitiveResult = {
      ...jsonSafeResult,
      locationRankings: {
        ...jsonSafeResult.locationRankings,
      },
    };

    // 各locationのtopRestaurantsが確実に配列であることを検証
    Object.entries(primitiveResult.locationRankings).forEach(
      ([location, data]: [string, any]) => {
        if (!Array.isArray(data.topRestaurants)) {
          logger.error(`topRestaurants is not array for ${location}:`, {
            type: typeof data.topRestaurants,
            content: data.topRestaurants,
          });
          // 配列でない場合は空配列にする
          data.topRestaurants = [];
        }
        logger.info(`Verified ${location} topRestaurants:`, {
          isArray: Array.isArray(data.topRestaurants),
          length: data.topRestaurants.length,
        });
      }
    );

    logger.info("✅ Normal optimization results created successfully");

    return primitiveResult;
  } catch (error) {
    logger.error("❌ Failed to parse optimization response:", {
      error: error instanceof Error ?
        error.message : String(error),
      responseText: responseText.substring(0, 500),
    });

    logger.info("🔄 Using fallback optimization results");

    // フォールバック: 基本的な結果を返す
    const fallbackResults = createFallbackOptimizationResults(
      input, profile, criteria
    );

    // フォールバック結果でも JSON 互換性を確保
    const jsonSafeFallback = JSON.parse(JSON.stringify(fallbackResults));

    // 各locationのtopRestaurantsが確実に配列であることを検証
    Object.entries(jsonSafeFallback.locationRankings).forEach(
      ([location, data]: [string, any]) => {
        if (!Array.isArray(data.topRestaurants)) {
          logger.error(
            `Fallback topRestaurants is not array for ${location}:`, {
              type: typeof data.topRestaurants,
              content: data.topRestaurants,
            });
          data.topRestaurants = [];
        }
        logger.info(`Verified fallback ${location} topRestaurants:`, {
          isArray: Array.isArray(data.topRestaurants),
          length: data.topRestaurants.length,
        });
      }
    );

    logger.info("✅ Fallback optimization results created successfully");
    return jsonSafeFallback;
  }
}

/**
 * レストラン名から対応するレストラン情報を検索
 * @param {string} restaurantName レストラン名
 * @param {Restaurant[]} restaurants レストランリスト
 * @return {Restaurant | null} 一致するレストラン
 */
function findMatchingRestaurant(
  restaurantName: string,
  restaurants: Restaurant[]
): Restaurant | null {
  // 完全一致を優先
  let match = restaurants.find((r) => r.name === restaurantName);
  if (match) return match;

  // 部分一致で検索
  match = restaurants.find((r) =>
    r.name.includes(restaurantName) || restaurantName.includes(r.name)
  );
  if (match) return match;

  // 見つからない場合は最初のレストランを返す
  return restaurants.length > 0 ? restaurants[0] : null;
}

/**
 * デフォルトの最優秀選択肢を取得
 * @param {OptimizationInput} input 入力データ
 * @return {any} デフォルト最優秀選択肢
 */
function getDefaultBestChoice(input: OptimizationInput): any {
  const firstLocation = Object.keys(input.restaurantSearchResults)[0];
  const firstRestaurant = input.restaurantSearchResults[firstLocation]?.[0];

  if (!firstRestaurant) {
    throw new Error("No restaurants available for recommendation");
  }

  return {
    location: firstLocation,
    restaurant: {
      restaurant: firstRestaurant,
      location: firstLocation,
      totalScore: 75,
      scores: {},
      appealPoints: ["評価の高い店舗", "アクセス良好", "予算内対応"],
      concerns: ["詳細分析が不完全"],
      recommendation: "SUITABLE" as const,
    },
    reason: "デフォルト推奨（詳細分析は要確認）",
  };
}

/**
 * 信頼度レベルを計算
 * @param {any} parsedResponse 解析済みレスポンス
 * @return {number} 信頼度レベル (0-100)
 */
function calculateConfidenceLevel(parsedResponse: any): number {
  let confidence = 50; // ベースライン

  // 構造チェック
  if (parsedResponse.locationRankings) confidence += 20;
  if (parsedResponse.overallRecommendation) confidence += 20;

  // データ完全性チェック
  const hasDetailedScoring = Object.values(
    parsedResponse.locationRankings || {}
  ).some((location: any) =>
    location.topRestaurants?.some((restaurant: any) =>
      restaurant.scores && restaurant.appealPoints?.length > 0
    )
  );

  if (hasDetailedScoring) confidence += 10;

  return Math.min(confidence, 95); // 最大95%
}

/**
 * フォールバック最適化結果を作成
 * @param {OptimizationInput} input 入力データ
 * @param {ParticipantProfile} profile 参加者プロファイル
 * @param {AnalysisCriteria} criteria 評価基準
 * @return {OptimizedRestaurantResults} フォールバック結果
 */
function createFallbackOptimizationResults(
  input: OptimizationInput,
  profile: ParticipantProfile,
  criteria: AnalysisCriteria
): OptimizedRestaurantResults {
  const locationRankings: {[locationName: string]: any} = {};

  Object.entries(input.restaurantSearchResults).forEach(
    ([location, restaurants]) => {
      const topRestaurants = restaurants.slice(0, 3).map(
        (restaurant, index) => ({
          restaurant,
          location,
          totalScore: 80 - (index * 5), // 簡単なスコア計算
          scores: {
            budget: 75,
            access: 80,
            atmosphere: 75,
            service: 75,
            menu: 75,
            group: 80,
            situation: 75,
          },
          appealPoints: [
            "評価の高い店舗です",
            "アクセスが良好です",
            "グループでの利用に適しています",
          ],
          concerns: [
            "詳細な分析が実行できませんでした",
            "事前確認をおすすめします",
          ],
          recommendation: index === 0 ? "RECOMMENDED" : "SUITABLE",
        })
      );

      locationRankings[location] = {
        topRestaurants,
        alternativeOptions: [],
        locationSummary:
          `${location}エリアでは${restaurants.length}件の候補があります`,
      };
    }
  );

  return {
    locationRankings,
    overallRecommendation: getDefaultBestChoice(input),
    analysisMetadata: {
      participantProfile: profile,
      evaluationCriteria: criteria,
      processingTimestamp: Timestamp.fromDate(new Date()),
      confidenceLevel: 40, // フォールバックは低信頼度
    },
  };
}
