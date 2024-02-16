//
//  DefaultProfileImageResponse.swift
//  EveryMeal_iOS
//
//  Created by 김하늘 on 2/12/24.
//

import Foundation

struct DefaultProfileImageResponse: Codable, Comparable {
  let idx: Int
  let profileImageUrl: String
  let imageKey: String
  
  static func < (lhs: DefaultProfileImageResponse, rhs: DefaultProfileImageResponse) -> Bool {
    return lhs.idx < rhs.idx
  }
  
  func toProfileImageEntity() -> ProfileImageEntity {
    let type = ProfileImageType(rawValue: self.idx) ?? .apple
    let url = URL(string: profileImageUrl)!
    return .init(type: type, profileImageUrl: url, imageKey: imageKey)
  }
}
