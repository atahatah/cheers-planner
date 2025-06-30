import axios from "axios";
import * as logger from "firebase-functions/logger";
import { LocationCandidate, Restaurant } from "../types/common";
import { ErrorCodes, PlacesAPIError } from "../utils/errorHandler";
import {
  analyzeReviewsWithGemini,
  extractMenuWithGemini,
} from "./geminiService";

/**
 * 環境変数からGoogle Places APIキーを取得
 * @return {string} APIキー
 */
function getApiKey(): string {
  const key = process.env.GOOGLE_PLACES_API_KEY;
  if (!key) {
    throw new Error(
      "GOOGLE_PLACES_API_KEY is not configured. Please set it in .env file."
    );
  }
  return key;
}

/**
 * 場所候補リストから各場所のレストランを検索
 * @param {LocationCandidate[]} locationCandidates 場所候補リスト
 * @param {number} budgetUpperLimit 予算上限
 * @param {string} eventPurpose イベント目的
 * @param {string[]} keywords 検索キーワード
 * @param {number} maxResults 最大結果数
 * @return {Promise<Object>} 場所別検索結果オブジェクト
 */
export async function searchRestaurantsByLocations(
  locationCandidates: LocationCandidate[],
  budgetUpperLimit: number,
  eventPurpose = "飲み会",
  keywords: string[] = [],
  maxResults = 10
): Promise<{[locationName: string]: Restaurant[]}> {
  const results: {[locationName: string]: Restaurant[]} = {};

  for (const location of locationCandidates) {
    try {
      logger.info(
        `Searching restaurants in ${location.name} with keywords: ` +
        `${keywords.join(", ")}`
      );

      const restaurants = await searchRestaurantsInAreaNew(
        location,
        budgetUpperLimit,
        eventPurpose,
        keywords,
        maxResults
      );

      results[location.name] = restaurants;
      logger.info(
        `Found ${restaurants.length} restaurants in ${location.name}`
      );
    } catch (error) {
      logger.error(`Failed to search restaurants in ${location.name}:`, error);
      results[location.name] = [];
    }
  }

  return results;
}

/**
 * 特定エリアで店舗検索 (Places API New使用)
 * @param {LocationCandidate} location 場所候補
 * @param {number} budgetUpperLimit 予算上限
 * @param {string} eventPurpose イベント目的
 * @param {string[]} keywords 検索キーワード（上位4つ）
 * @param {number} maxResults 最大結果数
 * @return {Promise<Restaurant[]>} 店舗リスト
 */
async function searchRestaurantsInAreaNew(
  location: LocationCandidate,
  budgetUpperLimit: number,
  eventPurpose: string,
  keywords: string[],
  maxResults: number
): Promise<Restaurant[]> {
  try {
    const apiKey = getApiKey();

    // キーワードがある場合はTextSearch、ない場合はNearbySearchを使用
    if (keywords.length > 0) {
      return await searchWithTextQuery(location, keywords, maxResults, apiKey);
    } else {
      return await searchNearbyOnly(location, maxResults, apiKey);
    }
  } catch (error) {
    if (axios.isAxiosError(error)) {
      logger.error("Places API (New) request failed:", {
        status: error.response?.status,
        statusText: error.response?.statusText,
        data: error.response?.data,
        url: error.config?.url,
      });

      if (error.response?.status === 403) {
        throw new PlacesAPIError(
          "Places API (New) access denied. " +
          "Please check API key and billing settings.",
          ErrorCodes.PLACES_API_ERROR,
          error.response.data
        );
      }
    }

    logger.error("Places API (New) search failed:", error);
    throw new PlacesAPIError(
      "Restaurant search failed",
      ErrorCodes.PLACES_API_ERROR,
      error
    );
  }
}

/**
 * テキスト検索でレストランを検索 (places:searchText使用)
 * @param {LocationCandidate} location 検索場所
 * @param {string[]} keywords 検索キーワード
 * @param {number} maxResults 最大結果数
 * @param {string} apiKey Google Places API キー
 * @return {Promise<Restaurant[]>} レストランリスト
 */
