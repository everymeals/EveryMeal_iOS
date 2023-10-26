//
//  MealEntity.swift
//  EveryMeal_iOS
//
//  Created by 김하늘 on 10/26/23.
//

// TODO: 추후 API가 나오면 수정 예정입니다.

struct MealEntity: Hashable {
  var title: String
  var type: MealType
  var description: String
  var score: Double
  var doUserLike: Bool
  var imageURLs: [String]?
  var likesCount: Int
}

enum MealType: String {
  case 분식
  case 일식
  case 한식
  case 양식
  case 중식
}
