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
}

extension ReviewAPI: TargetType {
  var baseURL: URL {
    return URL(string: "http://dev.everymeal.shop:8085")!
  }
  
  var path: String {
    switch self {
    case .writeStoreReview:
      return "/api/v1/reviews/store"
    }
  }
  
  var method: Moya.Method {
    switch self {
    case .writeStoreReview:
      return .post
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
    }
  }
  
  var headers: [String : String]? {
    return ["Content-type": "application/json"]
  }
  
}

