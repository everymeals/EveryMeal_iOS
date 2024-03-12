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

}
