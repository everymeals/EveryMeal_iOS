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
  @State private var currentPage = 0
  @State private var isLoading = false
  @State private var isLastPage = false
  @State private var selectedSortOption: SortOption? = .registDate
  
  @State var isSortOpened = false
  @State var isFilterOpened = false

  var body: some View {
    NavigationView {
      VStack {
        CustomNavigationView(
          title: moreViewType.rawValue,
          leftItem: Image("icon-arrow-left-small-mono"),
          leftItemTapped: backButtonTapped
        )
        
        FilterBarView(
          viewType: .stores,
          selectedSortOption: $selectedSortOption,
          sortCompletionHandler: {
            isSortOpened.toggle()
          },
          filterCompletionHandler: {
            isFilterOpened.toggle()
          }
        )
        .sheet(isPresented: $isSortOpened) {
          VStack {
            Color.gray.opacity(0.3)
              .frame(width: 73, height: 6)
              .cornerRadius(30)
            
            ForEach(SortOption.allCases, id: \.self) { option in
              SortOptionView(option: option, isSelected: selectedSortOption == option) { selectedOption in
                print("\(selectedOption.title) 선택됨")
                selectedSortOption = option
                isSortOpened = false
              }
            }
          }
          .presentationDetents([.height(210)])
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
            
            if let campusStores = campusStores, !campusStores.isEmpty {
              GeometryReader { geometry -> Color in
                let maxY = geometry.frame(in: .global).maxY
                let height = UIScreen.main.bounds.height
                if maxY < height * 1.1 { // 스크롤 뷰가 바닥에 가까워지면
                  loadMoreContent()
                }
                return Color.clear
              }
              .frame(height: 20)
            }
            
            Spacer()
          }
        }
      }
    }
    .onChange(of: selectedSortOption) { _ in
      loadNewContent()
    }
    .navigationBarHidden(true)
    .onAppear {
      UITabBar.appearance().isHidden = true
      loadInitialContent()
    }
  }
  
  func loadInitialContent() {
    let univIdx = UserDefaultsManager.getInt(.univIdx) == 0 ? 1 : UserDefaultsManager.getInt(.univIdx)
    let model = GetCampusStoresRequest(offset: "0", limit: "15", order: .registDate, group: .all, grade: nil)
    
    Task {
      if let result = try await StoreService().getCampusStores(univIndex: univIdx, requestModel: model) {
        campusStores = result.content
        
        // 초기 로딩한 페이지가 마지막 페이지인지 검사
        if let totalPages = result.totalPages {
          isLastPage = currentPage >= totalPages
        }
      }
    }
  }
  
  func loadMoreContent() {
    guard !isLoading, !isLastPage else { return }
    isLoading = true
    let univIdx = UserDefaultsManager.getInt(.univIdx) == 0 ? 1 : UserDefaultsManager.getInt(.univIdx)
    let orderType = selectedSortOption?.toOrderType ?? .registDate
    let nextPage = currentPage + 1
    let model = GetCampusStoresRequest(offset: "\(nextPage)", limit: "15", order: orderType, group: .all, grade: nil)
    
    Task {
      if let result = try await StoreService().getCampusStores(univIndex: univIdx, requestModel: model) {
        if let newStores = result.content, !newStores.isEmpty {
          campusStores?.append(contentsOf: newStores)
          currentPage += 1
        }
        // totalPages에 도달했는데도 스크롤이 바닥에 있으면 API를 계속 요청하는 이슈 해결
        isLastPage = result.last ?? isLastPage
      }
      isLoading = false
    }
  }
  
  /// 정렬을 선택하고 다시 데이터를 받아올 때 사용
  func loadNewContent() {
    isLoading = true
    campusStores = nil // 기존 목록을 초기화
    currentPage = 0 // 페이지 번호 초기화
    let univIdx = UserDefaultsManager.getInt(.univIdx) == 0 ? 1 : UserDefaultsManager.getInt(.univIdx)
    let orderType = selectedSortOption?.toOrderType ?? .registDate
    let model = GetCampusStoresRequest(offset: "\(currentPage)", limit: "15", order: orderType, group: .all, grade: nil)

    Task {
      if let result = try await StoreService().getCampusStores(univIndex: univIdx, requestModel: model) {
        campusStores = result.content
        if let totalPages = result.totalPages {
          isLastPage = currentPage >= totalPages
        }
      }
      isLoading = false
    }
  }

}

struct MoreStoreView_Previews: PreviewProvider {
  static var previews: some View {
    MoreStoreView(backButtonTapped: {
      print("back")
    }, moreViewType: .best)
  }
}
