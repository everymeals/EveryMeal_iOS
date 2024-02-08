//
//  SplashReducer.swift
//  EveryMeal_iOS
//
//  Created by 김하늘 on 2/2/24.
//

import Foundation

import ComposableArchitecture

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
        let requestModel = LoginRequest(
          emailAuthToken: UserDefaultsManager.getString(.accessToken),
          emailAuthValue: UserDefaultsManager.getString(.refreshToken)
          )
        let response = try await signupClient.login(requestModel)
        switch response {
        case let .success(response):
//          UserManager.shared.accessToken = response.data?.accessToken
          await send(.loginSuccess(response.data?.accessToken != nil))
        case let .failure(error):
          await send(.loginSuccess(false))
          print("failure \(error)")
        return
        }
      }
    case let .loginSuccess(value):
      state.loginSuccess = value
      return .none
    }
  }
}
