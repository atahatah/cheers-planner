import * as admin from "firebase-admin";
import * as logger from "firebase-functions/logger";
import * as functions from "firebase-functions/v2/https";
import { z } from "zod";
import { AIProcessingError, ErrorCodes } from "../utils/errorHandler";

/**
 * 認証を検証し、ユーザーIDを返す
 * @param {functions.CallableRequest} request Function呼び出しリクエスト
 * @return {string} 認証されたユーザーID
 */
export function validateAuth(request: functions.CallableRequest): string {
  if (!request.auth?.uid) {
    throw new functions.HttpsError(
      "unauthenticated",
      "User must be authenticated"
    );
  }
  return request.auth.uid;
}

/**
 * App Check と認証の両方を検証する統合関数
 * @param {functions.CallableRequest} request Function呼び出しリクエスト
 * @param {string} functionName 関数名（ログ用）
 * @return {string} 認証されたユーザーID
 */
export function validateAuthAndAppCheck(
  request: functions.CallableRequest,
  functionName: string
): string {
  // App Check検証（ログ記録）
  if (request.app) {
    logger.info("✅ Valid App Check token received", {
      appId: request.app.appId,
      function: functionName,
    });
  } else {
    logger.warn("⚠️ No App Check token provided", {
      function: functionName,
      note: "App Check enforcement will be enabled soon",
    });
  }

  // 認証検証
  if (!request.auth?.uid) {
    throw new functions.HttpsError(
      "unauthenticated",
      "ユーザー認証が必要です"
    );
  }

  return request.auth.uid;
}

/**
 * EventID の検証
 * @param {any} data リクエストデータ
 * @return {string} 検証済みEventID
 */
export function validateEventId(data: any): string {
  const { eventId } = data;
  if (!eventId || typeof eventId !== "string") {
    throw new functions.HttpsError(
      "invalid-argument",
      "イベントIDが必要です"
    );
  }
  return eventId;
}

/**
 * ユーザーがイベントにアクセス権限があるかチェック
 * @param {string} eventId イベントID
 * @param {string} userId ユーザーID
 * @return {Promise<boolean>} アクセス権限の有無
 */
export async function validateEventAccess(
  eventId: string,
  userId: string
): Promise<boolean> {
  try {
    const db = admin.firestore();

    // イベント情報を取得
    const eventDoc = await db.doc(`events/${eventId}`).get();
    if (!eventDoc.exists) {
      throw new AIProcessingError(
        "Event not found",
        ErrorCodes.EVENT_NOT_FOUND
      );
    }

    const eventData = eventDoc.data();

    // 幹事かどうかチェック
    const organizerIds = eventData?.organizerId;
    if (Array.isArray(organizerIds) && organizerIds.includes(userId)) {
      return true;
    }
    if (typeof organizerIds === "string" && organizerIds === userId) {
      return true;
    }

    // 参加者かどうかチェック
    const participantDoc = await db
      .collection(`events/${eventId}/participants`)
      .doc(userId)
      .get();

    if (participantDoc.exists) {
      return true;
    }

    throw new AIProcessingError(
      "User does not have access to this event",
      ErrorCodes.UNAUTHORIZED_ACCESS
    );
  } catch (error) {
    logger.error("Event access validation failed:", error);
    if (error instanceof AIProcessingError) {
      throw error;
    }
    throw new AIProcessingError(
      "Failed to validate event access",
      ErrorCodes.INVALID_EVENT_DATA
    );
  }
}

// Zodスキーマ定義
export const executeAIRequestSchema = z.object({
  eventId: z.string().min(1, "Event ID is required"),
});

export const restaurantSearchRequestSchema = z.object({
  eventId: z.string().min(1, "Event ID is required"),
  locationCandidates: z.array(z.object({
    name: z.string(),
    center: z.object({
      lat: z.number(),
      lng: z.number(),
    }),
    radius: z.number(),
    reason: z.string(),
    suitableFor: z.string(),
  })),
  maxResults: z.number().optional().default(10),
});

export const restaurantDetailsRequestSchema = z.object({
  placeIds: z.array(z.string().min(1)),
  fields: z.array(z.string()).optional(),
});

/**
 * リクエストデータをバリデーションする
 * @param {z.ZodSchema} schema バリデーションスキーマ
 * @param {any} data バリデーション対象のデータ
 * @return {any} バリデーション済みデータ
 */
export function validateRequest<T>(schema: z.ZodSchema<T>, data: any): T {
  try {
    return schema.parse(data);
  } catch (error) {
    if (error instanceof z.ZodError) {
      const errorMessages = error.errors.map((err) =>
        `${err.path.join(".")}: ${err.message}`
      ).join(", ");

      throw new functions.HttpsError(
        "invalid-argument",
        `Validation failed: ${errorMessages}`
      );
    }
    throw new functions.HttpsError(
      "invalid-argument",
      "Invalid request data"
    );
  }
}
