//
//  HomeView.swift
//  EveryMeal_iOS
//
//  Created by 김광록 on 2023/07/24.
//

import SwiftUI

struct HomeView: View {
  var body: some View {
    ScrollView(showsIndicators: true) {
      HomeHeaderView()
      HomeTopMenuView()
      HomeViewSeparator()
      HomeTopThreeMealsView()
      HomeViewSeparator()
      HomeTopThreeReviewsView()
    }
  }
}

struct HomeViewSeparator: View {
  var body: some View {
    Rectangle()
      .foregroundColor(.clear)
      .frame(height: 12)
      .background(Color.grey1)
  }
}

struct HomeView_Previews: PreviewProvider {
  static var previews: some View {
    HomeView()
  }
}
