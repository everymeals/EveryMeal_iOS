//
//  GetStoreReviewsRequest.swift
//  EveryMeal_iOS
//
//  Created by 김광록 on 2/16/24.
//

import Foundation

/// 캠퍼스 주변 맛집 리뷰 불러오기 API 요청 파라미터 모델
struct GetStoreReviewsRequest {
  var offset: String?
  var limit: String?
  var order: GetStoreReviewsOrderType
  var group: CampusStoreGroupType?
  var grade: CampusStoreGradeType?
  var campusIdx: String?
}

enum GetStoreReviewsOrderType: String {
  case name
  case distance
  case recommendedCount
  case reviewCount
  case grade
  case registDate
  case reviewMarksCnt
}
