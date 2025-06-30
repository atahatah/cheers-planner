import * as logger from "firebase-functions/logger";
import * as functions from "firebase-functions/v2";

/**
 * エラーコードの定義
 */
export const ErrorCodes = {
  // Places API関連
  PLACES_API_ERROR: "places_api_error",
  NO_PLACES_FOUND: "no_places_found",
  INVALID_PLACE_DATA: "invalid_place_data",

  // Gemini API関連
  GEMINI_API_ERROR: "gemini_api_error",

  // Firebase関連
  UNAUTHENTICATED: "unauthenticated",
  PERMISSION_DENIED: "permission_denied",

  // その他
  UNKNOWN_ERROR: "unknown-error",
  INVALID_ARGUMENT: "invalid-argument",
  EVENT_NOT_FOUND: "event-not-found",
  UNAUTHORIZED_ACCESS: "unauthorized-access",
  INVALID_EVENT_DATA: "invalid-event-data",
};

/**
 * カスタムエラークラス (Places API)
 */
export class PlacesAPIError extends Error {
  /**
   * PlacesAPIErrorのコンストラクタ
   * @param {string} message エラーメッセージ
   * @param {string} code エラーコード
   * @param {any} details エラー詳細
   */
  constructor(
    public message: string,
    public code: string,
    public details?: any
  ) {
    super(message);
    this.name = "PlacesAPIError";
  }
}

/**
 * カスタムエラークラス (AI処理)
 */
export class AIProcessingError extends Error {
  /**
   * AIProcessingErrorのコンストラクタ
   * @param {string} message エラーメッセージ
   * @param {string} code エラーコード
   * @param {any} details エラー詳細
   */
  constructor(
    public message: string,
    public code: string,
    public details?: any
  ) {
    super(message);
    this.name = "AIProcessingError";
  }
}

/**
 * エラーを適切なHttpsErrorに変換する
 * @param {any} error 元のエラー
 * @return {functions.https.HttpsError} 変換されたHttpsError
 */
export function handleError(error: any): functions.https.HttpsError {
  logger.error("Function error:", error);

  if (error instanceof AIProcessingError) {
    return new functions.https.HttpsError(
      "internal",
      error.message,
      {code: error.code, details: error.details}
    );
  }

  if (error instanceof PlacesAPIError) {
    if (error.code === ErrorCodes.PLACES_API_ERROR) {
      return new functions.https.HttpsError(
        "resource-exhausted",
        "Google Places API quota exceeded",
        {code: error.code}
      );
    }
    return new functions.https.HttpsError(
      "invalid-argument",
      error.message,
      {code: error.code}
    );
  }

  if (error instanceof functions.https.HttpsError) {
    return error;
  }

  // 未知のエラー
  return new functions.https.HttpsError(
    "internal",
    "An unexpected error occurred",
    {originalError: error.message}
  );
}

/**
 * 指数バックオフを使用してリトライを行う
 * @param {function(): Promise<T>} operation 実行する操作
 * @param {number} maxRetries 最大リトライ回数
 * @param {number} baseDelay 基本遅延時間(ms)
 * @return {Promise<T>} 操作の結果
 * @template T
 */
export async function retryWithExponentialBackoff<T>(
  operation: () => Promise<T>,
  maxRetries = 3,
  baseDelay = 1000
): Promise<T> {
  let lastError: Error | null = null;

  for (let attempt = 0; attempt <= maxRetries; attempt++) {
    try {
      return await operation();
    } catch (error) {
      lastError = error as Error;

      if (attempt === maxRetries) {
        break;
      }

      const delay = baseDelay * Math.pow(2, attempt);
      logger.warn(
        `Attempt ${attempt + 1} failed, retrying in ${delay}ms:`,
        error
      );
      await new Promise((resolve) => setTimeout(resolve, delay));
    }
  }

  if (lastError) {
    throw lastError;
  }
  throw new Error("Operation failed without specific error");
}
