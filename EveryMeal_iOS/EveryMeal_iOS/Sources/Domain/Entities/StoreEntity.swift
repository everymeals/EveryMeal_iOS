//
//  StoreEntity.swift
//  EveryMeal_iOS
//
//  Created by 김광록 on 1/30/24.
//

import Foundation

/// 홈 탭 추천 가게 뷰에 사용되는 모델
struct StoreEntity: Hashable {
  var name: String
  var categoryDetail: String
  var grade: Double  // 평점
  var reviewCount: Int  // 리뷰 수
  var recommendedCount: Int  // 좋아요 수
  var images: [String]?
  var isLiked: Bool
  var description: String?  // 리뷰 내용
}
