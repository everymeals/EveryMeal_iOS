//
//  GetStoreReviewRequest.swift
//  EveryMeal_iOS
//
//  Created by 김하늘 on 2/25/24.
//

import Foundation

struct GetStoreReviewRequest {
  let index: Int
  let offset: Int? // 페이지 번호
  let limit: Int? // 페이지당 데이터수
}
