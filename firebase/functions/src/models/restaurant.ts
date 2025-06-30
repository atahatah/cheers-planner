export interface Restaurant {
  placeId: string;
  name: string;
  formattedAddress: string;
  location: {
    latitude: number;
    longitude: number;
  };
  rating: number;
  userRatingsTotal: number;
  priceLevel: number | null;
  types: string[];
  websiteUri?: string;
  reviewAnalysis?: ReviewAnalysis;
  menuHighlights?: string[];
}

export interface ReviewAnalysis {
  goodPoints: string[];
  badPoints: string[];
  totalReviewCount: number;
}
