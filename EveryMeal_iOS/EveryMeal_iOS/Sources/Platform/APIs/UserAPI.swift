//
//  UserAPI.swift
//  EveryMeal_iOS
//
//  Created by 김하늘 on 1/29/24.
//

import Foundation

import Moya

enum UserAPI {
  case signup(SignupRequest)
}

extension UserAPI: TargetType {
  var baseURL: URL {
    return URL(string: URLConstant.baseURL)!
  }
  
  var path: String {
    switch self {
    case .signup:
      return URLConstant.signup.path
    }
  }
  
  var method: Moya.Method {
    switch self {
    case .signup:
      return .post
    }
  }
  
  var task: Moya.Task {
    var body: [String: Any] = [:]
    switch self {
    case let .signup(client):
      body["nickname"] = client.nickname
      body["emailAuthToken"] = client.emailAuthToken
      body["emailAuthValue"] = client.emailAuthValue
      body["universityIdx"] = client.universityIdx
      body["profileImgKey"] = client.profileImgKey
      
      return .requestParameters(parameters: body,
                                encoding: JSONEncoding.default)
    }
  }
  
  var headers: [String : String]? {
    return ["Content-type": "application/json"]
  }
}
