//
//  EmailVertifyService.swift
//  EveryMeal_iOS
//
//  Created by 김하늘 on 1/29/24.
//

import Foundation

import Moya

struct EmailVertifyService {
  let provider = MoyaProvider<EmailVertifyAPI>()
  
  func checkSignin(email: String) async throws -> EveryMealDefaultResponse<Bool> {
    do {
      let response = try await provider.request(.checkAlreadySignIn(email))
      let result = try JSONDecoder().decode(EveryMealDefaultResponse<Bool>.self, from: response.data)
      return result
    } catch {
      throw error
    }
  }
  
  func postEmail(email: String) async throws -> EmailSendResponse {
    do {
      let response = try await provider.request(.postEmail(email))
      let result = try JSONDecoder().decode(EmailSendResponse.self, from: response.data)
      return result
    } catch {
      throw error
    }
  }
  
  func postVertifyNumber(client: PostVertifyNumberClient) async throws -> EveryMealDefaultResponse<Bool> {
    do {
      let response = try await provider.request(.postVertifyNumber(client))
      let result = try JSONDecoder().decode(EveryMealDefaultResponse<Bool>.self, from: response.data)
      return result
    } catch {
      throw error
    }
  }
  
}
