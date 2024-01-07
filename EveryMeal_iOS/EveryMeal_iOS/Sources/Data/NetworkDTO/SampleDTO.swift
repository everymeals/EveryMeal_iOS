//
//  SampleDTO.swift
//  EveryMeal_iOS
//
//  Created by 김하늘 on 1/5/24.
//

import Foundation

struct SampleDTO: Codable, Equatable {
  let localDateTime, message: String?
  let data: DataClass?
  
  static func == (lhs: SampleDTO, rhs: SampleDTO) -> Bool {
    return lhs.localDateTime == rhs.localDateTime
  }
}

struct DataClass: Codable {
  let reviewTotalCnt: Int?
  let reviewPagingList: [ReviewPagingList]?
}

struct ReviewPagingList: Codable {
  let reviewIdx: Int?
  let restaurantName, nickName: String?
  let profileImage: String?
  let isTodayReview: Bool?
  let grade: Int?
  let content: String?
  let imageList: [String]?
  let reviewMarksCnt: Int?
  let createdAt: String?
  
  var profileImageURL: URL {
    get {
      guard let url = URL(string: self.profileImage ?? "") else {
        return URL(string: "")!
      }
      return url
    }
    set {
      
    }
  }
}
