//
//  MealHGridView.swift
//  EveryMeal_iOS
//
//  Created by 김하늘 on 11/1/23.
//

import SwiftUI

struct MealHGridView: View {
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
    ScrollView(.horizontal, showsIndicators: false) {
      LazyHGrid(rows: columns, spacing: 12) {
        ForEach(mealModels.indices, id: \.self) { index in
          MealHorizontalItemView(mealModel: mealModels[index])
            .onTapGesture {
              didMealTapped(mealModels[index])
            }
        }
      }
    }
  }
}

struct MealHGridView_Previews: PreviewProvider {
  static var previews: some View {
    let dummyMealEntity = MealEntity(title: "동경산책 성신여대점",
                                   type: .일식,
                                   description: "ss",
                                   score: 4.0,
                                   doUserLike: false,
                                   imageURLs: ["fdsfads", "fdsafdas"],
                                   likesCount: 3)
    MealHGridView(didMealTapped: { model in
      print("tapped \(model.title)")
      
    }, mealModels: [dummyMealEntity, dummyMealEntity, dummyMealEntity, dummyMealEntity, dummyMealEntity])
    Spacer()
  }
}
