//
//  GetUnivStoreReviewsResponse.swift
//  EveryMeal_iOS
//
//  Created by 김광록 on 2/14/24.
//

import Foundation

// MARK: - 학식 리뷰 응답 데이터 모델

struct GetUnivStoreReviewsResponse: Codable {
  let localDateTime, message: String?
  let data: GetUnivStoreReviewsData?
}

// MARK: - GetUnivStoreReviewsData

struct GetUnivStoreReviewsData: Codable {
  let reviewTotalCnt: Int?
  let reviewPagingList: [UnivStoreReviewInfo]?
}

// MARK: - ReviewPagingList

struct UnivStoreReviewInfo: Codable {
  let reviewIdx: Int?
  let restaurantName, nickName: String?
  let profileImage: String?
  let isTodayReview: Bool?
  let grade: Int?
  let content: String?
  let imageList: [String]?
  let reviewMarksCnt: Int?
  let createdAt: String?
}
