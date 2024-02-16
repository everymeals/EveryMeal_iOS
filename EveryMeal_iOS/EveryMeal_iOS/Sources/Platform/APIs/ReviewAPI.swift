//
//  ReviewAPI.swift
//  EveryMeal_iOS
//
//  Created by 김광록 on 2/14/24.
//

import Foundation
import Moya

enum ReviewAPI {
  /// 학식 리뷰 페이징 조회
  case getUnivStoreReviews(GetUnivStoreReviewsRequest)
}

extension ReviewAPI: TargetType {
  var path: String {
    switch self {
    case .getUnivStoreReviews:
      return "/api/v1/reviews"
    }
  }
  
  var method: Moya.Method {
    switch self {
    case .getUnivStoreReviews:
      return .get
    }
  }
  
  var task: Moya.Task {
    switch self {
    case let .getUnivStoreReviews(model):
      var body = defaultBody
      body["cursorIdx"] = model.cursorIdx
      body["restaurantIdx"] = model.restaurantIdx
      body["pageSize"] = model.pageSize
      if let order = model.order, let filter = model.filter {
        body["order"] = order
        body["filter"] = filter
      }
      return .requestParameters(parameters: body, encoding: URLEncoding.queryString)
    }
  }
  
  var headers: [String: String]? {
    if UserDefaultsManager.getString(.accessToken) == "" {
      return ["Content-type": "application/json"]
    } else {
      return [
        "Content-type": "application/json",
        "Authorization": "Bearer \(String(describing: UserDefaultsManager.getString(.accessToken)))"
      ]
    }
  }
  
}
