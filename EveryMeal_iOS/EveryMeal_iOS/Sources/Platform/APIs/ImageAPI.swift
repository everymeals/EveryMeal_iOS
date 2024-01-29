//
//  ImageAPI.swift
//  EveryMeal_iOS
//
//  Created by 김하늘 on 1/29/24.
//

import Foundation

import Moya

enum ImageAPI {
  case getImageURL(ImageType)
}

extension ImageAPI: TargetType {
  var baseURL: URL {
    return URL(string: URLConstant.baseURL)!
  }
  
  var path: String {
    switch self {
    case .getImageURL:
      return URLConstant.image.path
    }
  }
  
  var method: Moya.Method {
    switch self {
    case .getImageURL:
      return .get
    }
  }
  
  var task: Moya.Task {
    var body: [String: Any] = [:]
    switch self {
    case let .getImageURL(type):
      body["fileDomain"] = type.rawValue
      return .requestParameters(parameters: body,
                                encoding: URLEncoding.default)
    }
  }
  
  var headers: [String : String]? {
    return ["Content-type": "application/json"]
  }
}

enum ImageType: String {
  case store, meal, user
}
