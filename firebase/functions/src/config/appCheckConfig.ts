/**
 * App Check設定管理
 *
 * 段階的にApp Check強制を有効化するための設定
 */

// App Check強制モードの設定
export const APP_CHECK_CONFIG = {
  // 段階1: 警告モード（現在の設定）
  WARNING_MODE: {
    enforceAppCheck: false,
    consumeAppCheckToken: false,
    description: "App Checkトークンをチェックするが拒否はしない",
  },

  // 段階2: 強制モード
  ENFORCE_MODE: {
    enforceAppCheck: true,
    consumeAppCheckToken: false,
    description: "App Checkトークンを強制し、無効なリクエストを拒否",
  },

  // 段階3: 高セキュリティモード（リプレイ攻撃保護）
  HIGH_SECURITY_MODE: {
    enforceAppCheck: true,
    consumeAppCheckToken: true,
    description: "App Checkトークンを強制し、リプレイ攻撃も防止",
  },
};

// 現在使用中の設定
export const CURRENT_APP_CHECK_MODE = APP_CHECK_CONFIG.WARNING_MODE;

// 機能別のApp Check設定
export const FUNCTION_SPECIFIC_CONFIG = {
  // 場所候補生成: 基本的なApp Check
  generateLocationCandidatesStep: APP_CHECK_CONFIG.WARNING_MODE,

  // キーワード生成: 基本的なApp Check
  generateKeywordsStep: APP_CHECK_CONFIG.WARNING_MODE,

  // レストラン検索: より高いセキュリティが必要な場合はHIGH_SECURITY_MODEに変更可能
  searchRestaurantsStep: APP_CHECK_CONFIG.WARNING_MODE,

  // レストラン選択最適化: 基本的なApp Check
  optimizeRestaurantSelectionStep: APP_CHECK_CONFIG.WARNING_MODE,
};

/**
 * App Checkトークンの検証状況をログに記録
 * @param {string} functionName 関数名
 * @param {boolean} hasAppCheckToken App Checkトークンの有無
 * @param {string} appId アプリID（利用可能な場合）
 */
export function logAppCheckStatus(
  functionName: string,
  hasAppCheckToken: boolean,
  appId?: string
): void {
  const config = FUNCTION_SPECIFIC_CONFIG[
    functionName as keyof typeof FUNCTION_SPECIFIC_CONFIG
  ] || CURRENT_APP_CHECK_MODE;

  if (hasAppCheckToken) {
    console.log(`✅ [${functionName}] Valid App Check token received`, {
      appId,
      mode: config.description,
      enforced: config.enforceAppCheck,
    });
  } else {
    const logLevel = config.enforceAppCheck ? "error" : "warn";
    console[logLevel](`⚠️ [${functionName}] No App Check token provided`, {
      mode: config.description,
      enforced: config.enforceAppCheck,
      note: config.enforceAppCheck ?
        "Request will be rejected" :
        "App Check enforcement will be enabled soon",
    });
  }
}

/**
 * 強制モードへの移行手順
 *
 * 1. 警告モードで十分なテストを実施
 * 2. ログでApp Checkトークンの送信状況を確認
 * 3. CURRENT_APP_CHECK_MODEをENFORCE_MODEに変更
 * 4. 関数定義でenforceAppCheck: trueに更新
 * 5. デプロイして動作確認
 *
 * 高セキュリティが必要な場合:
 * 6. 特定の関数でHIGH_SECURITY_MODEを使用
 * 7. クライアント側でlimitedUseAppCheckTokens: trueを設定
 */
