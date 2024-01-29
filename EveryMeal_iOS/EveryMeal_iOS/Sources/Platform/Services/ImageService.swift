//
//  ImageService.swift
//  EveryMeal_iOS
//
//  Created by 김하늘 on 1/29/24.
//

import Foundation

import Moya

struct ImageService {
  let provider = MoyaProvider<ImageAPI>()
  
  func getImageURL(fileDomain: ImageType) async throws -> ImageResponse {
    do {
      let response = try await provider.request(.getImageURL(fileDomain))
      let result = try JSONDecoder().decode(EveryMealDefaultResponse<ImageResponse>.self, from: response.data)
      return result.data
    } catch {
      throw error
    }
  }
}
