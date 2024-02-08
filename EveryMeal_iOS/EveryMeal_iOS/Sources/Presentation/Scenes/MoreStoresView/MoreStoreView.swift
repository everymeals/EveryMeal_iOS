//
//  MoreStoreView.swift
//  EveryMeal_iOS
//
//  Created by 김하늘 on 10/26/23.
//

import SwiftUI

enum MoreStoreViewType: String, Hashable {
  case recommend = "추천"
  case meal = "밥집"
  case alcohol = "술집"
  case cafe = "카페"
  case best = "맛집"
}

struct MoreStoreView: View {
  var backButtonTapped: () -> Void
  var moreViewType: MoreStoreViewType
  @State var campusStores: [CampusStoreContent]? = []
  @State private var currentPage = 1
  @State private var isLoading = false
  
  var body: some View {
    NavigationView {
      VStack {
        CustomNavigationView(
          title: moreViewType.rawValue,
          leftItem: Image("icon-arrow-left-small-mono"),
          leftItemTapped: backButtonTapped
        )
        
        FilterBarView(viewType: .stores) {
          loadMoreContent()
        }
        
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
            
            MealGridView(campusStores: $campusStores, didMealTapped: { _ in })
            
            Spacer()
          }
        }
      }
    }
    .navigationBarHidden(true)
    .onAppear {
      UITabBar.appearance().isHidden = true
      loadInitialContent()
    }
  }
  
  func loadInitialContent() {
    let univIdx = UserDefaultsManager.getInt(.univIdx) == 0 ? 1 : UserDefaultsManager.getInt(.univIdx)
    let model = GetCampusStoresRequest(offset: "0", limit: "15", order: .name, group: .all, grade: nil)
    
    Task {
      if let result = try await StoreService().getCampusStores(univIndex: univIdx, requestModel: model) {
        campusStores = result.content
      }
    }
  }
  
  // TODO: 무한 스크롤(페이지네이션) 미완성
  func loadMoreContent() {
    guard !isLoading else { return }
    isLoading = true
    let univIdx = UserDefaultsManager.getInt(.univIdx) == 0 ? 1 : UserDefaultsManager.getInt(.univIdx)
    let nextPage = currentPage + 1
    let model = GetCampusStoresRequest(offset: "\(nextPage)", limit: "15", order: .name, group: .all, grade: nil)
    
    Task {
      if let result = try await StoreService().getCampusStores(univIndex: univIdx, requestModel: model) {
        if let newStores = result.content, !newStores.isEmpty {
          campusStores?.append(contentsOf: newStores)
          currentPage += 1
        }
      }
      isLoading = false
    }
  }
  
}

struct ViewOffsetKey: PreferenceKey {
  static var defaultValue: CGFloat = 0
  static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
    value = nextValue()
  }
}

struct MoreStoreView_Previews: PreviewProvider {
  static var previews: some View {
    MoreStoreView(backButtonTapped: {
      print("back")
    }, moreViewType: .best)
  }
}

