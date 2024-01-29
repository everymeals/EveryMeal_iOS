//
//  UnivsService.swift
//  EveryMeal_iOS
//
//  Created by 김광록 on 1/17/24.
//

import Foundation
import Moya

struct UnivsService {
  let provider = MoyaProvider<UnivsAPI>()
  
  func fetchUniversities() async throws -> [UnivsEntity] {
    do {
      let response = try await provider.request(.getUniversities)
      let result = try JSONDecoder().decode(UnivsResponseModel.self, from: response.data)
      return result.data
    } catch {
      throw error
    }
  }
  
}
