//
//  ImageResponse.swift
//  EveryMeal_iOS
//
//  Created by 김하늘 on 1/29/24.
//

import Foundation

struct ImageResponse: Codable, Equatable {
  var imageKey: String
  var url: String
  
  static func == (lhs: ImageResponse, rhs: ImageResponse) -> Bool {
    return lhs.imageKey == rhs.imageKey
   }
}
