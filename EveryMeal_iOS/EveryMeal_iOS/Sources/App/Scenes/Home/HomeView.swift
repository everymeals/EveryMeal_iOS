//
//  HomeView.swift
//  EveryMeal_iOS
//
//  Created by 김광록 on 2023/07/24.
//

import SwiftUI

struct HomeView: View {
  var body: some View {
    VStack {
      HomeHeaderView()
      ScrollView(showsIndicators: true) {
        HomeTopMenuView()
        Separator()
        HomeTopThreeMealsView()
        Separator()
        HomeReviewsView()
      }
    }
  }
}

struct HomeView_Previews: PreviewProvider {
  static var previews: some View {
    HomeView()
  }
}
