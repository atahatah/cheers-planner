/**
 * Import function triggers from their respective submodules:
 *
 * import {onCall} from "firebase-functions/v2/https";
 * import {onDocumentWritten} from "firebase-functions/v2/firestore";
 *
 * See a full list of supported triggers at https://firebase.google.com/docs/functions
 */
import * as admin from "firebase-admin";
import { Timestamp } from "firebase-admin/firestore";
import * as logger from "firebase-functions/logger";
import * as functions from "firebase-functions/v2/https";
import {
  validateAuthAndAppCheck,
  validateEventId,
} from "./services/validationService";
import { AIResults, Event, Participant } from "./types/common";

// The Cloud Functions for Firebase SDK to create Cloud Functions and triggers.
// The Firebase Admin SDK to access Firestore.

// Firebase Admin初期化
try {
  admin.initializeApp();
  logger.info("Firebase Admin initialized successfully");
} catch (error) {
  logger.error("Failed to initialize Firebase Admin:", error);
  throw error;
}

// AI処理関連のインポート
import { generateLocationCandidates } from "./api/geminiService";
import { searchRestaurantsByLocations } from "./api/placesService";
import {
  optimizeRestaurantSelection,
} from "./api/restaurantOptimizationService";

// Start writing functions
// https://firebase.google.com/docs/functions/typescript

// エミュレータ使用フラグの確認
const isEmulator = process.env.FUNCTIONS_EMULATOR === "true";

/**
 * イベントの参加者情報からAI分析を実行する
 */
export const executeAI = functions.onCall(
  {
    // エミュレータ使用時はリージョン指定なし、本番環境時はリージョン指定
    ...(isEmulator ? {} : { region: "asia-northeast1" }),
    cors: [
      // 本番環境
      "https://cheers-planner.web.app",
      "https://cheers-planner.firebaseapp.com",
      // 開発環境
      /^http:\/\/localhost:\d+$/,
      /^http:\/\/127\.0\.0\.1:\d+$/,
    ],
  },
  async (request) => {
    try {
      logger.info("executeAI function called", {
        data: request.data,
        auth: request.auth?.uid,
      });

      // 認証チェック
      if (!request.auth?.uid) {
        throw new functions.HttpsError(
          "unauthenticated",
          "User must be authenticated"
        );
      }

      const {eventId} = request.data;
      if (!eventId || typeof eventId !== "string") {
        throw new functions.HttpsError(
          "invalid-argument",
          "Event ID is required"
        );
      }

      const db = admin.firestore();

      // イベント情報取得
      const eventDoc = await db.doc(`events/${eventId}`).get();
      if (!eventDoc.exists) {
        throw new functions.HttpsError(
          "not-found",
          "Event not found"
        );
      }

      const eventData = { id: eventDoc.id, ...eventDoc.data() } as Event;

      // 参加者情報取得
      const participantsSnapshot = await db
        .collection(`events/${eventId}/participants`)
        .get();

      if (participantsSnapshot.empty) {
        throw new functions.HttpsError(
          "failed-precondition",
          "No participants found"
        );
      }

      const participants: Participant[] = participantsSnapshot.docs.map(
        (doc) => ({ id: doc.id, ...doc.data() }) as Participant
      );

      logger.info(`Found ${participants.length} participants`);

      // 場所候補生成
      const locationCandidates = await generateLocationCandidates(
        eventData,
        participants
      );

      // 結果をFirestoreに保存
      const aiResults: Partial<AIResults> = {
        locationCandidates,
        restaurantSearchResults: {},
        status: "processing",
        generatedAt: createTimestamp(),
        processedBy: request.auth.uid,
      };

      // イベントドキュメント内のaiResultsフィールドとして保存
      await db.doc(`events/${eventId}`).update({
        aiResults: aiResults,
      });

      logger.info("AI processing completed successfully", {
        eventId,
        locationCandidatesCount: locationCandidates.length,
      });

      return {
        success: true,
        locationCandidates,
        message: "場所候補が正常に生成されました",
      };
    } catch (error) {
      logger.error("executeAI function error:", error);

      if (error instanceof functions.HttpsError) {
        throw error;
      }

      throw new functions.HttpsError(
        "internal",
        "AI処理中にエラーが発生しました",
        {originalError: error}
      );
    }
  }
);

