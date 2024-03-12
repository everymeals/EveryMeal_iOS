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
  case getCampusStoresWithKeyword(GetCampusStoreKeywordRequest) // 학교 주변 식당 키워드로 조회
}

extension StoreAPI: TargetType {
  
  var path: String {
    switch self {
    case let .getCampusStores(univIndex, _):
      return "/api/v1/stores/campus/\(univIndex)"
    case let .getCampusStoresWithKeyword(request):
      return "/api/v1/stores/\(request.campusIdx)/\(request.keyword)"
    }
  }
  
  var method: Moya.Method {
    switch self {
    case .getCampusStores, .getCampusStoresWithKeyword:
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
      
    case let .getCampusStoresWithKeyword(model):
      var body = self.defaultBody
      body["offset"] = model.offset
      body["limit"] = model.limit
      return .requestParameters(parameters: body, encoding: URLEncoding.queryString)
    }
  }
  
  var headers: [String: String]? {
    // 회원가입(이메일 인증?)하기 전에도 홈 탭 맛집 영역이 보여야 함
    if UserDefaultsManager.getString(.accessToken) == "" {
      return ["Content-type": "application/json"]
    } else {
      return ["Content-type": "application/json", "Authorization": "Bearer \(String(describing: UserDefaultsManager.getString(.accessToken)))"]
    }
  }
  
}

extension StoreAPI {
  var validationType: ValidationType {
      return .successCodes
  }
}
