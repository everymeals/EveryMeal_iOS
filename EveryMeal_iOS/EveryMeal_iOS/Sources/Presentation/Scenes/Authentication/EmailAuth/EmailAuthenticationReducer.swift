//
//  EmailAuthenticationReducer.swift
//  EveryMeal_iOS
//
//  Created by 김하늘 on 1/7/24.
//

import Foundation

import ComposableArchitecture
import KeychainSwift

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
    var imageKeyAlreadyExist: Bool?
    
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
    case imageKeyAlreadyExist(Bool)
    
    case signupButtonDidTappaed(SelectedProfileImageModel, String)
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
          print("failure \(failure)")
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
          print("failure \(failure)")
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
          print("failure \(fail)")
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
      
    case let .signupButtonDidTappaed(model, nickname):
      state.signupEntity.campusIdx = UserDefaultsManager.getInt(.univIdx)
      state.signupEntity.nickname = nickname
      if let cameraORLibrarayImage = model.image {
        guard let imageData = cameraORLibrarayImage.jpegData(compressionQuality: 0.8) else {
          return .none
        }
        return .send(.getImageURL(imageData))
      } else if let imageKey = model.imageKey {
        state.signupEntity.profileImgKey = imageKey
        return .send(.imageKeyAlreadyExist(true))
      } else {
        return .none
      }
      
    case let .getImageURL(image):
      
      return .run { send in
        let response = try await signupClient.getImageConfig()
        switch response {
        case let .success(imageInfo):
          await send(.saveToAWS(imageInfo, image))
          return
        case let .failure(fail):
          print("failure \(fail)")
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
          print("failure \(fail)")
          await send(.showToastWithError(.init(isShown: true)))
          return
        }
      }
      
    case .saveToAWSSuccess:
      state.saveImageToAWSSuccess = true
      return .none
      
    case let .imageKeyAlreadyExist(value):
      state.imageKeyAlreadyExist = value
      return .none
      
    case .signup:
      let signinRequestModel = state.signupEntity.toSignupRequest()
      let loginRequestModel = state.signupEntity.toLoginReqeust()
      return .run { send in
        let response = try await signupClient.signup(signinRequestModel)
        switch response {
        case let .success(response):
          let keychain = KeychainSwift()
          if let accessToken = response.accessToken,
             let refreshToken = keychain.get(.refreshToken) {
            keychain.set(accessToken, forKey: .accessToken)
            UserDefaultsManager.setValue(.accessToken, value: accessToken)
            UserDefaultsManager.setValue(.refreshToken, value: refreshToken)
          }
          await send(.login(loginRequestModel))
          return
        case let .failure(fail):
          if fail == EverMealErrorType.failWithError(.USR0005) {
            print("failure \(fail)")
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
          if let data = result.data {
            await send(.loginSucccess(data))
          } else {
            await send(.showToastWithError(.init(isShown: true)))
          }
          return
        case let .failure(fail):
          UserDefaultsManager.setValue(.accessToken, value: nil)
          print("failure \(fail)")
          await send(.showToastWithError(.init(isShown: true)))
          return
        }
      }
      
    case let .loginSucccess(resultModel):
      state.loginSuccess = true
      UserDefaultsManager.setValue(.accessToken, value: resultModel.accessToken)
//      UserDefaultsManager.setValue(.emailAuthToken, value: state.signupEntity.emailAuthToken)
//      UserDefaultsManager.setValue(.emailAuthValue, value: state.signupEntity.emailAuthValue)
      return .none
    }
  }
}
