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

/// `UnivStoreList` 구조체는 대학의 가게 목록 정보를 포함합니다.
///
/// - Parameters:
///   - 🏫 universityName: 대학교 이름
///   - 🎓 campusName: 캠퍼스 이름
///   - 🍽 restaurantName: 식당 이름
///   - 📍 address: 식당 주소
///   - 🔢 restaurantIdx: 식당 고유 식별자
struct UnivStoreList: Codable {
  let universityName, campusName, restaurantName, address: String?
  let restaurantIdx: Int?
}
