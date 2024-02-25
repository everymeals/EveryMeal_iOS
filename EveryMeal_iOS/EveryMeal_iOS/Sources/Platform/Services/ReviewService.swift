//
//  ReviewService.swift
//  EveryMeal_iOS
//
//  Created by 김하늘 on 2/18/24.
//

import Foundation
import Moya

struct ReviewService {
  let provider = MoyaProvider<ReviewAPI>(session: Session(interceptor: AuthInterceptor.shared))
  
  func writeReview(_ model: WriteStoreReviewRequest) async throws -> [DefaultProfileImageResponse]? {
    do {
      let response = try await provider.request(.writeStoreReview(model))
      let result = try JSONDecoder().decode(EveryMealDefaultResponse<[DefaultProfileImageResponse]>.self, from: response.data)
      return result.data
    } catch {
      throw error
    }
  }
  
  func getStoreReview(_ model: GetStoreReviewRequest) async throws -> EveryMealDefaultResponse<StoreReviewData> {
    do {
      let response = try await provider.request(.getStoreReview(model))
      let result = try JSONDecoder().decode(EveryMealDefaultResponse<StoreReviewData>.self, from: response.data)
      return result
    } catch {
      throw error
    }
  }
}
