//
//  DefaultImageResponse.swift
//  EveryMeal_iOS
//
//  Created by 김하늘 on 2/12/24.
//

import Foundation

struct DefaultImageResponse: Codable, Comparable {
  let idx: Int
  let profileImageUrl: String?
  let imageKey: String?
  
  static func < (lhs: DefaultImageResponse, rhs: DefaultImageResponse) -> Bool {
    return lhs.idx < rhs.idx
  }
}
