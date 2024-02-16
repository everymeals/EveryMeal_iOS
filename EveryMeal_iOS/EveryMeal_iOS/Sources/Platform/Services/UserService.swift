//
//  UserService.swift
//  EveryMeal_iOS
//
//  Created by 김하늘 on 1/29/24.
//

import Foundation

import Moya
import KeychainSwift

struct UserService {
  let provider = MoyaProvider<UserAPI>(session: Session(interceptor: AuthInterceptor.shared))
  let keychain = KeychainSwift()
  
  func postSignup(client: SignupRequest) async throws -> EveryMealDefaultResponse<SignupResponse> {
    do {
      let response = try await provider.request(.signup(client))
      let result = try JSONDecoder().decode(EveryMealDefaultResponse<SignupResponse>.self, from: response.data)
      do {
        guard let fields = response.response?.allHeaderFields as? [String: String],
              let url = response.request?.url else {
          throw EverMealErrorType.fail
        }
        
        let cookies = HTTPCookie.cookies(withResponseHeaderFields: fields, for: url)
        for cookie in cookies {
          if cookie.name == "refresh-token" {
            let refreshToken = cookie.value
            keychain.set(refreshToken, forKey: .refreshToken)
            break
          }
        }
        return result
      } catch {
        print("Error parsing cookies: \(error)")
        throw error
      }
    } catch {
      throw error
    }
  }
  
  func postLogin(client: LoginRequest) async throws -> EveryMealDefaultResponse<LoginResponse> {
    do {
      let response = try await provider.request(.login(client))
      let result = try JSONDecoder().decode(EveryMealDefaultResponse<LoginResponse>.self, from: response.data)
      return result
    } catch {
      throw error
    }
  }
  
  func verifyAccessToken(_ token: String) async throws -> EveryMealDefaultResponse<Bool> {
    do {
      let response = try await provider.request(.vertifyAccessToken(token))
      let result = try JSONDecoder().decode(EveryMealDefaultResponse<Bool>.self, from: response.data)
      return result
    } catch {
      throw error
    }
  }
}
