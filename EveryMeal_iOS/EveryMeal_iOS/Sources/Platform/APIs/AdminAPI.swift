//
//  AdminAPI.swift
//  EveryMeal_iOS
//
//  Created by 김하늘 on 2/12/24.
//

import Foundation
import Moya

enum AdminAPI {
  case getDefaultProfileImage // 유저의 기본 프로필 이미지 정보를 반환합니다.
}

extension AdminAPI: TargetType {
  
  var path: String {
    switch self {
    case .getDefaultProfileImage:
      return "/api/v1/admin/users/default-profile-images"
    }
  }
  
  var method: Moya.Method {
    switch self {
    case .getDefaultProfileImage:
      return .get
    }
  }
  
  var task: Moya.Task {
    switch self {
    case let .getDefaultProfileImage:
      return .requestPlain
    }
  }
  
  var headers: [String: String]? {
    return ["Content-type": "application/json"]
  }
  
}

extension AdminAPI {
  var validationType: ValidationType {
      return .successCodes
  }
}