/**
 * ヘルスチェック用関数
 */
export const healthCheck = functions.onRequest(
  {
    // エミュレータ使用時はリージョン指定なし、本番環境時はリージョン指定
    ...(isEmulator ? {} : { region: "asia-northeast1" }),
    cors: [
      // 本番環境
      "https://cheers-planner.web.app",
      "https://cheers-planner.firebaseapp.com",
      // 開発環境
      /^http:\/\/localhost:\d+$/,
      /^http:\/\/127\.0\.0\.1:\d+$/,
    ],
  },
  (req, res) => {
    res.json({
      status: "ok",
      timestamp: new Date().toISOString(),
      message: "Firebase Functions is running",
    });
  }
);

/**
 * ステップ1: 場所候補を生成する
 */
export const generateLocationCandidatesStep = functions.onCall(
  {
    // エミュレータ使用時はリージョン指定なし、本番環境時はリージョン指定
    ...(isEmulator ? {} : { region: "asia-northeast1" }),
    cors: [
      // 本番環境
      "https://cheers-planner.web.app",
      "https://cheers-planner.firebaseapp.com",
      // 開発環境
      /^http:\/\/localhost:\d+$/,
      /^http:\/\/127\.0\.0\.1:\d+$/,
    ],
    // App Check警告モード: トークンをチェックするが拒否はしない
    // enforceAppCheck: false (デフォルト)
  },
  async (request) => {
    try {
      logger.info("generateLocationCandidatesStep function called", {
        data: request.data,
        auth: request.auth?.uid,
        hasAppCheckToken: !!request.app,
        appId: request.app?.appId,
      });

      // App Checkトークンの状況をログ記録
      if (request.app) {
        logger.info("✅ Valid App Check token received", {
          appId: request.app.appId,
          function: "generateLocationCandidatesStep",
        });
      } else {
        logger.warn("⚠️ No App Check token provided", {
          function: "generateLocationCandidatesStep",
          note: "App Check enforcement will be enabled soon",
        });
      }

      // 認証チェック
      if (!request.auth?.uid) {
        throw new functions.HttpsError(
          "unauthenticated",
          "ユーザー認証が必要です"
        );
      }

      const { eventId } = request.data;
      if (!eventId || typeof eventId !== "string") {
        throw new functions.HttpsError(
          "invalid-argument",
          "イベントIDが必要です"
        );
      }

      const db = admin.firestore();

      logger.info("Step 1: Database connection established");

      // イベント情報取得
      const eventDoc = await db.doc(`events/${eventId}`).get();
      if (!eventDoc.exists) {
        throw new functions.HttpsError(
          "not-found",
          "イベントが見つかりません"
        );
      }

      const eventData = { id: eventDoc.id, ...eventDoc.data() } as Event;
      logger.info("Step 1: Event data fetched");

      // 参加者情報取得
      const participantsSnapshot = await db
        .collection(`events/${eventId}/participants`)
        .get();

      if (participantsSnapshot.empty) {
        throw new functions.HttpsError(
          "failed-precondition",
          "参加者が見つかりません"
        );
      }
      const participants: Participant[] = participantsSnapshot.docs.map(
        (doc) => ({ id: doc.id, ...doc.data() }) as Participant
      );
      logger.info(`Step 1: ${participants.length} participants data fetched`);

      // 場所候補生成
      logger.info("Step 4: Starting location candidate generation");
      const locationCandidates = await generateLocationCandidates(
        eventData,
        participants
      );

      logger.info(
        "Step 5: Location candidates generated successfully"
      );

      // Firebase Admin SDK状況確認（デバッグ用）
      logger.info("Step 6: Pre-timestamp creation check:", {
        adminType: typeof admin,
        firestoreType: typeof admin.firestore,
        timestampType: typeof (admin.firestore && admin.firestore.Timestamp),
        timestampExists: !!(admin.firestore && admin.firestore.Timestamp),
      });

      // 結果をFirestoreに保存（一時保存）
      logger.info("Step 7: Creating timestamp");
      const generatedAt = createTimestamp();
      logger.info("Step 8: Timestamp created successfully");
      const aiResults = {
        locationCandidates,
        restaurantSearchResults: {},
        keywords: [],
        status: "location_generated",
        generatedAt,
        processedBy: request.auth.uid,
        appCheckVerified: !!request.app,
      };

      logger.info("Step 9: aiResults object created, saving to Firestore");

      // イベントドキュメント内のaiResultsフィールドとして保存
      await db.doc(`events/${eventId}`).update({
        aiResults: aiResults,
      });

      logger.info("Step 10: Data saved to Firestore successfully");

      return {
        success: true,
        locationCandidates,
        message: "場所候補が正常に生成されました",
      };
    } catch (error) {
      logger.error("generateLocationCandidatesStep function error:", error);

      if (error instanceof functions.HttpsError) {
        throw error;
      }

      throw new functions.HttpsError(
        "internal",
        "場所候補生成中にエラーが発生しました",
        { originalError: error }
      );
    }
  }
);

