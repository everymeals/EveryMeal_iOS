//
//  EmailAuthenticationReducer.swift
//  EveryMeal_iOS
//
//  Created by 김하늘 on 1/7/24.
//

import Foundation

import ComposableArchitecture

struct EmailAuthenticationReducer: Reducer {
  @Dependency(\.emailAuthResponseClient) var emailAuthClient
  
  struct State: Equatable {
    var isEmailSending = false
    var emailToken: String?
    var data: EmailSendResponse?
  }
  
  enum Action {
    case sendEmail(String)
    case sendEmailResponse(EmailSendResponse)
    case removeAllData
  }
  
  func reduce(into state: inout State, action: Action) -> Effect<Action> {
    switch action {
    case let .sendEmail(email):
      state.isEmailSending = true
      return .run { send in
        let response = try await emailAuthClient.postEmail(email)
        switch response {
        case let .success(response):
          await send(.sendEmailResponse(response))
        case .failure(let failure):
          print("failure \(failure.rawValue)")
          return
        }
      }
      
    case let .sendEmailResponse(result):
      state.isEmailSending = false
      state.data = result
      return .none
      
    case .removeAllData:
      state.data = nil
      return .none
    }
  }
}

struct EmailAuthEnvironment {
  var mapClient: MapClient
}
