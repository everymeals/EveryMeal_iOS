//
//  EmailVertifyAPI.swift
//  EveryMeal_iOS
//
//  Created by 김하늘 on 1/29/24.
//

import Foundation
import Moya

enum EmailVertifyAPI {
  case postEmail(String)
}

extension EmailVertifyAPI: TargetType {
  var baseURL: URL {
    return URL(string: URLConstant.baseURL)!
  }
  
  var path: String {
    switch self {
    case .postEmail:
      return URLConstant.email.path
    }
  }
  
  var method: Moya.Method {
    switch self {
    case .postEmail:
      return .post
    }
  }
  
  var task: Moya.Task {
    switch self {
    case let .postEmail(email):
      return .requestParameters(parameters: ["email": email], encoding: JSONEncoding.default)
    }
  }
  
  var headers: [String : String]? {
    return ["Content-type": "application/json"]
  }
  
}
