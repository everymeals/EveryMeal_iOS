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
    
    var sameNickname: Bool? = nil
    var signinAlready: Bool? = nil
    var isEmailSending = false
    var isVertifyCodeSending = false
    var emailSendSuccess: Bool?
    var emailSentCount: Int = 0
    var vertifyDidSuccess: Bool?
    var saveImageToAWSSuccess: Bool?
    
    var loginSuccess: Bool?
    
    var errorToastWillBeShown = ToastModel(isShown: false, type: nil)
  }
  
  enum Action {
    case checkAlreadySignin(String)
    case setSigninAlready(Bool?)
    case setSameNickname(Bool?)
    
    case sendEmail(String)
    case sendEmailResponse(EmailSendResponse)
    
    case sendVertifyCode(String)
    case sendVertifySuccess
    
    case getImageURL(Data)
    case saveToAWS(ImageResponse, Data)
    case saveToAWSSuccess
    
    case signupButtonDidTappaed(Data, String)
    case signup
    
    case login(LoginRequest)
    case loginSucccess(LoginResponse)

    case showToastWithError(ToastModel)
  }
  
  func reduce(into state: inout State, action: Action) -> Effect<Action> {
    switch action {
    case let .checkAlreadySignin(email):
      return .run { send in
        let response = try await signupClient.checkAlreadySignin(email)
        switch response {
        case let .success(result):
          await send(.setSigninAlready(result))
          return
        case let .failure(failure):
          print("failure \(failure.rawValue)")
          await send(.showToastWithError(.init(isShown: true)))
          return
        }
      }
    case let .setSigninAlready(result):
      state.signinAlready = result
      return .none
      
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
          await send(.showToastWithError(.init(isShown: true)))
          return
        }
      }
      
    case let .sendEmailResponse(result):
      state.isEmailSending = false
      state.signupEntity.emailAuthToken = result.data?.emailAuthToken
      state.signupEntity.emailSentCount += 1
      return .none
      
    case let .sendVertifyCode(code):
      state.isVertifyCodeSending = true
      state.signupEntity.emailAuthValue = code
      guard let token = state.signupEntity.emailAuthToken else {
        return .send(.showToastWithError(.init(isShown: true)))
      }
      
      return .run { send in
        let response = try await signupClient.postVertifyNumber(.init(token: token, vertifyCode: code))
        switch response {
        case .success:
          await send(.sendVertifySuccess)
          return
        case let .failure(fail):
          print("failure \(fail.rawValue)")
          await send(.showToastWithError(.init(isShown: true)))
          return
        }
      }
      
    case .sendVertifySuccess:
      state.vertifyDidSuccess = true
      return .none
      
    case let .showToastWithError(toastModel):
      state.isEmailSending = false
      state.errorToastWillBeShown = toastModel
      state.signinAlready = nil
      return .none
      
    case let .signupButtonDidTappaed(image, nickname):
      state.signupEntity.universityIdx = UserDefaultsManager.getInt(.univIdx)
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
          await send(.showToastWithError(.init(isShown: true)))
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
          await send(.showToastWithError(.init(isShown: true)))
          return
        }
      }
      
    case .saveToAWSSuccess:
      state.saveImageToAWSSuccess = true
      return .none
      
    case .signup:
      let signinRequestModel = state.signupEntity.toSignupRequest()
      let loginRequestModel = state.signupEntity.toLoginReqeust()
      return .run { send in
        let response = try await signupClient.signup(signinRequestModel)
        switch response {
        case .success:
          await send(.login(loginRequestModel))
          return
        case let .failure(fail):
          print("failure \(fail.rawValue)")
          if fail == .signupSameNicknameError {
            await send(.setSameNickname(true))
          } else {
            await send(.showToastWithError(.init(isShown: true)))
          }
          return
        }
      }
      
    case let .setSameNickname(value):
      state.sameNickname = value
      return .none
      
    case let .login(requestModel):
      return .run { send in
        let response = try await signupClient.login(requestModel)
        switch response {
        case let .success(result):
          await send(.loginSucccess(result))
        case let .failure(fail):
          print("failure \(fail.rawValue)")
          await send(.showToastWithError(.init(isShown: true)))
        }
      }
      
    case let .loginSucccess(resultModel):
      state.loginSuccess = true
      UserManager.shared.accessToken = resultModel.accessToken
      UserDefaultsManager.setValue(.emailAuthToken, value: state.signupEntity.emailAuthToken)
      UserDefaultsManager.setValue(.emailAuthValue, value: state.signupEntity.emailAuthValue)
      return .none
    }
  }
}
