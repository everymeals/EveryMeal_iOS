//
//  WriteStoreReviewRequest.swift
//  EveryMeal_iOS
//
//  Created by 김하늘 on 2/18/24.
//

import Foundation

struct WriteStoreReviewRequest {
  let storeIdx: Int
  let grade: Double?
  let content: String?
  let imageList: [String]
}
