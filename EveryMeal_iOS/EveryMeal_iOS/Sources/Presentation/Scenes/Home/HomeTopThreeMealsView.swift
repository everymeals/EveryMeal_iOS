//
//  HomeTopThreeMealsView.swift
//  EveryMeal_iOS
//
//  Created by 김하늘 on 2023/08/08.
//

import SwiftUI

struct HomeTopThreeMealsView: View {
  var body: some View {
    VStack(spacing: 8) {
      HStack(spacing: 0) {
        Text("맛집 모아보기")
          .font(.system(size: 20, weight: .bold))
          .foregroundColor(Color.black)
          .padding(.leading, 20)
          .padding(.top, 24)
        Spacer()
      }
      MealGridView(didMealTapped: { _ in })
      .padding(.top, 20)
    }
  }
}

// FIXME: 추후 파일로 분리 필요
struct MealGridView: View {
  @State var didMealTapped: (MealEntity) -> Void
  @State var mealModels: [MealEntity] = [MealEntity(title: "수아당",
                                            type: .분식,
                                            description: "ss",
                                            score: 3.0,
                                            doUserLike: true,
                                            imageURLs: ["fdsafdas", "fdsafdas", "fdsafdas"],
                                            likesCount: 24),
                                  MealEntity(title: "동경산책 성신여대점",
                                            type: .일식,
                                            description: "ss",
                                            score: 4.0,
                                            doUserLike: false,
                                            imageURLs: ["fdsfads", "fdsafdas"],
                                            likesCount: 32),
                                  MealEntity(title: "언앨리셰프",
                                            type: .양식,
                                            description: "ss",
                                            score: 2.5,
                                            doUserLike: false,
                                            imageURLs: nil,
                                            likesCount: 0)
  ]
  
  let columns = [GridItem(.flexible())]
  
  var body: some View {
    LazyVGrid(columns: columns, spacing: 8) {
      ForEach(mealModels.indices, id: \.self) { index in
        MealVerticalItemView(mealModel: mealModels[index])
          .onTapGesture {
            didMealTapped(mealModels[index])
          }
        Spacer()
      }
    }.padding(.horizontal, 20)
  }
}

struct MoreRestuarantButton: View {
  var body: some View {
    HStack(alignment: .center, spacing: 10) {
      Text("맛집 더 보러 가기")
        .foregroundColor(Color.everyMealRed)
        .padding(.vertical, 13)
        .frame(maxWidth: .infinity)
        .overlay(
          RoundedRectangle(cornerRadius: 12)
            .inset(by: 0.5)
            .stroke(Color.everyMealRed, lineWidth: 1)
        )
    }
    .padding(.bottom, 30)
    .padding(.horizontal, 20)
  }
}

struct HomeTopThreeMealsView_Previews: PreviewProvider {
  static var previews: some View {
    HomeTopThreeMealsView()
  }
}
