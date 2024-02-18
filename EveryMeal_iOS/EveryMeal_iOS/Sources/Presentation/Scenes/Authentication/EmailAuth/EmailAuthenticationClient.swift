//
//  EmailAuthenticationClient.swift
//  EveryMeal_iOS
//
//  Created by 김하늘 on 1/7/24.
//

import Foundation

import ComposableArchitecture

struct SignupClient {
  var checkAlreadySignin: (String) async throws -> Result<Bool, EverMealErrorType>
  var postEmail: (String) async throws -> Result<EmailSendResponse, EverMealErrorType>
  var postVertifyNumber: (PostVertifyNumberClient) async throws -> Result<Bool, EverMealErrorType>
  var getImageConfig: () async throws -> Result<ImageResponse, EverMealErrorType>
  var saveImageToAWS: (String, Data) async throws -> Result<Bool, EverMealErrorType>
  var signup: (SignupRequest) async throws -> Result<SignupResponse, EverMealErrorType>
  var login: (LoginRequest) async throws -> Result<EveryMealDefaultResponse<LoginResponse>, EverMealErrorType>
  var verifyAccessToken: (String) async throws -> Result<Bool, EverMealErrorType>
  var getNewAccessToken: () async throws -> Result<String, EverMealErrorType>
}

struct PostVertifyNumberClient {
  var token: String
  var vertifyCode: String
}

extension SignupClient: DependencyKey {
  static var liveValue = Self(
    checkAlreadySignin: { email in
      do {
        let response = try await EmailVertifyService().checkSignin(email: email)
        if let data = response.data {
          return .success(data)
        } else {
          return .failure(.fail)
        }
      }
    },
    postEmail: { email in
      do {
        let emailPostResponse = try await EmailVertifyService().postEmail(email: email)
        if emailPostResponse.errorCode == nil {
          return .success(emailPostResponse)
        } else {
          return .failure(.fail)
        }
      } catch {
        return .failure(.fail)
      }
    }, 
    postVertifyNumber: { client in
      do {
        let emailVertifyResponse = try await EmailVertifyService().postVertifyNumber(client: client)
        if let data = emailVertifyResponse.data {
          return .success(data)
        } else {
          return .failure(.fail)
        }
      } catch {
        return .failure(.fail)
      }
    }, 
    getImageConfig: {
      do {
        let imageConfigResponse = try await ImageService().getImageURL(fileDomain: .user)
        return .success(imageConfigResponse)
      } catch {
        return .failure(.fail)
      }
    },
    saveImageToAWS: { urlString, image in
      guard let url = URL(string: urlString) else { return .failure(.fail) }
      do {
        let imageConfigResponse = try await ImageService().saveImageToAWS(url: url, image: image)
        return .success(imageConfigResponse)
      } catch {
        return .failure(.fail)
      }
    },
    signup: { client in
      do {
        let signupResponse = try await UserService().postSignup(client: client)
        if let errorCode = signupResponse.errorCode,
           errorCode == ErrorCode.USR0005.rawValue {
          return .failure(.failWithError(.USR0005))
        } else if signupResponse.errorCode == nil,
                  let data = signupResponse.data {
          return .success(data)
        } else {
          return .failure(.fail)
        }
      } catch {
        return .failure(.fail)
      }
      
    },
    login: { client in
      do {
        let loginResponse = try await UserService().postLogin(client: client)
        if loginResponse.errorCode == nil {
          return .success(loginResponse)
        } else {
          return .failure(.fail)
        }
      }
    },
    verifyAccessToken: { token in
      do {
        let response = try await UserService().verifyAccessToken(token)
        if let data = response.data,
           data == true {
          return .success(data)
        } else {
          return .failure(.fail)
        }
      }
    },
    getNewAccessToken: {
      do {
        let response = try await UserService().getAccessToken()
        if let data = response.data {
          return .success(data)
        } else {
          return .failure(.fail)
        }
      }
    }
  )
}

extension DependencyValues {
  var signupClient: SignupClient {
    get { self[SignupClient.self] }
    set { self[SignupClient.self] = newValue }
  }
}
