//
//  EveryMealDefaultResponse.swift
//  EveryMeal_iOS
//
//  Created by 김하늘 on 1/29/24.
//

import Foundation

struct EveryMealDefaultResponse<T: Decodable>: Decodable {
  let localDateTime, message: String?
  let data: T
}
