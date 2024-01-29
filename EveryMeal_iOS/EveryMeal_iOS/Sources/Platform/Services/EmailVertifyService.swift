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
  
  func postEmail(email: String) async throws -> EmailSendResponse {
    do {
      let response = try await provider.request(.postEmail(email))
      let result = try JSONDecoder().decode(EmailSendResponse.self, from: response.data)
      return result
    } catch {
      throw error
    }
  }
  
}
