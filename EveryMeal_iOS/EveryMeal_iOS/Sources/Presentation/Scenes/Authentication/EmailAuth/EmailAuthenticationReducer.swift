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
    var signupEntity: SignupEntity
    
    var isEmailSending = false
    var isVertifyCodeSending = false
    var emailSendSuccess: Bool?
    var emailSentCount: Int = 0
    var vertifyDidSuccess: Bool?
    var saveImageToAWSSuccess: Bool?
    
    var signupSuccess: Bool?
    
    var errorToastWillBeShown: Bool = false
  }
  
  enum Action {
    case sendEmail(String)
    case sendEmailResponse(EmailSendResponse)
    
    case sendVertifyCode(String)
    case sendVertifySuccess
    
    case getImageURL(Data)
    case saveToAWS(ImageResponse, Data)
    case saveToAWSSuccess
    
    case signupButtonDidTappaed(Data, String)
    case signup
    case signupSuccess(SignupResponse)

    case showErrorToast(Bool)
  }
  
  func reduce(into state: inout State, action: Action) -> Effect<Action> {
    switch action {
    case let .sendEmail(email):
      state.isEmailSending = true
      state.signupEntity.email = email
      return .run { send in
        let response = try await signupClient.postEmail(email)
        switch response {
        case let .success(response):
          await send(.sendEmailResponse(response))
          return
        case let .failure(failure):
          print("failure \(failure.rawValue)")
          await send(.showErrorToast(true))
          return
        }
      }
      
    case let .sendEmailResponse(result):
      state.isEmailSending = false
      state.signupEntity.emailAuthToken = result.data?.emailAuthToken
//      state.emailSendSuccess = true
      state.signupEntity.emailSentCount += 1
      return .none
      
    case let .sendVertifyCode(code):
      state.isVertifyCodeSending = true
      state.signupEntity.emailAuthValue = code
      guard let token = state.signupEntity.emailAuthToken else {
        return .send(.showErrorToast(true))
      }
      
      return .run { send in
        let response = try await signupClient.postVertifyNumber(.init(token: token, vertifyCode: code))
        switch response {
        case .success:
          await send(.sendVertifySuccess)
          return
        case let .failure(fail):
          print("failure \(fail.rawValue)")
          await send(.showErrorToast(true))
          return
        }
      }
      
    case .sendVertifySuccess:
      state.vertifyDidSuccess = true
      return .none
      
    case let .showErrorToast(willShow):
      state.isEmailSending = false
      state.errorToastWillBeShown = willShow
      return .none
      
    case let .signupButtonDidTappaed(image, nickname):
      // FIXME: universityIdx 수정
      state.signupEntity.universityIdx = 1
      state.signupEntity.nickname = nickname
      return .send(.getImageURL(image))
      
    case let .getImageURL(image):
      
      return .run { send in
        let response = try await signupClient.getImageConfig()
        switch response {
        case let .success(imageInfo):
          await send(.saveToAWS(imageInfo, image))
          return
        case let .failure(fail):
          print("failure \(fail.rawValue)")
          await send(.showErrorToast(true))
          return
        }
      }
      
    case let .saveToAWS(imageModel, image):
      state.signupEntity.profileImgKey = imageModel.imageKey
      return .run { send in
        let response = try await signupClient.saveImageToAWS(imageModel.url, image)
        switch response {
        case .success:
          await send(.saveToAWSSuccess)
          return
        case let .failure(fail):
          print("failure \(fail.rawValue)")
          await send(.showErrorToast(true))
          return
        }
      }
      
    case .saveToAWSSuccess:
      state.saveImageToAWSSuccess = true
      return .none
      
    case .signup:
      let requestModel = state.signupEntity.toSignupRequest()
      return .run { send in
        let response = try await signupClient.signup(requestModel)
        switch response {
        case let .success(result):
          await send(.signupSuccess(result))
        case let .failure(fail):
          print("failure \(fail.rawValue)")
          await send(.showErrorToast(true))
          return
        }
      }
      
    case let .signupSuccess(resultModel):
      state.signupSuccess = true
      UserManager.shared.accessToken = resultModel.accessToken
      return .none
    }
  }
}

struct EmailAuthEnvironment {
  var mapClient: MapClient
}
