//
//  MealService.swift
//  EveryMeal_iOS
//
//  Created by 김광록 on 2/14/24.
//

import Foundation
import Moya

struct MealService {
  let provider = MoyaProvider<MealAPI>(session: Session(interceptor: AuthInterceptor.shared))
  
  /// 학교 별 학생 식당 목록 조회
  func getUnivStoreLists(univName: String, campusName: String) async throws -> [UnivStoreList]? {
    do {
      let response = try await provider.request(.getUnivStoreList(univName, campusName))
      let result = try JSONDecoder().decode(GetUnivStoreListResponse.self, from: response.data)
      return result.data
    } catch {
      throw error
    }
  }

}
