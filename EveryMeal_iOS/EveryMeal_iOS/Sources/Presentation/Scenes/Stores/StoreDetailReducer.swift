//
//  StoreDetailReducer.swift
//  EveryMeal_iOS
//
//  Created by 김하늘 on 3/1/24.
//

import Foundation

import ComposableArchitecture
import KeychainSwift

struct StoreDetailReducer: Reducer {
  @Dependency(\.reviewClient) var reviewClient
  
  struct State: Equatable {
    var storeReviewData: StoreReviewData?
    var storeModel: CampusStoreContent
  }
  
  enum Action {
    case getStoreReviewData(page: Int)
    case setStoreReviewData(StoreReviewData)
  }
  
  func reduce(into state: inout State, action: Action) -> Effect<Action> {
    switch action {
    case let .getStoreReviewData(page):
      let storeModel = state.storeModel
      return .run { send in
        let requestModel = GetStoreReviewRequest(index: storeModel.idx, offset: page, limit: 30)
        let response = try await reviewClient.getStoreReview(requestModel)
        switch response {
        case let .success(storeData):
          await send(.setStoreReviewData(storeData))
          return
        case let .failure(error):
          print(error)
          return
        }
      }
    case let .setStoreReviewData(data):
      state.storeReviewData = data
      return .none
    }
  }
}