/**
 * ステップ2: 検索キーワードを生成する
 */
export const generateKeywordsStep = functions.onCall(
  {
    // エミュレータ使用時はリージョン指定なし、本番環境時はリージョン指定
    ...(isEmulator ? {} : { region: "asia-northeast1" }),
    cors: [
      // 本番環境
      "https://cheers-planner.web.app",
      "https://cheers-planner.firebaseapp.com",
      // 開発環境
      /^http:\/\/localhost:\d+$/,
      /^http:\/\/127\.0\.0\.1:\d+$/,
    ],
    // App Check警告モード: トークンをチェックするが拒否はしない
    // enforceAppCheck: false (デフォルト)
  },
  async (request) => {
    try {
      logger.info("generateKeywordsStep function called", {
        data: request.data,
        auth: request.auth?.uid,
        hasAppCheckToken: !!request.app,
        appId: request.app?.appId,
      });

      // App Checkトークンの状況をログ記録
      if (request.app) {
        logger.info("✅ Valid App Check token received", {
          appId: request.app.appId,
          function: "generateKeywordsStep",
        });
      } else {
        logger.warn("⚠️ No App Check token provided", {
          function: "generateKeywordsStep",
          note: "App Check enforcement will be enabled soon",
        });
      }

      // 認証チェック
      if (!request.auth?.uid) {
        throw new functions.HttpsError(
          "unauthenticated",
          "ユーザー認証が必要です"
        );
      }

      const { eventId } = request.data;
      if (!eventId || typeof eventId !== "string") {
        throw new functions.HttpsError(
          "invalid-argument",
          "イベントIDが必要です"
        );
      }

      const db = admin.firestore();

      // イベント情報取得
      const eventDoc = await db.doc(`events/${eventId}`).get();
      if (!eventDoc.exists) {
        throw new functions.HttpsError(
          "not-found",
          "イベントが見つかりません"
        );
      }

      const eventData = { id: eventDoc.id, ...eventDoc.data() } as Event;

      // 参加者情報取得
      const participantsSnapshot = await db
        .collection(`events/${eventId}/participants`)
        .get();

      const participants: Participant[] = participantsSnapshot.docs.map(
        (doc) => ({ id: doc.id, ...doc.data() }) as Participant
      );

      // キーワード生成（予算と目的に基づく）
      const keywords = generateSearchKeywords(
        eventData?.purpose || "歓迎会",
        eventData?.budgetUpperLimit || 5000,
        participants
      );

      // 既存のAI結果を取得して更新
      const existingResults = eventData?.aiResults || {};

      const updatedResults = {
        ...existingResults,
        keywords,
        status: "keywords_generated",
        updatedAt: createTimestamp(),
        appCheckVerified: !!request.app,
      };

      // イベントドキュメント内のaiResultsフィールドを更新
      await db.doc(`events/${eventId}`).update({
        aiResults: updatedResults,
      });

      logger.info("Keywords generated successfully", {
        eventId,
        keywordsCount: keywords.length,
        appCheckVerified: !!request.app,
      });

      return {
        success: true,
        keywords,
        message: "検索キーワードが正常に生成されました",
      };
    } catch (error) {
      logger.error("generateKeywordsStep function error:", error);

      if (error instanceof functions.HttpsError) {
        throw error;
      }

      throw new functions.HttpsError(
        "internal",
        "キーワード生成中にエラーが発生しました",
        { originalError: error }
      );
    }
  }
);

