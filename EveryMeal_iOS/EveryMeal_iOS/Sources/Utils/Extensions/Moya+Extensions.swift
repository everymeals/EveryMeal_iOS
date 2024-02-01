//
//  Moya+Extensions.swift
//  EveryMeal_iOS
//
//  Created by 김광록 on 1/17/24.
//

import Foundation
import Moya

extension MoyaProvider {
  func request(_ target: Target) async throws -> Response {
    return try await withCheckedThrowingContinuation { continuation in
      self.request(target) { result in
        switch result {
        case .success(let response):
          print("========================================================")
          print("✅ Success Request API: \(target.baseURL)\(target.path)\nResponse: \(self.prettyPrintJSON(data: response.data))")
          print("========================================================")
          continuation.resume(returning: response)
          
        case .failure(let error):
          print("========================================================")
          print("⁉️ Error on: \(target.baseURL)\(target.path)\nError message: \(error.localizedDescription)")
          print("========================================================")
          continuation.resume(throwing: error)
        }
      }
    }
  }
  
  private func prettyPrintJSON(data: Data) -> String {
    do {
      let jsonObject = try JSONSerialization.jsonObject(with: data, options: [])
      let prettyJsonData = try JSONSerialization.data(withJSONObject: jsonObject, options: .prettyPrinted)
      if let prettyPrintedString = String(data: prettyJsonData, encoding: .utf8) {
        return prettyPrintedString
      }
    } catch {
      return "Error: Could not pretty print JSON: \(error.localizedDescription)"
    }
    
    return "Invalid JSON Data"
  }
  
  // TODO: MoyaError가 필요한지 확인만 할 것 (위에 메서드도 error throw 하긴 함)
//  func request(_ target: Target) async -> Result<Response, MoyaError> {
//    await withCheckedContinuation { continuation in
//      self.request(target) { result in
//        continuation.resume(returning: result)
//      }
//    }
//  }
  
}

extension TargetType {
  var baseURL: URL {
#if DEBUG
    return URL(string: "http://dev.everymeal.shop:8085")!
#else
    return URL(string: "http://dev.everymeal.shop:8085")!  // FIXME: 상용 URL 나오면 변경
#endif
  }
  
  var defaultBody: [String: Any] {
    [:]
  }
  
  var headers: [String: String]? {
    [:]
  }
  
}
