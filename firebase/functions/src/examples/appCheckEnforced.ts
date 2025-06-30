/**
 * App Check強制モードの実装例
 *
 * 警告モードでのテスト完了後、この実装を参考にして
 * 実際の関数にApp Check強制を適用してください
 */

import * as logger from "firebase-functions/logger";
import * as functions from "firebase-functions/v2/https";

/**
 * 段階2: App Check強制モードの実装例
 */
export const exampleEnforcedFunction = functions.onCall(
  {
    region: "asia-northeast1",
    cors: true,
    enforceAppCheck: true, // App Checkトークンを強制
  },
  async (request) => {
    // request.appは自動的に検証済み
    logger.info("✅ App Check token verified", {
      appId: request.app?.appId,
      function: "exampleEnforcedFunction",
    });

    // 認証チェック
    if (!request.auth?.uid) {
      throw new functions.HttpsError(
        "unauthenticated",
        "ユーザー認証が必要です"
      );
    }

    // 通常の処理...
    return {
      success: true,
      message: "App Check強制モードで正常に処理されました",
      appId: request.app?.appId,
    };
  }
);

/**
 * 段階3: 高セキュリティモード（リプレイ攻撃保護）の実装例
 */
export const exampleHighSecurityFunction = functions.onCall(
  {
    region: "asia-northeast1",
    cors: true,
    enforceAppCheck: true, // App Checkトークンを強制
    consumeAppCheckToken: true, // リプレイ攻撃保護
  },
  async (request) => {
    // request.appは自動的に検証済み、トークンは消費される
    logger.info("🔒 App Check token verified and consumed", {
      appId: request.app?.appId,
      function: "exampleHighSecurityFunction",
    });

    // 認証チェック
    if (!request.auth?.uid) {
      throw new functions.HttpsError(
        "unauthenticated",
        "ユーザー認証が必要です"
      );
    }

    // 機密性の高い処理...
    return {
      success: true,
      message: "高セキュリティモードで正常に処理されました",
      appId: request.app?.appId,
    };
  }
);

/**
 * 実際の関数への適用手順:
 *
 * 1. 警告モードで十分なテストを実施
 * 2. Firebase Functionsのログを確認してApp Checkトークンが送信されていることを確認
 * 3. 以下の変更を適用:
 *
 * // 変更前（警告モード）
 * export const generateLocationCandidatesStep = functions.onCall(
 *   {
 *     region: "asia-northeast1",
 *     cors: true,
 *     // enforceAppCheck: false (デフォルト)
 *   },
 *   async (request) => {
 *     // App Checkトークンの手動チェック...
 *   }
 * );
 *
 * // 変更後（強制モード）
 * export const generateLocationCandidatesStep = functions.onCall(
 *   {
 *     region: "asia-northeast1",
 *     cors: true,
 *     enforceAppCheck: true, // 追加
 *   },
 *   async (request) => {
 *     // request.appが自動的に検証済み
 *     // 手動チェックのコードは削除可能
 *   }
 * );
 */