/**
 * ステップ3: レストランを検索する
 */
export const searchRestaurantsStep = functions.onCall(
  {
    // エミュレータ使用時はリージョン指定なし、本番環境時はリージョン指定
    ...(isEmulator ? {} : { region: "asia-northeast1" }),
    cors: [
      // 本番環境
      "https://cheers-planner.web.app",
      "https://cheers-planner.firebaseapp.com",
      // 開発環境
      /^http:\/\/localhost:\d+$/,
      /^http:\/\/127\.0\.0\.1:\d+$/,
    ],
    // App Check警告モード: トークンをチェックするが拒否はしない
    // enforceAppCheck: false (デフォルト)
  },
  async (request) => {
    try {
      logger.info("searchRestaurantsStep function called", {
        data: request.data,
        auth: request.auth?.uid,
        hasAppCheckToken: !!request.app,
        appId: request.app?.appId,
      });

      // App Checkトークンの状況をログ記録
      if (request.app) {
        logger.info("✅ Valid App Check token received", {
          appId: request.app.appId,
          function: "searchRestaurantsStep",
        });
      } else {
        logger.warn("⚠️ No App Check token provided", {
          function: "searchRestaurantsStep",
          note: "App Check enforcement will be enabled soon",
        });
      }

      // 認証チェック
      if (!request.auth?.uid) {
        throw new functions.HttpsError(
          "unauthenticated",
          "ユーザー認証が必要です"
        );
      }

      const { eventId } = request.data;
      if (!eventId || typeof eventId !== "string") {
        throw new functions.HttpsError(
          "invalid-argument",
          "イベントIDが必要です"
        );
      }

      const db = admin.firestore();

      // 既存のAI結果を取得
      const eventDoc = await db.doc(`events/${eventId}`).get();
      if (!eventDoc.exists) {
        throw new functions.HttpsError(
          "not-found",
          "イベントが見つかりません"
        );
      }

      const eventData = { id: eventDoc.id, ...eventDoc.data() } as Event;
      const aiResults = eventData?.aiResults;
      if (!aiResults) {
        throw new functions.HttpsError(
          "failed-precondition",
          "場所候補が生成されていません。先にgenerateLocationCandidatesStepを実行してください"
        );
      }

      const locationCandidates = aiResults?.locationCandidates;
      if (!locationCandidates || locationCandidates.length === 0) {
        throw new functions.HttpsError(
          "failed-precondition",
          "有効な場所候補が見つかりません"
        );
      }

      // 参加者情報取得（キーワード生成に必要）
      const participantsSnapshot = await db
        .collection(`events/${eventId}/participants`)
        .get();

      const participants: Participant[] = participantsSnapshot.docs.map(
        (doc) => ({ id: doc.id, ...doc.data() }) as Participant
      );

      // イベントデータから予算と目的を取得
      const budgetUpperLimit = eventData?.budgetUpperLimit || 5000;
      const eventPurpose = eventData?.purpose || "飲み会";

      // 検索キーワードを生成（上位4つに絞る）
      const allKeywords = generateSearchKeywords(
        eventPurpose,
        budgetUpperLimit,
        participants
      );
      const keywords = allKeywords.slice(0, 4); // 上位4つに絞る

      logger.info("Generated keywords for search:", keywords);

      // 各場所でレストラン検索を実行
      const restaurantSearchResults = await searchRestaurantsByLocations(
        locationCandidates,
        budgetUpperLimit,
        eventPurpose,
        keywords,
        10 // maxResults
      );

      // 結果をFirestoreに保存
      const finalResults = {
        ...aiResults,
        restaurantSearchResults,
        status: "restaurants_searched",
        completedAt: createTimestamp(),
        appCheckVerified: !!request.app,
      };

      // イベントドキュメント内のaiResultsフィールドを更新
      await db.doc(`events/${eventId}`).update({
        aiResults: finalResults,
      });

      logger.info("Restaurant search completed successfully", {
        eventId,
        searchResultsCount: Object.keys(restaurantSearchResults).length,
        appCheckVerified: !!request.app,
      });

      return {
        success: true,
        restaurantSearchResults,
        message: "レストラン検索が正常に完了しました",
      };
    } catch (error) {
      logger.error("searchRestaurantsStep function error:", error);

      if (error instanceof functions.HttpsError) {
        throw error;
      }

      throw new functions.HttpsError(
        "internal",
        "レストラン検索中にエラーが発生しました",
        { originalError: error }
      );
    }
  }
);

