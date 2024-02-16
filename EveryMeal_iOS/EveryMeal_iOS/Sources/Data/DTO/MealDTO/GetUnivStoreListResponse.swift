//
//  GetUnivStoreListResponse.swift
//  EveryMeal_iOS
//
//  Created by 김광록 on 2/14/24.
//

import Foundation

struct GetUnivStoreListResponse: Codable {
  let localDateTime, message: String?
  let data: [UnivStoreList]?
}

struct UnivStoreList: Codable {
  let universityName, campusName, restaurantName, address: String?
  let restaurantIdx: Int?
}
