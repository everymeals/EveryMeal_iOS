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
    var storeEntity: StoreEntity
    var saveReviewSuccess: Bool = false
    var reviewedStoreContent: StoreReviewContent?
    var getReviewIWroteSuccess: Bool?
  }
  
  enum Action {
    case requestImageKeys([Data])
    case setImageConfigs([ImageResponse])
    case saveImages
    case saveImageSuccess(Bool)
    case saveReview(WriteStoreReviewRequest)
    case saveReviewSuccess(Bool)
    case getReviewIWrote
    case setReviewIWrote(StoreReviewContent)
    case getReviewIWroteSuccess(Bool)
  }
  
  func reduce(into state: inout State, action: Action) -> Effect<Action> {
    switch action {
    case let .requestImageKeys(data):
      state.imageDatas = data
      return .run { send in
        var imageConfiges: [ImageResponse] = []
        try await withThrowingTaskGroup(of: ImageResponse?.self) { group in
          for _ in 0..<data.count {
            group.addTask{
              let response = try await reviewClient.getImageConfig()
              switch response {
              case let .success(config):
                return config
              case .failure:
                print("이미지 key 획득 실패")
                return nil
              }
            }
            
            for try await imageConfig in group {
              if let imageConfig = imageConfig {
                imageConfiges.append(imageConfig)
              }
            }
            await send(.setImageConfigs(imageConfiges))
          }
          
        }
      }
    case let .setImageConfigs(values):
      state.imageConfiges = values
      return .none
      
    case .saveImages:
      let imageConfiges = state.imageConfiges
      let imageDatas = state.imageDatas
      return .run { send in
        var allTaskSuccess = Array(repeating: false, count: imageConfiges.count)
        try await withThrowingTaskGroup(of: Bool.self) { group in
          for (index, config) in imageConfiges.enumerated() {
            group.addTask{
              let response = try await signupClient.saveImageToAWS(config.url, imageDatas[index])
              switch response {
              case .success:
                return true
              case .failure:
                return false
              }
            }
            for try await result in group {
              allTaskSuccess[index] = result
            }
            
            await send(.saveImageSuccess(!allTaskSuccess.contains(false)))
            return
          }
        }
      }
    case let .saveImageSuccess(value):
      state.saveImageSuccess = value
      return .none
      
    case .saveReview:
      return .run { send in
        // TODO: 리뷰 저장
        await send(.saveReviewSuccess(true))
      }
      
    case let .saveReviewSuccess(value):
      state.saveReviewSuccess = value
      return .none
      
    case .getReviewIWrote:
      return .run { send in
        let response = try await reviewClient.getStoreReview(.init(index: 0, offset: nil, limit: nil))
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
}
