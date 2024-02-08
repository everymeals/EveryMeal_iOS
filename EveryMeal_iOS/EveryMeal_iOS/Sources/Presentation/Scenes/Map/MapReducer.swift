//
//  MapReducer.swift
//  EveryMeal_iOS
//
//  Created by 김하늘 on 1/5/24.
//

import Foundation

import ComposableArchitecture

struct MapViewReducer: Reducer {
  @Dependency(\.mapResponseClient) var mapClient
  
  struct State: Equatable {
    var isLoading = false
    var data: SampleDTO?
  }
  
  enum Action {
    case fetchData
    case fetchDataResponse(SampleDTO)
    case removeAllData
  }
  
  func reduce(into state: inout State, action: Action) -> Effect<Action> {
    switch action {
    case .fetchData:
      state.isLoading = true
      return .run { send in
        let response = try await mapClient.fetchSample()
        switch response {
        case .success(let success):
          await send(.fetchDataResponse(success))
        case .failure(let failure):
//          print("failure \(failure.rawValue)")
          return
        }
      }
      
    case let .fetchDataResponse(result):
      state.isLoading = false
      state.data = result
      return .none
      
    case .removeAllData:
      state.data = nil
      return .none
    }
  }
}

struct MapEnvironment {
  var mapClient: MapClient
}
