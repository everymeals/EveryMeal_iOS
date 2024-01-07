//
//  Type.swift
//  EveryMeal_iOS
//
//  Created by 김하늘 on 1/5/24.
//

enum EverMealError: String, Error {
  case invalidURL
  case invalidJSONParameter
  case invalidJSONResponse
  case fail = "failed to something"
}
