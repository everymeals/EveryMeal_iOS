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
  
  let keychain = KeychainSwift()
  
  struct State: Equatable {
    var loginSuccess: Bool? = nil
  }
  
  enum Action {
    case login
    case loginSuccess(Bool)
    case getNewAccessToken
  }
  
  func reduce(into state: inout State, action: Action) -> Effect<Action> {
    switch action {
    case .login:
      return .run { send in
        if let accessToken = keychain.get(.accessToken) {
          let response = try await signupClient.verifyAccessToken(accessToken)
          switch response {
          case let .success(response):
            if response {
              await send(.loginSuccess(true))
              return
            } else {
              await send(.getNewAccessToken)
              return
            }
          case let .failure(error):
            print("error \(error)")
            await send(.getNewAccessToken)
            return
          }
        } else {
          await send(.loginSuccess(true))
          return
        }
      }
      
    case let .loginSuccess(value):
      state.loginSuccess = value
      return .none
      
    case .getNewAccessToken:
      return .run { send in
        let response = try await signupClient.getNewAccessToken()
        switch response {
        case let .success(token):
          keychain.set(token, forKey: .accessToken)
          UserDefaultsManager.setValue(.accessToken, value: token)
          await send(.loginSuccess(true))
          return
        case .failure:
          await send(.loginSuccess(false))
          return
        }
      }
    }
  }
}
