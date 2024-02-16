//
//  SplashReducer.swift
//  EveryMeal_iOS
//
//  Created by 김하늘 on 2/2/24.
//

import Foundation

import ComposableArchitecture
import KeychainSwift

struct SplashReducer: Reducer {
  @Dependency(\.signupClient) var signupClient
  
  struct State: Equatable {
    var loginSuccess: Bool? = nil
  }
  
  enum Action {
    case login
    case loginSuccess(Bool)
  }
  
  func reduce(into state: inout State, action: Action) -> Effect<Action> {
    switch action {
    case .login:
      return .run { send in
        let keychain = KeychainSwift()
        if let accessToken = keychain.get(.accessToken) {
          let response = try await signupClient.verifyAccessToken(accessToken)
          switch response {
          case let .success(response):
            await send(.loginSuccess(response))
          case let .failure(error):
            await send(.loginSuccess(false))
            print("failure \(error)")
            return
          }
        } else {
          
        }
        
      }
    case let .loginSuccess(value):
      state.loginSuccess = value
      return .none
    }
  }
}
