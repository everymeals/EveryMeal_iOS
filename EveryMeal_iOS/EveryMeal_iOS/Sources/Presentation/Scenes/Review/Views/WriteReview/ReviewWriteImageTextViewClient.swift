//
//  ReviewWriteImageTextViewClient.swift
//  EveryMeal_iOS
//
//  Created by 김하늘 on 2/18/24.
//

import Foundation

import ComposableArchitecture

struct ReviewWriteImageTextViewClient {
  var getImageConfig: (Int) async throws -> Result<[ImageResponse], EverMealErrorType>
  var getStoreReview: (GetStoreReviewRequest) async throws -> Result<StoreReviewData, EverMealErrorType>
  var saveStoreReview: (WriteStoreReviewRequest) async throws -> Result<Int, EverMealErrorType>
}

extension ReviewWriteImageTextViewClient: DependencyKey {
  static var liveValue = Self(
    getImageConfig: { count in
      do {
        let imageConfigResponse = try await ImageService().getImageURL(fileDomain: .store, count: count)
        return .success(imageConfigResponse)
      } catch {
        return .failure(.fail)
      }
    },
    getStoreReview: { model in
      do {
        let response = try await ReviewService().getStoreReview(model)
        if let data = response.data {
          return .success(data)
        } else {
          return .failure(.fail)
        }
      }
    }, 
    saveStoreReview: { requestModel in
      do {
        let writeReviewResponse = try await ReviewService().writeReview(requestModel)
        return .success(writeReviewResponse)
      } catch {
        return .failure(.fail)
      }
    })
}

extension DependencyValues {
  var reviewClient: ReviewWriteImageTextViewClient {
    get { self[ReviewWriteImageTextViewClient.self] }
    set { self[ReviewWriteImageTextViewClient.self] = newValue }
  }
}
