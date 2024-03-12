//
//  ReviewWriteImageTextViewReducer.swift
//  EveryMeal_iOS
//
//  Created by 김하늘 on 2/18/24.
//

import Foundation

import ComposableArchitecture

struct ReviewWriteImageTextViewReducer: Reducer {
  @Dependency(\.signupClient) var signupClient
  @Dependency(\.reviewClient) var reviewClient
  
  struct State: Equatable {
    var imageConfiges: [ImageResponse] = []
    var imageDatas: [Data] = []
    var saveImageSuccess: Bool = false
    var storeContent: CampusStoreContent
    var reviewedStoreContent: StoreReviewContent?
    var getReviewIWroteSuccess: Bool?
  }
  
  enum Action {
    case requestImageKeys([Data])
    case setImageConfigs([ImageResponse])
    case saveImages
    case saveImageSuccess(Bool)
    case saveReview(WriteStoreReviewRequest)
    case getReviewIWrote(Int)
    case setReviewIWrote(StoreReviewContent)
    case getReviewIWroteSuccess(Bool)
  }
  
  func reduce(into state: inout State, action: Action) -> Effect<Action> {
    switch action {
    case let .requestImageKeys(data):
      state.imageDatas = data
      return .run { send in
        let response = try await reviewClient.getImageConfig(data.count)
        switch response {
        case let .success(config):
          await send(.setImageConfigs(config))
          return
        case .failure:
          print("이미지 key 획득 실패")
          return
        }
      }
    case let .setImageConfigs(values):
      state.imageConfiges = values
      return .none
      
    case .saveImages:
      let state = state
      return .run { send in
        let response = await saveAllImage(state: state)
        await send(.saveImageSuccess(response.filter({ $0 != true }).isEmpty))
        return
      }
    case let .saveImageSuccess(value):
      state.saveImageSuccess = value
      return .none
      
    case let .saveReview(model):
      return .run { send in
        let didSaveReviewSuccess = try await reviewClient.saveStoreReview(model)
        switch didSaveReviewSuccess {
        case let .success(reviewIndex):
          await send(.getReviewIWrote(reviewIndex))
          return
        case .failure:
          print("리뷰 저장 실패")
          return
        }
      }
      
    case let .getReviewIWrote(reviewIndex):
      return .run { send in
        let response = try await reviewClient.getStoreReview(.init(index: reviewIndex, offset: nil, limit: nil))
        switch response {
        case let .success(storeData):
          if let storeContentIWrote = storeData.content?.first(where: { $0.reviewIdx == 0 }) {
            await send(.setReviewIWrote(storeContentIWrote))
          } else {
            await send(.getReviewIWroteSuccess(false))
          }
          return
        case let .failure(error):
          print("error \(error.localizedDescription)")
          return
        }
      }
      
    case let .setReviewIWrote(storeContent):
      state.reviewedStoreContent = storeContent
      return .none
      
    case let .getReviewIWroteSuccess(result):
      state.getReviewIWroteSuccess = result
      return .none
    }
  }
  
  func saveAllImage(state: State) async -> [Bool?] {
    let imageDatas = state.imageDatas
    let imageConfiges = state.imageConfiges
    
    let resultArray = await withTaskGroup(of: Bool?.self) { group in
      for (index, config) in imageConfiges.enumerated() {
        group.addTask {
          try? await self.saveImages(imageData: imageDatas[index], url: config.url)
        }
      }
      
      var result: [Bool?] = []
      for await didSuccess in group {
        result.append(didSuccess)
      }
      return result
    }
    return resultArray
  }
  
  private func saveImages(imageData: Data, url: String) async throws -> Bool {
    do {
      let response = try await signupClient.saveImageToAWS(url, imageData)
      switch response {
      case .success:
        return true
      case .failure:
        return false
      }
    } catch {
      throw error
    }
  }
}
