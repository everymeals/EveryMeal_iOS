//
//  EmailAuthenticationClient.swift
//  EveryMeal_iOS
//
//  Created by 김하늘 on 1/7/24.
//

import Foundation

import ComposableArchitecture

struct EmailAuthenticationClient {
  var postEmail: (String) async throws -> Result<EmailSendResponse, EverMealErrorType>
}

extension EmailAuthenticationClient: DependencyKey {
  static var liveValue = Self(
    postEmail: { email in
      do {
        let parameters: [String: Any] = ["email": email]
        let postData = try JSONSerialization.data(withJSONObject: parameters)
        
        let url = URLConstant.email.url
        guard let url = URL(string: url) else {
          return .failure(.invalidURL)
        }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = postData
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
   
        let (data, _) = try await URLSession.shared.data(for: request)
        let decoder = JSONDecoder()
        if let jsonString = String(data: data, encoding: .utf8) {
          print(jsonString)
        }
        do {
          let decodedData = try decoder.decode(EmailSendResponse.self, from: data)
          return .success(decodedData)
        } catch {
          return .failure(.invalidJSONResponse)
        }
      } catch {
        return .failure(.invalidJSONParameter)
      }
    }
  )
}

extension DependencyValues {
  var emailAuthResponseClient: EmailAuthenticationClient {
    get { self[EmailAuthenticationClient.self] }
    set { self[EmailAuthenticationClient.self] = newValue }
  }
}
