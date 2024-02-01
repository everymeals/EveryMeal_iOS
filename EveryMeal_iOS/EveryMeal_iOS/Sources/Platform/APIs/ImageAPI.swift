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
  case saveImageToAWS(URL, Data)
}

extension ImageAPI: TargetType {
  var baseURL: URL {
    switch self {
    case .getImageURL:
      return URL(string: URLConstant.baseURL)!
    case let .saveImageToAWS(url, _):
      return url
    }
  }
  
  var path: String {
    switch self {
    case .getImageURL:
      return URLConstant.image.path
    case .saveImageToAWS:
      return ""
    }
  }
  
  var method: Moya.Method {
    switch self {
    case .getImageURL:
      return .get
    case .saveImageToAWS:
      return .put
    }
  }
  
  var task: Moya.Task {
    var body: [String: Any] = [:]
    switch self {
    case let .getImageURL(type):
      body["fileDomain"] = type.rawValue
      return .requestParameters(parameters: body,
                                encoding: URLEncoding.default)
    case let .saveImageToAWS(_, image):
      return .requestData(image)
    }
  }
  
  var headers: [String : String]? {
    switch self {
    case .getImageURL:
      return ["Content-type": "application/json"]
    case .saveImageToAWS:
      return nil
    }
  }
}

enum ImageType: String {
  case store, meal, user
}
