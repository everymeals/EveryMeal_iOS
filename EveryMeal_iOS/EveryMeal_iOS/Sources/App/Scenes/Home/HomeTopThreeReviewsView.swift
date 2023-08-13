//
//  HomeTopThreeReviewsView.swift
//  EveryMeal_iOS
//
//  Created by 김하늘 on 2023/08/08.
//

import SwiftUI

struct HomeTopThreeReviewsView: View {
  var body: some View {
    VStack(alignment: .leading, spacing: 8) {
      Text("리뷰 모아보기")
        .font(.system(size: 20, weight: .bold))
        .foregroundColor(Color.everyMealBlack)
      
      
    }
  }
}

struct HomeTopThreeReviewsView_Previews: PreviewProvider {
  static var previews: some View {
    HomeView()
  }
}
