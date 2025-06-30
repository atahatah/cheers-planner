import * as FirebaseFirestore from "firebase-admin/firestore";

// 共通型定義
export interface LocationCandidate {
  name: string;
  center: {
    lat: number;
    lng: number;
  };
  radius: number;
  reason: string;
  suitableFor: string;
}

export interface Restaurant {
  placeId: string;
  name: string;
  formattedAddress: string;
  rating: number;
  priceLevel: number;
  vicinity: string;
  location: {
    lat: number;
    lng: number;
  };
  businessStatus?: string;
  types: string[];
  openingHours?: {
    openNow: boolean;
    weekdayText: string[];
  };
  photos?: Photo[];
  userRatingsTotal?: number;
  // 追加フィールド
  menuHighlights?: string[];
  accessInfo?: string;
  // 飲み会向け情報
  drinkingInfo?: {
    servesBeer?: boolean;
    servesWine?: boolean;
    reservable?: boolean;
    goodForGroups?: boolean;
  };
  // レビュー分析結果
  reviewAnalysis?: {
    goodPoints: string[];
    badPoints: string[];
    totalReviewCount: number;
  };
  // 連絡先情報
  website?: string;
  phoneNumber?: string;
}

export interface Photo {
  photoReference: string;
  height: number;
  width: number;
}

export interface RestaurantDetails extends Restaurant {
  formattedPhoneNumber?: string;
  website?: string;
  reviews?: Review[];
}

export interface Review {
  authorName: string;
  rating: number;
  text?: string;
  time: number;
}

// --- Firestore Data Models ---

export interface CandidateDateTime {
  start: FirebaseFirestore.Timestamp;
}

export interface CandidateArea {
  center: FirebaseFirestore.GeoPoint;
  radius: number;
}

export interface Answer {
  question: string;
  answer: string;
}

export interface Event {
  id: string;
  organizerId: string[];
  participantId: string[];
  eventName: string;
  dueDate: FirebaseFirestore.Timestamp;
  minutes: number;
  budgetUpperLimit: number;
  purpose: string;
  fixedQuestion: string[];
  candidateDateTimes?: CandidateDateTime[];
  candidateAreas?: {[key: string]: CandidateArea};
  aiResults?: AIResults;
  createdAt?: FirebaseFirestore.Timestamp;
  updatedAt?: FirebaseFirestore.Timestamp;
}

export interface Participant {
  id: string;
  name: string;
  phoneNumber: string;
  positionOrGrade: string;
  desiredBudget: number;
  desiredDates: FirebaseFirestore.Timestamp[];
  desiredLocations: string[];
  allergiesEtc: string;
  submittedAt: FirebaseFirestore.Timestamp;
  fixedQuestionAnswers?: Answer[];
  customQuestionAnswers?: Answer[];
  createdAt?: FirebaseFirestore.Timestamp;
  updatedAt?: FirebaseFirestore.Timestamp;
}

// Step4用新規型定義
export interface OptimizationInput {
  restaurantSearchResults: {[locationName: string]: Restaurant[]};
  locationCandidates: LocationCandidate[];
  keywords: string[];
  eventData: Event;
  participants: Participant[];
}

export interface ParticipantProfile {
  demographicAnalysis: {
    ageDistribution: string[];
    positionHierarchy: string[];
    relationshipDynamics: string;
  };
  preferenceAnalysis: {
    cuisinePreferences: string[];
    atmospherePreferences: string[];
    budgetSensitivity: string;
    specialRequirements: string[];
  };
  logisticalFactors: {
    transportationMethods: string[];
    accessibilityNeeds: string[];
    timeConstraints: string[];
  };
}

export interface AnalysisCriteria {
  budgetCompatibility: number;
  accessibilityScore: number;
  capacityMatch: number;
  dietaryRestrictions: number;
  atmosphereMatch: number;
  serviceQuality: number;
  menuVariety: number;
  groupSuitability: number;
  timeSlotAvailability: number;
  reservationEase: number;
  weatherCompatibility: number;
  seasonalRelevance: number;
}

export interface RestaurantEvaluation {
  restaurant: Restaurant;
  location: string;
  totalScore: number;
  scores: {
    budget: number;
    access: number;
    atmosphere: number;
    service: number;
    menu: number;
    group: number;
    situation: number;
  };
  appealPoints: string[];
  concerns: string[];
  recommendation: "HIGHLY_RECOMMENDED" | "RECOMMENDED" | "SUITABLE" |
    "CONDITIONAL";
}

export interface OptimizedRestaurantResults {
  locationRankings: {
    [locationName: string]: {
      topRestaurants: RestaurantEvaluation[];
      alternativeOptions: RestaurantEvaluation[];
      locationSummary: string;
    }
  };
  overallRecommendation: {
    bestChoice: {
      location: string;
      restaurant: RestaurantEvaluation;
      reason: string;
    };
    alternatives: Array<{
      location: string;
      restaurant: RestaurantEvaluation;
      scenario: string;
    }>;
  };
  analysisMetadata: {
    participantProfile: ParticipantProfile;
    evaluationCriteria: AnalysisCriteria;
    processingTimestamp: FirebaseFirestore.Timestamp;
    confidenceLevel: number;
  };
}

export interface AIResults {
  locationCandidates: LocationCandidate[];
  restaurantSearchResults: {
    [locationName: string]: Restaurant[];
  };
  keywords?: string[];
  // Step4結果追加
  optimizedResults?: OptimizedRestaurantResults;
  status: "processing" | "location_generated" | "keywords_generated" |
    "restaurants_searched" | "optimization_completed" | "completed" | "error";
  generatedAt: FirebaseFirestore.Timestamp;
  processedBy: string;
  updatedAt?: FirebaseFirestore.Timestamp;
  completedAt?: FirebaseFirestore.Timestamp;
  appCheckVerified?: boolean;
  error?: string;
}
