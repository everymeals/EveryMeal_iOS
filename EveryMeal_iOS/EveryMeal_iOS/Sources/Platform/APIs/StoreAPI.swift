//
//  StoreAPI.swift
//  EveryMeal_iOS
//
//  Created by 김광록 on 1/30/24.
//

import Foundation
import Moya

enum StoreAPI {
  case getCampusStores(Int, GetCampusStoresRequest)  // 학교 주변 식당 조회
}

extension StoreAPI: TargetType {
  
  var path: String {
    switch self {
    case let .getCampusStores(univIndex, _):
      return "/api/v1/stores/campus/\(univIndex)"
    }
  }
  
  var method: Moya.Method {
    switch self {
    case .getCampusStores:
      return .get
    }
  }
  
  var task: Moya.Task {
    switch self {
    case let .getCampusStores(_, model):
      var body = self.defaultBody
      body["offset"] = model.offset ?? ""
      body["limit"] = model.limit ?? ""
      body["order"] = model.order.rawValue
      body["group"] = model.group?.rawValue ?? ""
      body["grade"] = model.grade?.rawValue ?? ""
      
      return .requestParameters(parameters: body, encoding: URLEncoding.queryString)
    }
  }
  
  var headers: [String : String]? {
    return ["Content-type": "application/json"]
  }
  
}
