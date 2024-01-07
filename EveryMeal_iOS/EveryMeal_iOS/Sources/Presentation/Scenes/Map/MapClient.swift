//
//  MapClient.swift
//  EveryMeal_iOS
//
//  Created by 김하늘 on 1/5/24.
//

import Foundation
import ComposableArchitecture

struct MapClient {
  var fetchSample: () async throws -> Result<SampleDTO, EverMealError>
}

extension MapClient: DependencyKey {
  static var liveValue = Self(
    fetchSample: {
      let sampleURL = "http://dev.everymeal.shop:8085/api/v1/reviews?cursorIdx=1&restaurantIdx=1&pageSize=8&order=createdAt&filter=all"
      guard let url = URL(string: sampleURL) else {
        return .failure(.invalidURL)
      }
      
      let (data, _) = try await URLSession.shared.data(from: url)
      let decoder = JSONDecoder()
      if let jsonString = String(data: data, encoding: .utf8) {
        print(jsonString)
      }
      do {
        let decodedData = try decoder.decode(SampleDTO.self, from: data)
        return .success(decodedData)
      } catch {
        return .failure(.invalidJSON)
      }
    }
  )
}

extension DependencyValues {
  var mapResponseClient: MapClient {
    get { self[MapClient.self] }
    set { self[MapClient.self] = newValue }
  }
}
