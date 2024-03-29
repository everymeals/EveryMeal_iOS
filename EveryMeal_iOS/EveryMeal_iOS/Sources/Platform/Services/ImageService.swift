//
//  ImageService.swift
//  EveryMeal_iOS
//
//  Created by 김하늘 on 1/29/24.
//

import Foundation

import Moya

struct ImageService {
  let provider = MoyaProvider<ImageAPI>(session: Session(interceptor: AuthInterceptor.shared))
  
  func getImageURL(fileDomain: ImageType, count: Int) async throws -> [ImageResponse] {
    do {
      let response = try await provider.request(.getImageURL(type: fileDomain, count: count))
      let result = try JSONDecoder().decode(EveryMealDefaultResponse<[ImageResponse]>.self, from: response.data)
      if let data = result.data {
        return data
      } else {
        throw EverMealErrorType.fail
      }
    } catch {
      throw error
    }
  }
  
  func saveImageToAWS(url: URL, image: Data) async throws -> Bool {
    do {
      let response = try await provider.request(.saveImageToAWS(url, image))
      return true
    } catch {
      throw error
    }
  }
}
