//
//  UnivsAPI.swift
//  EveryMeal_iOS
//
//  Created by 김광록 on 1/17/24.
//

import Foundation
import Moya

enum UnivsAPI {
  case getUniversities
}

extension UnivsAPI: TargetType {
  var baseURL: URL {
    return URL(string: "http://dev.everymeal.shop:8085")!
  }
  
  var path: String {
    switch self {
    case .getUniversities: 
      return "/api/v1/universities"
    }
  }
  
  var method: Moya.Method {
    switch self {
    case .getUniversities: 
      return .get
    }
  }
  
  var task: Moya.Task {
    return .requestPlain
  }
  
  var headers: [String : String]? {
    return ["Content-type": "application/json"]
  }
  
}
