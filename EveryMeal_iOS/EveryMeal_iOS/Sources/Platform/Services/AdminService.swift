//
//  AdminService.swift
//  EveryMeal_iOS
//
//  Created by 김하늘 on 2/12/24.
//

import Foundation
import Moya

struct AdminService {
  let provider = MoyaProvider<AdminAPI>(session: Session(interceptor: AuthInterceptor.shared))
  
  func getDefaultImages() async throws -> [DefaultProfileImageResponse]? {
    do {
      let response = try await provider.request(.getDefaultProfileImage)
      let result = try JSONDecoder().decode(EveryMealDefaultResponse<[DefaultProfileImageResponse]>.self, from: response.data)
      return result.data
    } catch {
      throw error
    }
  }
  
}
