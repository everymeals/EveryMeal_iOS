//
//  Type.swift
//  EveryMeal_iOS
//
//  Created by 김하늘 on 1/5/24.
//

enum EverMealErrorType: String, Error {
  case invalidURL
  case invalidJSON
  case fail = "failed to something"
}
