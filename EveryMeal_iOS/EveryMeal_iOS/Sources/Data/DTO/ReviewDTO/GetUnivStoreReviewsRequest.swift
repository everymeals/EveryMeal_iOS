//
//  GetUnivStoreReviewsRequest.swift
//  EveryMeal_iOS
//
//  Created by 김광록 on 2/14/24.
//

import Foundation

struct GetUnivStoreReviewsRequest {
  let cursorIdx: String
  let restaurantIdx: String
  let pageSize: String
  let order: StoreReviewsOrderType?
  let filter: StoreReviewsFilterType?
}

enum StoreReviewsOrderType: String {
  case createdAt
  case like
}

enum StoreReviewsFilterType: String {
  case all
  case today
}
