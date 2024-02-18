//
//  MealAPI.swift
//  EveryMeal_iOS
//
//  Created by 김광록 on 2/14/24.
//

import Foundation
import Moya

enum MealAPI {
  case getUnivStoreList(Int)
}

extension MealAPI: TargetType {
  var path: String {
    switch self {
    case .getUnivStoreList(let univIdx):
      return "/api/v1/meals/restaurant/\(univIdx)"
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
    case .getUnivStoreList:
      return .requestPlain
    }
  }
  
  
}
