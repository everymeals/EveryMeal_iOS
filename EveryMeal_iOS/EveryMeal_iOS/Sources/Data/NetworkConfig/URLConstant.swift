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
  
  static var mode: Mode {
    #if DEBUG
    .test
    #else
    .production
    #endif
  }
  
  // MARK: - BaseURL
  private var baseURL: String {
    switch URLConstant.mode {
    case .production: "http://dev.everymeal.shop:8085" // FIXME: 상용서버 나오면 수정 필요
    case .test: "http://dev.everymeal.shop:8085"
    }
  }
  
  // MARK: - Path
  private var path: String {
    switch self {
    case .email: "/api/v1/users/email"
    case .emailVertify: "/api/v1/users/email/verify"
    }
  }
  
  // MARK: - URL
  var url: String {
    self.baseURL + self.path
  }
}