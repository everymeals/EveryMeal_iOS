//
//  StoreService.swift
//  EveryMeal_iOS
//
//  Created by 김광록 on 1/31/24.
//

import Foundation
import Moya

struct StoreService {
  let provider = MoyaProvider<StoreAPI>(session: Session(interceptor: AuthInterceptor.shared))
  
  func getCampusStores(univIndex: Int, requestModel: GetCampusStoresRequest) async throws -> CampusStoreData? {
    do {
      let response = try await provider.request(.getCampusStores(univIndex, requestModel))
      let result = try JSONDecoder().decode(GetCampusStoreResponse.self, from: response.data)
      return result.data
    } catch {
      throw error
    }
  }
  
}
