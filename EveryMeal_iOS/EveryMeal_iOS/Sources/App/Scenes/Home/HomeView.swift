//
//  HomeView.swift
//  EveryMeal_iOS
//
//  Created by 김광록 on 2023/07/24.
//

import SwiftUI

enum HomeStackViewType {
  case writeReview
  case restaurantList
  case reviewList
}

struct HomeView: View {
  @State private var navigationPath: [HomeStackViewType] = []
  var body: some View {
    NavigationStack(path: $navigationPath) {
      VStack {
        HomeHeaderView()
        ScrollView(showsIndicators: true) {
          HomeTopMenuView()
          Separator()
          HomeTopThreeMealsView()
          MoreRestuarantButton()
            .onTapGesture {
              navigationPath.append(.restaurantList)
            }
          Separator()
          HomeReviewsView()
          MoreReviewButton()
            .padding(.horizontal, 20)
            .onTapGesture {
              navigationPath.append(.reviewList)
            }
        }
      }
      .navigationDestination(for: HomeStackViewType.self) { stackViewType in
        switch stackViewType {
        case .restaurantList:
          MoreBestRestaurantView()
        case .reviewList:
          MoreBestRestaurantView()
        default:
          MoreBestRestaurantView()
        }
      }
      .padding(.bottom)
      .navigationBarTitleDisplayMode(.inline)
      .navigationBarHidden(true)
    }
  }
}

struct HomeView_Previews: PreviewProvider {
  static var previews: some View {
    HomeView()
  }
}
