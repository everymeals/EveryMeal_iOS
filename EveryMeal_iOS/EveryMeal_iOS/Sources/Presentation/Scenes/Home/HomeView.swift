//
//  HomeView.swift
//  EveryMeal_iOS
//
//  Created by 김광록 on 2023/07/24.
//

import SwiftUI
import ComposableArchitecture

enum HomeStackViewType: Hashable {
  case writeReview
  case reviewList
  case moreStoreView(MoreStoreViewType)
  case emailVertify(type: EmailViewType, model: SignupEntity)
}

struct HomeView: View {
  @State var navigationPath: [HomeStackViewType] = []
  @State private var topMenuSelected: [Bool] = Array.init(repeating: false, count: 4)
  @Binding var otherViewShowing: Bool
  
  @State private var gotoWriteReview: Bool = false
  @State private var goToEmailAuth = false
  
  private let viewBottomargin: CGFloat = 24
  private let moreReviewBtnBottomMargin: CGFloat = 13
  
  @State var campusStores: [CampusStoreContent]?
  @State var reviews: [GetStoreReviewsContent]?
  
  var body: some View {
    NavigationStack(path: $navigationPath) {
      VStack(spacing: 0) {
        HomeHeaderView()
        ScrollView(showsIndicators: true) {
          GoToReviewBannerView()
            .padding(.top, 12)
            .padding(.horizontal, 20)
            .onTapGesture {
              let isEmailAuthenticationTrue = !UserDefaultsManager.getString(.accessToken).isEmpty
              if isEmailAuthenticationTrue {
                gotoWriteReview = true
              } else {
                goToEmailAuth = true
              }
            }
            .sheet(isPresented: $goToEmailAuth, content: {
              VStack {
                CustomSheetView(buttonTitle: "인증하러 가기",  content: {
                  EmailAuthPopupView()
                }, buttonAction: {
                  goToEmailAuth.toggle()
                  navigationPath.append(.emailVertify(type: .enterEmail, model: SignupEntity()) )
                })
              }
              .presentationDetents([.height(330)])
              .presentationDragIndicator(.hidden)
            })
            .fullScreenCover(isPresented: $gotoWriteReview) {
              WriteReviewStoreSearchView {
                gotoWriteReview.toggle()
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
          HomeTopThreeMealsView(campusStores: $campusStores)
          MoreRestuarantButton()
            .onTapGesture {
              self.navigationPath.append(.moreStoreView(.best))
            }
          Separator()
          HomeReviewsView(reviews: $reviews)
          MoreReviewButton()
            .padding(.horizontal, 20)
            .padding(.bottom, Constants.tabBarHeight + viewBottomargin - moreReviewBtnBottomMargin)
            .onTapGesture {
              navigationPath.append(.reviewList)
            }
        }
        .navigationDestination(for: HomeStackViewType.self) { stackViewType in
          switch stackViewType {
          case .reviewList:
            MoreReviewsView()
              .toolbar(.hidden, for: .tabBar)
          case let .moreStoreView(viewType):
            MoreStoreView(
              backButtonTapped: { navigationPath.removeLast() },
              moreViewType: viewType
            )
            .toolbar(.hidden, for: .tabBar)
          case let .emailVertify(type, model):
            EmailAuthenticationView(
              store: .init(
                initialState: EmailAuthenticationReducer.State(signupEntity: model),
                reducer: {
                  EmailAuthenticationReducer()
                }),
              viewType: type,
              emailDidSent: { entity in
                if navigationPath.count == 1 {
                  navigationPath.append(.emailVertify(type: .enterAuthNumber, model: entity))
                }
              }, emailVertifySuccess: { entity in
                navigationPath.append(.emailVertify(type: .makeProfile, model: entity))
              }, backButtonTapped: {
                navigationPath.removeLast()
              }, authSuccess: {
                navigationPath.removeAll()
              }
            )
            .toolbar(.hidden, for: .tabBar)
          default:
            MoreReviewsView()
              .toolbar(.hidden, for: .tabBar)
          }
        }
      }
      .onAppear {
        fetchCampusStores()
        fetchReviews()
      }
      .onChange(of: navigationPath) { value in
        otherViewShowing = value.count != 0
      }
      .edgesIgnoringSafeArea(.bottom)
      .navigationBarTitleDisplayMode(.inline)
      .navigationBarHidden(true)
    }
  }
  
  private func fetchCampusStores() {
    let univIdx = UserDefaultsManager.getInt(.univIdx) == 0 ? 1 : UserDefaultsManager.getInt(.univIdx)
    let model = GetCampusStoresRequest(offset: "0", limit: "3", order: .registDate, group: .all, grade: nil)
    Task {
      if let result = try await StoreService().getCampusStores(univIndex: univIdx, requestModel: model) {
        self.campusStores = result.content
      }
    }
  }
  
  private func fetchReviews() {
    let univIdx = UserDefaultsManager.getInt(.univIdx) == 0 ? "1" : "\(UserDefaultsManager.getInt(.univIdx))"
    let model = GetStoreReviewsRequest(offset: "0", limit: "3", order: .name, group: .all, campusIdx: univIdx)
    Task {
      if let result = try await StoreService().getStoresReviews(requestModel: model) {
        self.reviews = result.content
      }
    }
  }
  
}

struct HomeView_Previews: PreviewProvider {
  static var previews: some View {
    @State var otherViewShowing = false
    HomeView(otherViewShowing: $otherViewShowing)
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
