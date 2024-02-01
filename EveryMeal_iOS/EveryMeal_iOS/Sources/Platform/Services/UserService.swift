//
//  UserService.swift
//  EveryMeal_iOS
//
//  Created by 김하늘 on 1/29/24.
//

import Foundation

import Moya

struct UserService {
  let provider = MoyaProvider<UserAPI>()
  
  func postSignup(client: SignupRequest) async throws -> SignupResponse {
    do {
      let response = try await provider.request(.signup(client))
      let result = try JSONDecoder().decode(SignupResponse.self, from: response.data)
      return result
    } catch {
      throw error
    }
  }
}