async function searchWithTextQuery(
  location: LocationCandidate,
  keywords: string[],
  maxResults: number,
  apiKey: string
): Promise<Restaurant[]> {
  // キーワードと場所名を組み合わせたクエリを作成
  const textQuery = `${keywords.join(" ")} レストラン ${location.name}`;
  logger.info(`Using searchText with query: "${textQuery}"`);

  const requestBody = {
    textQuery: textQuery,
    locationBias: {
      circle: {
        center: {
          latitude: location.center.lat,
          longitude: location.center.lng,
        },
        radius: location.radius || 1000,
      },
    },
    maxResultCount: Math.min(maxResults, 20),
    languageCode: "ja",
    regionCode: "JP",
  };

  const response = await axios.post(
    "https://places.googleapis.com/v1/places:searchText",
    requestBody,
    {
      headers: {
        "Content-Type": "application/json",
        "X-Goog-Api-Key": apiKey,
        "X-Goog-FieldMask": [
          "places.id",
          "places.displayName",
          "places.formattedAddress",
          "places.rating",
          "places.priceLevel",
          "places.location",
          "places.businessStatus",
          "places.types",
          "places.regularOpeningHours",
          "places.userRatingCount",
          "places.photos",
          // 口コミとレビュー
          "places.reviews",
          // 飲み会向け情報
          "places.servesBeer",
          "places.servesWine",
          "places.reservable",
          "places.goodForChildren",

          // 連絡先
          "places.websiteUri",
          "places.internationalPhoneNumber",
          // サービス詳細
          "places.takeout",
          "places.delivery",
          "places.dineIn",
        ].join(","),
      },
      timeout: 10000,
    }
  );

  return processPlacesResponse(response, location.name, maxResults);
}

/**
 * 近くの場所検索のみ (places:searchNearby使用)
 * @param {LocationCandidate} location 検索場所
 * @param {number} maxResults 最大結果数
 * @param {string} apiKey Google Places API キー
 * @return {Promise<Restaurant[]>} レストランリスト
 */
async function searchNearbyOnly(
  location: LocationCandidate,
  maxResults: number,
  apiKey: string
): Promise<Restaurant[]> {
  logger.info(`Using searchNearby for ${location.name}`);

  const requestBody = {
    includedTypes: ["restaurant", "bar", "meal_delivery", "meal_takeaway"],
    locationRestriction: {
      circle: {
        center: {
          latitude: location.center.lat,
          longitude: location.center.lng,
        },
        radius: location.radius || 1000,
      },
    },
    maxResultCount: Math.min(maxResults, 20),
    languageCode: "ja",
    regionCode: "JP",
  };

  const response = await axios.post(
    "https://places.googleapis.com/v1/places:searchNearby",
    requestBody,
    {
      headers: {
        "Content-Type": "application/json",
        "X-Goog-Api-Key": apiKey,
        "X-Goog-FieldMask": [
          "places.id",
          "places.displayName",
          "places.formattedAddress",
          "places.rating",
          "places.priceLevel",
          "places.location",
          "places.businessStatus",
          "places.types",
          "places.regularOpeningHours",
          "places.userRatingCount",
          "places.photos",
          // 口コミとレビュー
          "places.reviews",
          // 飲み会向け情報
          "places.servesBeer",
          "places.servesWine",
          "places.reservable",
          "places.goodForChildren",

          // 連絡先
          "places.websiteUri",
          "places.internationalPhoneNumber",
          // サービス詳細
          "places.takeout",
          "places.delivery",
          "places.dineIn",
        ].join(","),
      },
      timeout: 10000,
    }
  );

  return processPlacesResponse(response, location.name, maxResults);
}

/**
 * Places APIレスポンスを共通処理
 * @param {any} response Places APIレスポンス
 * @param {string} locationName 場所名
 * @param {number} maxResults 最大結果数
 * @return {Promise<Restaurant[]>} レストランリスト
 */
async function processPlacesResponse(
  response: any,
  locationName: string,
  maxResults: number
): Promise<Restaurant[]> {
  if (!response.data || !response.data.places) {
    logger.warn(`No places found for location: ${locationName}`);
    return [];
  }

  const places = response.data.places;
  logger.info(
    `Places API (New) returned ${places.length} places for ${locationName}`
  );

  // Restaurant型への変換処理を並列実行
  const restaurantPromises = places
    .map((place: any) => convertNewApiPlaceToRestaurant(place));

  const resolvedRestaurants = await Promise.all(restaurantPromises);

  const restaurants = resolvedRestaurants
    .filter((restaurant: Restaurant | null): restaurant is Restaurant =>
      restaurant !== null
    )
    .slice(0, maxResults);

  // 評価とレビュー数でソート
  restaurants.sort((a: Restaurant, b: Restaurant) => {
    const scoreA = (a.rating || 0) * Math.log(a.userRatingsTotal || 1);
    const scoreB = (b.rating || 0) * Math.log(b.userRatingsTotal || 1);
    return scoreB - scoreA;
  });

  return restaurants;
}

