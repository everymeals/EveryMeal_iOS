//
//  HomeView.swift
//  EveryMeal_iOS
//
//  Created by 김광록 on 2023/07/24.
//

import SwiftUI

enum HomeStackViewType: Hashable {
  case writeReview
  case restaurantList
  case reviewList
  case moreStoreView(MoreStoreViewType)
}

struct HomeView: View {
  @State private var navigationPath: [HomeStackViewType] = []
  @State private var topMenuSelected: [Bool] = Array.init(repeating: false, count: 4)
  
  private let viewBottomargin: CGFloat = 24
  private let moreReviewBtnBottomMargin: CGFloat = 13
  
  var body: some View {
    NavigationStack(path: $navigationPath) {
      VStack {
        HomeHeaderView()
        ScrollView(showsIndicators: true) {
          HomeTopMenuView(isSelected: $topMenuSelected)
            .onChange(of: topMenuSelected) { topMenuValue in
              let index = topMenuValue.enumerated().first(where: { $0.1 == true })?.0
              if let index = index {
                let viewType: MoreStoreViewType = {
                  switch index {
                  case 0: return .recommend
                  case 1: return .meal
                  case 2: return .cafe
                  default: return .alcohol
                  }
                }()
                self.navigationPath.append(.moreStoreView(viewType))
              }
            }
          Separator()
          HomeTopThreeMealsView()
          MoreRestuarantButton()
            .onTapGesture {
              self.navigationPath.append(.moreStoreView(.best))
            }
          Separator()
          HomeReviewsView()
          MoreReviewButton()
            .padding(.horizontal, 20)
            .padding(.bottom, Constants.tabBarHeight + viewBottomargin - moreReviewBtnBottomMargin)
            .onTapGesture {
              navigationPath.append(.reviewList)
            }
        }
        .navigationDestination(for: HomeStackViewType.self) { stackViewType in
          switch stackViewType {
          case .restaurantList:
            MoreBestRestaurantView()
          case .reviewList:
            MoreReviewsView()
          case let .moreStoreView(viewType):
            MoreStoreView(backButtonTapped: {
              navigationPath.removeLast()
            }, moreViewType: viewType)
          default:
            MoreBestRestaurantView()
          }
        }
      }
      .edgesIgnoringSafeArea(.bottom)
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
