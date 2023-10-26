//
//  MoreStoreView.swift
//  EveryMeal_iOS
//
//  Created by 김하늘 on 10/26/23.
//

import SwiftUI

struct MoreStoreView: View {
  var backButtonTapped: () -> Void
  var mealModels: MealEntity
  
  var body: some View {
    NavigationView {
      VStack {
        CustomNavigationView(
          title: "리뷰 작성",
          leftItem: Image("icon-arrow-left-small-mono"),
          leftItemTapped: {
            backButtonTapped()
          }
        )
        
        MealGridView(didMealTapped: { _ in })
          .padding(.top, 20)
        
        Spacer()
      }
    }
    .navigationBarHidden(true)
  }
}

struct MoreStoreView_Previews: PreviewProvider {
  static var previews: some View {
    MoreStoreView(backButtonTapped: {
      print("back")
    }, mealModels: .init(title: "투텍스쳐 투텍스쳐투텍스쳐투텍스쳐투텍스쳐...", type: .양식, description: "fdsfds", score: 4.5, doUserLike: true, likesCount: 30))
  }
}