/**
 * ステップ4: レストラン選択を最適化する
 */
export const optimizeRestaurantsStep = functions.onCall(
  {
    // エミュレータ使用時はリージョン指定なし、本番環境時はリージョン指定
    ...(isEmulator ? {} : { region: "asia-northeast1" }),
    timeoutSeconds: 300, // 5分のタイムアウト
    memory: "1GiB", // より多くのメモリを割り当て
    cors: [
      // 本番環境
      "https://cheers-planner.web.app",
      "https://cheers-planner.firebaseapp.com",
      // 開発環境
      /^http:\/\/localhost:\d+$/,
      /^http:\/\/127\.0\.0\.1:\d+$/,
    ],
    // App Check警告モード: トークンをチェックするが拒否はしない
    // enforceAppCheck: false (デフォルト)
  },
  async (request) => {
    try {
      // 統合検証: 認証、App Check、EventID
      const uid = validateAuthAndAppCheck(
        request,
        "optimizeRestaurantsStep"
      );
      const eventId = validateEventId(request.data);

      logger.info("Step 4: optimizeRestaurantsStep function called", {
        uid,
        eventId,
      });

      const db = admin.firestore();

      // イベントと参加者、AI結果を取得
      const eventDoc = await db.doc(`events/${eventId}`).get();
      if (!eventDoc.exists) {
        throw new functions.HttpsError(
          "not-found",
          "イベントが見つかりません"
        );
      }

      const eventData = { id: eventDoc.id, ...eventDoc.data() } as Event;
      const aiResults = eventData?.aiResults;

      // 前段階の完了チェック
      if (!aiResults) {
        throw new functions.HttpsError(
          "failed-precondition",
          "AI分析結果が見つかりません。Step1から順次実行してください"
        );
      }

      const {
        locationCandidates,
        restaurantSearchResults,
        keywords,
      } = aiResults;

      if (!locationCandidates || locationCandidates.length === 0) {
        throw new functions.HttpsError(
          "failed-precondition",
          "場所候補が生成されていません。Step1を実行してください"
        );
      }

      if (!restaurantSearchResults ||
          Object.keys(restaurantSearchResults).length === 0) {
        throw new functions.HttpsError(
          "failed-precondition",
          "レストラン検索が完了していません。Step3を実行してください"
        );
      }

      // 参加者情報取得
      const participantsSnapshot = await db
        .collection(`events/${eventId}/participants`)
        .get();

      const participants: Participant[] = participantsSnapshot.docs.map(
        (doc) => ({ id: doc.id, ...doc.data() }) as Participant
      );

      if (participants.length === 0) {
        throw new functions.HttpsError(
          "failed-precondition",
          "参加者情報が見つかりません"
        );
      }

      // 最適化実行
      logger.info("Starting restaurant optimization");

      const optimizationInput = {
        restaurantSearchResults,
        locationCandidates,
        keywords: keywords || [],
        eventData,
        participants,
      };

      const optimizedResults = await optimizeRestaurantSelection(
        optimizationInput
      );

      logger.info("Restaurant optimization completed successfully");

      // 結果をFirestoreに保存
      const finalResults = {
        ...aiResults,
        optimizedResults,
        status: "optimization_completed",
        completedAt: createTimestamp(),
        appCheckVerified: !!request.app,
      };

      // イベントドキュメント内のaiResultsフィールドを更新
      await db.doc(`events/${eventId}`).update({
        aiResults: finalResults,
      });

      logger.info("Optimization results saved successfully", {
        eventId,
        locationsAnalyzed:
          Object.keys(optimizedResults.locationRankings).length,
        appCheckVerified: !!request.app,
      });

      return {
        success: true,
        optimizedResults,
        message: "レストラン選択最適化が正常に完了しました",
      };
    } catch (error) {
      logger.error(
        "optimizeRestaurantsStep function error:",
        error
      );

      if (error instanceof functions.HttpsError) {
        throw error;
      }

      throw new functions.HttpsError(
        "internal",
        "レストラン選択最適化中にエラーが発生しました",
        { originalError: error }
      );
    }
  }
);

