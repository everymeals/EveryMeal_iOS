//
//  GetStoreReviewResponse.swift
//  EveryMeal_iOS
//
//  Created by 김하늘 on 2/25/24.
//

import Foundation

struct StoreReviewData: Codable, Equatable {
  let content: [StoreReviewContent]?
  let pageable: CampusStorePageable?
  let totalPages: Int?
  let totalElements: Int?
  let last: Bool?
  let size: Int?
  let number: Int?
  let sort: CampusStoreSort?
  let numberOfElements: Int?
  let first: Bool?
  let empty: Bool?
  
  static func == (lhs: StoreReviewData, rhs: StoreReviewData) -> Bool {
    return lhs.numberOfElements == rhs.numberOfElements
  }
}

struct StoreReviewContent: Codable, Equatable, Hashable {
  let reviewIdx: Int?
  let content: String?
  let grade: Double
  let createdAt: String
  let nickName: String
  let profileImageUrl: String
  let recommendedCount: Int
  let images: [String]?
  
  var profileURL: URL? {
    return URL(string: self.profileImageUrl)
  }
  
  var imageURLs: [URL]? {
    return images?.compactMap { URL(string: $0) }
  }
  
  var dateBefore: Int {
    if let createDate = createdAt.toDate() {
      return createDate.beforeDateFrom()
    } else {
      return 0
    }
  }
  
  static func == (lhs: StoreReviewContent, rhs: StoreReviewContent) -> Bool {
    lhs.reviewIdx == rhs.reviewIdx
  }
}