/**
 * Google Places API (New) のレスポンスを Restaurant 型に変換します。
 * @param {any} place - Places APIからのレスポンスオブジェクト。
 * @return {Promise<Restaurant | null>} 変換されたレストランオブジェクト。
 */
export async function convertNewApiPlaceToRestaurant(
  place: any,
): Promise<Restaurant | null> {
  if (!place) {
    return null;
  }

  const restaurant: Partial<Restaurant> = {
    placeId: place.id,
    name: place.displayName?.text || "",
    formattedAddress: place.formattedAddress || "",
    location: {
      lat: place.location?.latitude || 0,
      lng: place.location?.longitude || 0,
    },
    rating: place.rating || 0,
    userRatingsTotal: place.userRatingCount || 0,
    priceLevel: convertPriceLevelFromNew(place.priceLevel),
    website: place.websiteUri || "",
    phoneNumber: place.internationalPhoneNumber || "",
    types: place.types || [],
  };

  if (place.reviews && place.reviews.length > 0) {
    // レビューコメントを抽出
    const reviewTexts = place.reviews
      .map((r: any) => r.text?.text)
      .filter((text: string | undefined): text is string => !!text);

    // AIでレビューとメニューを並行して分析
    const [analysisResult, menuResult] = await Promise.all([
      analyzeReviewsWithGemini(reviewTexts),
      extractMenuWithGemini(reviewTexts, restaurant.types || []),
    ]);

    restaurant.reviewAnalysis = {
      ...analysisResult,
      totalReviewCount: place.userRatingCount || 0,
    };
    restaurant.menuHighlights = menuResult;
  } else {
    restaurant.reviewAnalysis = {
      goodPoints: [],
      badPoints: [],
      totalReviewCount: place.userRatingCount || 0,
    };
    restaurant.menuHighlights = [];
  }

  return restaurant as Restaurant;
}

/**
 * Places API (New) の価格レベルを従来形式に変換
 * @param {string} newPriceLevel New APIの価格レベル
 * @return {number} 従来形式の価格レベル (0-4)
 */
function convertPriceLevelFromNew(newPriceLevel?: string): number {
  switch (newPriceLevel) {
  case "PRICE_LEVEL_FREE":
    return 0;
  case "PRICE_LEVEL_INEXPENSIVE":
    return 1;
  case "PRICE_LEVEL_MODERATE":
    return 2;
  case "PRICE_LEVEL_EXPENSIVE":
    return 3;
  case "PRICE_LEVEL_VERY_EXPENSIVE":
    return 4;
  default:
    return 0;
  }
}

/**
 * 店舗詳細情報を取得 (Places API New使用)
 * @param {string[]} placeIds 店舗ID配列
 * @param {string[]} fields 取得フィールド
 * @return {Promise<any[]>} 店舗詳細リスト
 */
export async function getRestaurantDetails(
  placeIds: string[],
  fields: string[] = [
    "places.id",
    "places.displayName",
    "places.formattedAddress",
    "places.internationalPhoneNumber",
    "places.websiteUri",
    "places.rating",
    "places.reviews",
    "places.regularOpeningHours",
    "places.photos",
  ]
): Promise<any[]> {
  const apiKey = getApiKey();
  const results: any[] = [];

  for (const placeId of placeIds) {
    try {
      const response = await axios.get(
        `https://places.googleapis.com/v1/places/${placeId}`,
        {
          headers: {
            "Content-Type": "application/json",
            "X-Goog-Api-Key": apiKey,
            "X-Goog-FieldMask": fields.join(","),
          },
          timeout: 10000,
        }
      );

      if (response.data) {
        results.push(response.data);
      }
    } catch (error) {
      logger.error(`Failed to get details for place ${placeId}:`, error);
    }
  }

  return results;
}

/**
 * オブジェクトからundefined値を再帰的に除去
 * @param {any} obj 処理対象のオブジェクト
 * @return {any} undefined値が除去されたオブジェクト
 */
export function removeUndefinedFields(obj: any): any {
  if (obj === null || obj === undefined) {
    return obj;
  }

  if (Array.isArray(obj)) {
    return obj.map(removeUndefinedFields);
  }

  if (typeof obj === "object") {
    const cleaned: any = {};
    for (const [key, value] of Object.entries(obj)) {
      if (value !== undefined) {
        cleaned[key] = removeUndefinedFields(value);
      }
    }
    return cleaned;
  }

  return obj;
}
