//
//  GetUnivStoreReviewsRequest.swift
//  EveryMeal_iOS
//
//  Created by 김광록 on 2/14/24.
//

import Foundation

/// 특정 대학의 학생 식당의 리뷰를 가져오는 데 사용됩니다.
///
/// - Parameters:
///   - 📍 cursorIdx: 페이징 시작점
///   - 🍴 restaurantIdx: 식당 고유 식별자
///   - 📄 pageSize: 요청당 리뷰 최대 개수
///   - 🔢 order: 리뷰 정렬 순서 (`createdAt`, `like`). 기본값은 `nil`
///   - 🏷️ filter: 리뷰 필터링 타입 (`all`, `today`). 기본값은 `nil`
struct GetUnivStoreReviewsRequest {
  let cursorIdx: String
  let restaurantIdx: String
  let pageSize: String
  let order: StoreReviewsOrderType? = nil
  let filter: StoreReviewsFilterType? = nil
}

enum StoreReviewsOrderType: String {
  case createdAt
  case like
}

enum StoreReviewsFilterType: String {
  case all
  case today
}
