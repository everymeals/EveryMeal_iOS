//
//  DietCell.swift
//  EveryMeal_iOS
//
//  Created by 김광록 on 2/12/24.
//

import SwiftUI

enum MealTimeType {
  case breakfast, lunch, dinner
  
  var title: String {
    switch self {
    case .breakfast: "아침"
    case .lunch: "점심"
    case .dinner: "저녁"
    }
  }
  
  var image: String {
    switch self {
    case .breakfast: "morning"
    case .lunch: "lunch"
    case .dinner: "dinner"
    }
  }
}

struct DietCell: View {
  var mealTime: MealTimeType = .breakfast
  var menuDesc: String = ""
  let noMenu: String = "등록된 메뉴가 없어요"
  
  var body: some View {
    HStack(spacing: 8) {
      VStack {
        Image(mealTime.image)
        Spacer()
      }
      VStack(spacing: 11) {
        HStack {
          Text(mealTime.title)
            .font(.pretendard(size: 14, weight: .semibold))
            .foregroundStyle(Color.grey9)
          
          Spacer()
          
          Text("11:00 ~ 14:30")
            .font(.pretendard(size: 13, weight: .regular))
            .foregroundStyle(Color.grey5)
        }
        
        HStack {
          Text(menuDesc)
            .font(.pretendard(size: 15, weight: .regular))
            .foregroundStyle(menuDesc == noMenu ? Color.grey6 : Color.grey8)
            .lineSpacing(5)
          
          Spacer()
        }
      }
    }
    .padding(.vertical, 14)
    .padding(.horizontal, 20)
  }
}


#Preview {
  UnivMealView()
}
