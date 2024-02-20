//
//  MealHGridView.swift
//  EveryMeal_iOS
//
//  Created by 김하늘 on 11/1/23.
//

import SwiftUI

struct MealHGridView: View {
  @State var didMealTapped: (StoreEntity) -> Void
  @State var storeModels: [StoreEntity] = [
    StoreEntity(name: "수아당", categoryDetail: "분식", grade: 3.0, reviewCount: 123, recommendedCount: 24, images: ["fdsafdas", "fdsafdas", "fdsafdas"], isLiked: true, description: "test"),
    StoreEntity(name: "동경산책 성신여대점", categoryDetail: "일식", grade: 4.0, reviewCount: 123, recommendedCount: 24, images: ["fdsfads", "fdsafdas"], isLiked: false, description: "test"),
    StoreEntity(name: "언앨리셰프", categoryDetail: "양식", grade: 2.5, reviewCount: 123, recommendedCount: 24, images: nil, isLiked: false, description: "test")
  ]
  
  let columns = [GridItem(.flexible())]
  
  var body: some View {
    ScrollView(.horizontal, showsIndicators: false) {
      LazyHGrid(rows: columns, spacing: 12) {
        ForEach(storeModels.indices, id: \.self) { index in
          MealHorizontalItemView(storeModel: storeModels[index])
            .onTapGesture {
              didMealTapped(storeModels[index])
            }
        }
      }
    }
  }
}

struct MealHGridView_Previews: PreviewProvider {
  static var previews: some View {
    MealHGridView(
      didMealTapped: { model in
        print("tapped \(model.name)")
      },
      storeModels: [
        Constants.dummyStore,
        Constants.dummyStore,
        StoreEntity(
          name: "동경산책 성신여대점",
          categoryDetail: "일식",
          grade: 4.0,
          reviewCount: 23,
          recommendedCount: 3,
          images: nil,
          isLiked: false,
          description: "dummy"
        )
      ])
    Spacer()
  }
}
