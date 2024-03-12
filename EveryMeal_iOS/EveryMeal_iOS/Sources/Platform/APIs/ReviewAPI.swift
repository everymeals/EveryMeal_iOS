//
//  ReviewAPI.swift
//  EveryMeal_iOS
//
//  Created by 김하늘 on 2/18/24.
//

import Foundation
import Moya

enum ReviewAPI {
  case writeStoreReview(WriteStoreReviewRequest)
  case getStoreReview(GetStoreReviewRequest)
}

extension ReviewAPI: TargetType {
  var baseURL: URL {
    return URL(string: "http://dev.everymeal.shop:8085")!
  }
  
  var path: String {
    switch self {
    case .writeStoreReview:
      return "/api/v1/reviews/store"
    case let .getStoreReview(model):
      return "/api/v1/stores/\(model.index)/reviews"
    }
  }
  
  var method: Moya.Method {
    switch self {
    case .writeStoreReview:
      return .post
    case .getStoreReview:
      return .get
    }
  }
  
  var task: Moya.Task {
    var body: [String: Any] = [:]
    switch self {
    case let .writeStoreReview(model):
      body["storeIdx"] = model.storeIdx
      body["grade"] = model.grade
      body["content"] = model.content
      body["imageList"] = model.imageList
      return .requestParameters(parameters: body, encoding: JSONEncoding.default)
    case let .getStoreReview(model):
      if let limit = model.limit {
        body["limit"] = limit
      }
      if let offset = model.offset {
        body["offset"] = offset
      }
      return .requestParameters(parameters: body, encoding: URLEncoding.default)
    }
  }
  
  var headers: [String : String]? {
    switch self {
    case .writeStoreReview, .getStoreReview:
      return ["Content-type": "application/json",
              "Authorization": "Bearer \(String(describing: UserDefaultsManager.getString(.accessToken)))"]
    }
  }
}
