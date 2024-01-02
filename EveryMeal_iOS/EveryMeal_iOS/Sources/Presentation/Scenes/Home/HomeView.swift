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
  case emailVertifyPopup
  case emailVertify(EmailViewType)
}

struct HomeView: View {
  @State private var navigationPath: [HomeStackViewType] = []
  @State private var writeReviewViewTapped: Bool = false
  @State private var topMenuSelected: [Bool] = Array.init(repeating: false, count: 4)
  
  private let viewBottomargin: CGFloat = 24
  private let moreReviewBtnBottomMargin: CGFloat = 13
  
  var body: some View {
    NavigationStack(path: $navigationPath) {
      VStack {
        HomeHeaderView()
        ScrollView(showsIndicators: true) {
          GoToReviewBannerView()
            .padding(.top, 12)
            .padding(.horizontal, 20)
            .onTapGesture {
              // FIXME: 학교 인증한 사용자인지 확인
              let isEmailAuthenticationTrue: Bool = false
              if isEmailAuthenticationTrue {
                self.navigationPath.append(.writeReview)
              } else {
                self.navigationPath.append(.emailVertifyPopup)
              }
            }
          
          TopMenuButtonsView(isSelected: $topMenuSelected)
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
          case .emailVertifyPopup:
            EmailAuthPopupView(goToAuth: {
              navigationPath.append(.emailVertify(.enterEmail) )
            })
          case let .emailVertify(type):
            EmailAuthenticationView(
              viewType: type,
              emailDidSent: {
                navigationPath.append(.emailVertify(.enterAuthNumber))
              }, emailVertifySuccess: {
                navigationPath.append(.emailVertify(.makeProfile))
              }, backButtonTapped: {
                navigationPath.removeLast()
              }, authSuccess: {
                navigationPath.removeAll()
              }
            )
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

extension UINavigationController: UIGestureRecognizerDelegate {
    open override func viewDidLoad() {
        super.viewDidLoad()
        interactivePopGestureRecognizer?.delegate = self
    }
    
    public func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return viewControllers.count > 1
    }
}
