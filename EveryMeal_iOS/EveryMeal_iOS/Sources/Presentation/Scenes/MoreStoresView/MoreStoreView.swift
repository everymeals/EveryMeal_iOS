//
//  MoreStoreView.swift
//  EveryMeal_iOS
//
//  Created by 김하늘 on 10/26/23.
//

import SwiftUI

enum MoreViewType: String {
  case recommend = "추천"
  case meal = "밥집"
  case alcohol = "술집"
  case coffee = "카페"
  case best = "맛집"
}

struct MoreStoreView: View {
  var backButtonTapped: () -> Void
  var moreViewType: MoreViewType
  
  var body: some View {
    NavigationView {
      VStack {
        CustomNavigationView(
          title: moreViewType.rawValue,
          leftItem: Image("icon-arrow-left-small-mono"),
          leftItemTapped: {
            backButtonTapped()
          }
        )
        
        ScrollView {
          VStack(spacing: 0) {
            if moreViewType != .best {
              VStack(spacing: 0) {
                HStack {
                  Text(moreViewType == .recommend ? "추천 맛집" : "추천 " + moreViewType.rawValue)
                    .font(.system(size: 18, weight: .bold))
                    .foregroundColor(.black)
                  Spacer()
                }
                .padding(.leading, 20)
                .padding(.top, 16)
                .padding(.bottom, 15)
                
                MealHGridView(didMealTapped: { mealModel in
                  print("가게 상세로 이동")
                })
                .padding(.horizontal, 20)
                
                Separator()
              }
            }
            
            FilterBarView(viewType: .stores)
            
            MealGridView(didMealTapped: { _ in })
              .padding(.top, 20)
            
            Spacer()
          }
        }
      }
      
    }
    .navigationBarHidden(true)
  }
}

struct MoreStoreView_Previews: PreviewProvider {
  static var previews: some View {
    MoreStoreView(backButtonTapped: {
      print("back")
    }, moreViewType: .best)
  }
}

