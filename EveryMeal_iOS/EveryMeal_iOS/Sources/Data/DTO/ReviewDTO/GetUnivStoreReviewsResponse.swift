//
//  GetUnivStoreReviewsResponse.swift
//  EveryMeal_iOS
//
//  Created by 김광록 on 2/14/24.
//

import Foundation

/// 학생 식당 리뷰 요청에 대한 응답 데이터를 포함합니다.
///
/// - Parameters:
///   - 🕰️ localDateTime: 응답이 생성된 로컬 날짜와 시간
///   - 💬 message: 응답 메시지
///   - 📦 data: 리뷰에 대한 상세 데이터를 포함하는 `GetUnivStoreReviewsData`
struct GetUnivStoreReviewsResponse: Codable {
  let localDateTime, message: String?
  let data: GetUnivStoreReviewsData?
}

/// 학생 식당 리뷰의 총 개수와 페이지별 리뷰 정보 리스트를 포함합니다.
///
/// - Parameters:
///   - 📊 reviewTotalCnt: 리뷰의 총 개수
///   - 📃 reviewPagingList: 페이지별 리뷰 정보를 담는 `UnivStoreReviewInfo` 배열
struct GetUnivStoreReviewsData: Codable {
  let reviewTotalCnt: Int?
  let reviewPagingList: [UnivStoreReviewInfo]?
}

/// 학생 식당 리뷰들의 개별 정보를 상세하게 포함합니다.
///
/// - Parameters:
///   - 🔢 reviewIdx: 리뷰 고유 식별자
///   - 🏫 restaurantName: 식당 이름
///   - 🧑 nickName: 리뷰 작성자 닉네임
///   - 🖼️ profileImage: 리뷰 작성자 프로필 이미지 URL
///   - 📅 isTodayReview: 리뷰가 오늘 작성되었는지 여부
///   - ⭐ grade: 리뷰 평점
///   - 💬 content: 리뷰 내용
///   - 📸 imageList: 리뷰 이미지 URL 리스트
///   - ❤️ reviewMarksCnt: 리뷰 좋아요 수
///   - 📆 createdAt: 리뷰 작성 시간
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
