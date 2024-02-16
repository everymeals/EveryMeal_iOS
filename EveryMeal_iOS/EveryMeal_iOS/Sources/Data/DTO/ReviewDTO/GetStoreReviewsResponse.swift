//
//  GetStoreReviewsResponse.swift
//  EveryMeal_iOS
//
//  Created by 김광록 on 2/16/24.
//

import Foundation

/// 학교 주변 맛집 리뷰 불러오기 API 응답 모델 (홈 탭 하단 리뷰 영역)
struct GetStoreReviewsResponse: Codable {
  let localDateTime, message: String?
  let data: GetStoreReviewsData?
}

struct GetStoreReviewsData: Codable {
  let content: [GetStoreReviewsContent]?
  let pageable: GetStoreReviewsPageable?
  let totalPages, totalElements: Int?
  let last: Bool?
  let size, number: Int?
  let sort: GetStoreReviewsSort?
  let numberOfElements: Int?
  let first, empty: Bool?
}

struct GetStoreReviewsContent: Codable {
  let reviewIdx: Int?
  let content: String?
  let grade: Int?
  let createdAt, formattedCreatedAt, nickName: String?
  let profileImageUrl: String?
  let reviewMarksCnt: Int?
  let images: [String]?
  let storeIdx: Int?
  let storeName: String?
}

struct GetStoreReviewsPageable: Codable {
  let sort: GetStoreReviewsSort?
  let offset, pageNumber, pageSize: Int?
  let paged, unpaged: Bool?
}

struct GetStoreReviewsSort: Codable {
  let empty, sorted, unsorted: Bool?
}

