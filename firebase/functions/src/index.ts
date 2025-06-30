/**
 * Import function triggers from their respective submodules:
 *
 * import {onCall} from "firebase-functions/v2/https";
 * import {onDocumentWritten} from "firebase-functions/v2/firestore";
 *
 * See a full list of supported triggers at https://firebase.google.com/docs/functions
 */
import { initializeApp } from "firebase-admin/app";
import { getFirestore } from "firebase-admin/firestore";
import { onRequest, onCall, HttpsError } from "firebase-functions/v2/https";
import * as logger from "firebase-functions/logger";

// The Cloud Functions for Firebase SDK to create Cloud Functions and triggers.
// The Firebase Admin SDK to access Firestore.

initializeApp();

// Start writing functions
// https://firebase.google.com/docs/functions/typescript

export const helloWorld = onRequest((request, response) => {
    logger.info("Hello logs!", { structuredData: true });
    response.send("Hello from Firebase!");
});

export const deleteEvent = onCall(async (request) => {
  const eventId = request.data.eventId as string | undefined;
  if (!eventId) {
    throw new HttpsError("invalid-argument", "eventId is required");
  }
  const db = getFirestore();
  const doc = db.doc(`events/${eventId}`);
  await db.recursiveDelete(doc);
  logger.info(`Deleted event ${eventId}`);
  return {
    success: true,
  };
});
