//
//  URLConstant.swift
//  EveryMeal_iOS
//
//  Created by 김하늘 on 1/7/24.
//

import Foundation

enum Mode: String {
  case production
  case test
}

enum URLConstant {
  case email
  case emailVertify
  case image
  case signup
  case login
  case access
  case accessTokenVerify
  
  static var mode: Mode {
    #if DEBUG
    .test
    #else
    .production
    #endif
  }
  
  // MARK: - BaseURL
  static public var baseURL: String {
    switch URLConstant.mode {
    case .production: "http://dev.everymeal.shop:8085" // FIXME: 상용서버 나오면 수정 필요
    case .test: "http://dev.everymeal.shop:8085"
    }
  }
  
  // MARK: - Path
  var path: String {
    switch self {
    case .email: "/api/v1/users/email"
    case .emailVertify: "/api/v1/users/email/verify"
    case .image: "/api/v1/s3/presigned-url"
    case .signup: "/api/v1/users/signup"
    case .login: "/api/v1/users/login"
    case .access: "/api/v1/users/token/access"
    case .accessTokenVerify: "/api/v1/users/token/access/verify"
    }
  }
  
  // MARK: - URL
  var url: String {
    URLConstant.baseURL + self.path
  }
}
