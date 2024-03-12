//
//  ReviewService.swift
//  EveryMeal_iOS
//
//  Created by 김광록 on 2/14/24.
//

import Foundation
import Moya

struct ReviewService {
  let provider = MoyaProvider<ReviewAPI>(session: Session(interceptor: AuthInterceptor.shared))
  
  /// 학식 리뷰 페이징 조회
  func getUnivStoreReviews(model: GetUnivStoreReviewsRequest) async throws -> GetUnivStoreReviewsData? {
    do {
      let response = try await provider.request(.getUnivStoreReviews(model))
      let result = try JSONDecoder().decode(GetUnivStoreReviewsResponse.self, from: response.data)
      return result.data
    } catch {
      throw error
    }
  }
  
  func writeReview(_ model: WriteStoreReviewRequest) async throws -> Int {
    do {
      let response = try await provider.request(.writeStoreReview(model))
      let result = try JSONDecoder().decode(EveryMealDefaultResponse<Int>.self, from: response.data)
      if let reviewIndex = result.data {
        return reviewIndex
      } else {
        throw EverMealErrorType.fail
      }
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
