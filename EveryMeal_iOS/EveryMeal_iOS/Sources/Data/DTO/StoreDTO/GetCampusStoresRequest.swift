//
//  GetCampusStoresRequest.swift
//  EveryMeal_iOS
//
//  Created by 김광록 on 2/1/24.
//

import Foundation

/// 대학 주변 맛집 리스트 조회 API 요청 모델
struct GetCampusStoresRequest {
  let offset: String?  // 페이지 번호
  let limit: String?  // 한 페이지에 보여지는 데이터 수
  let order: CampusStoreOrderType
  let group: CampusStoreGroupType?
  let grade: CampusStoreGradeType?
}

enum CampusStoreOrderType: String {
  case name
  case distance
  case recommendedCount
  case reviewCount
  case grade
  case registDate
}

/// 대학 주변 맛집 리스트 조회 API와 맛집 리뷰를 조회하는 데에 쓰이는 타입
enum CampusStoreGroupType: String {
  case all
  case etc
  case recommend
  case restaurant
  case cafe
  case bar
  case korean
  case chinese
  case japanese
  case western
}

/// 대학 주변 맛집 리스트 조회 API와 맛집 리뷰를 조회하는 데에 쓰이는 타입
enum CampusStoreGradeType: String, CaseIterable {
  case one = "1"
  case two = "2"
  case three = "3"
  case four = "4"
  case five = "5"
}
