//
//  UserAPI.swift
//  EveryMeal_iOS
//
//  Created by 김하늘 on 1/29/24.
//

import Foundation

import Moya
import KeychainSwift

enum UserAPI {
  case signup(SignupRequest)
  case login(LoginRequest)
  case getAccessToken
}

extension UserAPI: TargetType {
  var baseURL: URL {
    return URL(string: URLConstant.baseURL)!
  }
  
  var path: String {
    switch self {
    case .signup:
      return URLConstant.signup.path
    case .login:
      return URLConstant.login.path
    case .getAccessToken:
      return URLConstant.access.path
    }
  }
  
  var method: Moya.Method {
    switch self {
    case .signup, .login:
      return .post
    case .getAccessToken:
      return .get
    }
  }
  
  var task: Moya.Task {
    var body: [String: Any] = [:]
    switch self {
    case let .signup(client):
      body["nickname"] = client.nickname
      body["emailAuthToken"] = client.emailAuthToken
      body["emailAuthValue"] = client.emailAuthValue
      body["campusIdx"] = client.campusIdx
      body["profileImgKey"] = client.profileImgKey
      return .requestParameters(parameters: body,
                                encoding: JSONEncoding.default)
      
    case let .login(client):
      body["emailAuthToken"] = client.emailAuthToken
      body["emailAuthValue"] = client.emailAuthValue
      return .requestParameters(parameters: body,
                                encoding: JSONEncoding.default)
    case .getAccessToken:
      return .requestPlain
    }
    
  
  }
  
  
  var headers: [String : String]? {
    var values: [String: String] = ["Content-type": "application/json"]
    switch self {
    case .login, .signup:
      return values
    case .getAccessToken:
      let keychain = KeychainSwift()
      values["Cookie"] = keychain.get(.refreshToken)
      return values
    }
//    switch self {
//    case .signup:
//      return values
//    case .login:
//      values["Authorization"] = "Bearer \(String(describing: UserManager.shared.accessToken))"
//      return values
//    }
  }
}
