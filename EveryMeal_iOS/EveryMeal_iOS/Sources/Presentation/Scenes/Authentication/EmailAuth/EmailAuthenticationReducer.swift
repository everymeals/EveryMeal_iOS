//
//  EmailAuthenticationReducer.swift
//  EveryMeal_iOS
//
//  Created by 김하늘 on 1/7/24.
//

import Foundation

import ComposableArchitecture

struct EmailAuthenticationReducer: Reducer {
  @Dependency(\.signupClient) var signupClient
  
  struct State: Equatable {
    var isEmailSending = false
    var isVertifyCodeSending = false
    var email: String?
    var emailToken: String?
    var data: EmailSendResponse?
    var vertifyResult: Bool?
    
    var errorToastIsShown: Bool?
  }
  
  enum Action {
    case sendEmail(String)
    case sendEmailResponse(EmailSendResponse)
    
    case sendVertifyCode(String, String)
    case sendVertifyResponse(Bool)
    
    case saveImage(Data)
    case getImageURL
    case saveToAWS(Data)
    
    case signup
    case signupResponse(Bool, String)
    
    case showErrorToast
  }
  
  func reduce(into state: inout State, action: Action) -> Effect<Action> {
    switch action {
    case let .sendEmail(email):
      state.isEmailSending = true
      return .run { send in
        let response = try await signupClient.postEmail(email)
        switch response {
        case let .success(response):
          await send(.sendEmailResponse(response))
        case let .failure(failure):
          print("failure \(failure.rawValue)")
          await send(.showErrorToast)
          return
        }
      }
      
    case let .sendEmailResponse(result):
      state.isEmailSending = false
      state.data = result
      return .none
      
    case let .sendVertifyCode(token, code):
      state.isVertifyCodeSending = true
//      let token = state.data?.data?.emailAuthToken ?? ""
      return .run { send in
        let response = try await signupClient.postVertifyNumber(.init(token: token, vertifyCode: code))
        switch response {
        case let .success(result):
          await send(.sendVertifyResponse(result))
        case let .failure(fail):
          print("failure \(fail.rawValue)")
          await send(.showErrorToast)
          return
        }
      }
      
    case let .sendVertifyResponse(result):
      state.isEmailSending = false
      state.vertifyResult = result
      return .none
      
    case .showErrorToast:
      state.errorToastIsShown = true
      return .none
      
    case .getImageURL:
      return .run { send in
        let response = try await signupClient.getImageConfig()
        switch response {
        case .success:
          await send(.signup)
        case let .failure(fail):
          print("failure \(fail.rawValue)")
          await send(.showErrorToast)
          return
        }
      }
      
    case let .saveImage(image)
      
      
      
    case .signupResponse(_, _):
      <#code#>
    }
  }
}

struct EmailAuthEnvironment {
  var mapClient: MapClient
}
