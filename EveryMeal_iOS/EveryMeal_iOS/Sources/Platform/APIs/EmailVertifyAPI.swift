//
//  EmailVertifyAPI.swift
//  EveryMeal_iOS
//
//  Created by 김하늘 on 1/29/24.
//

import Foundation
import Moya

enum EmailVertifyAPI {
  case checkAlreadySignIn(String)
  case postEmail(String)
  case postVertifyNumber(PostVertifyNumberClient)
}

extension EmailVertifyAPI: TargetType {
  var baseURL: URL {
    return URL(string: URLConstant.baseURL)!
  }
  
  var path: String {
    switch self {
    case .postEmail, .checkAlreadySignIn:
      return URLConstant.email.path
    case .postVertifyNumber:
      return URLConstant.emailVertify.path
    }
  }
  
  var method: Moya.Method {
    switch self {
    case .postEmail:
      return .post
    case .postVertifyNumber, .checkAlreadySignIn:
      return .get
    }
  }
  
  var task: Moya.Task {
    var body: [String: Any] = [:]
    switch self {
    case let .postEmail(email):
      body["email"] = email
      return .requestParameters(parameters: body,
                                encoding: JSONEncoding.default)
    case let .postVertifyNumber(client):
      body["emailAuthToken"] = client.token
      body["emailAuthValue"] = client.vertifyCode
      return .requestParameters(parameters: body,
                                encoding: URLEncoding.default)
    case let .checkAlreadySignIn(email):
      body["email"] = email
      return .requestParameters(parameters: body,
                                encoding: URLEncoding.default)
    }
  }
  
  var headers: [String : String]? {
    return ["Content-type": "application/json"]
  }
}