/**
 * 検索キーワードを生成するヘルパー関数
 * @param {string} purpose イベントの目的
 * @param {number} budgetUpperLimit 予算上限
 * @param {any[]} participants 参加者リスト
 * @return {string[]} 生成されたキーワードリスト
 */
function generateSearchKeywords(
  purpose: string,
  budgetUpperLimit: number,
  participants: Participant[]
): string[] {
  logger.info("Generating search keywords...", {
    purpose,
    budgetUpperLimit,
    participantCount: participants.length,
  });

  // 参加者の要望を分析
  const locationRequests = participants
    .flatMap((p) => p.desiredLocations || [])
    .filter((loc) => loc);
  const allergyInfo = participants
    .map((p) => p.allergiesEtc)
    .filter((allergy) => allergy && allergy !== "特になし");
  // budgetの集計
  const budgetSum = participants.reduce(
    (sum, p) => sum + (p.desiredBudget || 0),
    0
  );
  const averageBudget =
    participants.length > 0 ? budgetSum / participants.length : 0;

  // 年齢層や役職の分析
  const positions = participants.map((p) => p.positionOrGrade);
  const uniquePositions = [...new Set(positions)];

  // キーワードの生成ロジック
  const baseKeywords = ["居酒屋", "レストラン"];
  const keywords: string[] = [...baseKeywords];

  // 目的に基づくキーワード
  const purposeKeywords: { [key: string]: string[] } = {
    "歓迎会": ["歓迎会", "新人歓迎", "歓送迎会", "宴会"],
    "送別会": ["送別会", "歓送迎会", "宴会"],
    "忘年会": ["忘年会", "宴会", "年末"],
    "新年会": ["新年会", "宴会", "年始"],
    "懇親会": ["懇親会", "パーティー"],
    "打ち上げ": ["打ち上げ", "慰労会"],
  };

  if (purposeKeywords[purpose]) {
    keywords.push(...purposeKeywords[purpose]);
  }

  // 予算に基づくキーワード
  if (budgetUpperLimit <= 2000) {
    keywords.push("格安", "安い", "リーズナブル");
  } else if (budgetUpperLimit <= 3500) {
    keywords.push("手頃", "コスパ");
  } else if (budgetUpperLimit <= 5000) {
    keywords.push("中級", "おすすめ");
  } else {
    keywords.push("高級", "上質", "接待");
  }

  // 参加者構成に基づくキーワード
  const hasManager = positions.some((p) =>
    p.includes("管理職") || p.includes("部長") || p.includes("課長")
  );

  const hasNewEmployee = positions.some((p) =>
    p.includes("新人") || p.includes("1年目")
  );

  if (hasManager) {
    keywords.push("接待", "上質", "落ち着いた");
  }

  if (hasNewEmployee) {
    keywords.push("アットホーム", "カジュアル");
  }

  // 重複除去して返す
  return [...new Set(keywords)];
}

/**
 * 安全なFirestore Timestampを作成するヘルパー関数
 * @return {Timestamp} 現在時刻のTimestamp
 */
function createTimestamp(): Timestamp {
  try {
    // 新しいインポート方法でTimestamp.fromDateを使用
    return Timestamp.fromDate(new Date());
  } catch (error) {
    logger.error(
      "Failed to create timestamp with fromDate, trying alternative:",
      error
    );
    try {
      // 代替方法: 直接Timestampコンストラクタを使用
      const now = new Date();
      const seconds = Math.floor(now.getTime() / 1000);
      const nanoseconds = (now.getTime() % 1000) * 1000000;
      return new Timestamp(seconds, nanoseconds);
    } catch (altError) {
      logger.error(
        "Failed to create timestamp with alternative method:",
        altError
      );
      throw altError;
    }
  }
}
