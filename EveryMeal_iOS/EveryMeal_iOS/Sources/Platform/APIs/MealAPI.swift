//
//  MealAPI.swift
//  EveryMeal_iOS
//
//  Created by 김광록 on 2/14/24.
//

import Foundation
import Moya

enum MealAPI {
  case getUnivStoreList(String, String)
}

extension MealAPI: TargetType {
  var path: String {
    switch self {
    case .getUnivStoreList:
      return "/api/v1/meals/restaurant"
    }
  }
  
  var method: Moya.Method {
    switch self {
    case .getUnivStoreList:
      return .get
    }
  }
  
  var task: Moya.Task {
    switch self {
    case let .getUnivStoreList(universityName, campusName):
      var body = defaultBody
      body["universityName"] = universityName
      body["campusName"] = campusName
      
      return .requestParameters(parameters: body, encoding: URLEncoding.queryString)
    }
  }
  
  
}
