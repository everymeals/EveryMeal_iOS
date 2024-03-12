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
  
  /// 최신순, 인기순, 거리순
  @State var selectedSortOption: SortOption? = .registDate
  
  /// 전체, 밥집, 카페, 술집 - 초기값: '전체'
  @State var selectedFilterCategoryOption: FilterCategoryOption? = .all
  
  /// 밥집 선택한 경우 보여지는 밥집 상세 옵션
  @State var selectedFilterRestaurantDetailOption: RestaurantDetailType? = .restaurant
  
  /// 별점 (grade) - 초기값: 미선택
  @State var selectedFilterGradeOption: CampusStoreGradeType? = nil
  
  // '적용하기' 버튼 눌렀을때 상태 변경하기 위해 기억하고 있을 상태
  @State private var tempSelectedFilterCategoryOption: FilterCategoryOption? = .all
  /// 카테고리 '밥집'을 선택한 경우 보여지는 밥집 상세 옵션
  @State private var tempSelectedFilterRestaurantDetailOption: RestaurantDetailType? = .restaurant
  @State private var tempSelectedFilterGradeOption: CampusStoreGradeType? = nil
  
  @State var isSortOpened = false
  @State var isFilterOpened = false
  
  var body: some View {
    NavigationView {
      VStack {
        navigationBar
        if moreViewType == .best {
          filterBar
        }
        
        if (campusStores ?? []).isEmpty {
          VStack(spacing: 0) {
            if moreViewType != .best {
              filterBar
            }
            noDataView
          }
        } else {
          VStack(spacing: 0) {
            if moreViewType != .best {
              // recommendList  // 1차 개발에서 제외
              filterBar
            }
            storesList
          }
        }
      }
    }
    .navigationBarHidden(true)
    .onAppear {
      initialSettings()
      loadInitialContent()
      print("aa loadInitialContent")   // FIXME: API 여러번 요청되는거 고칠 것
    }
    .onChange(of: selectedSortOption) { _ in
      print("aa 정렬 변경 - \(selectedSortOption?.title)")
      loadNewContent()
    }
    .onChange(of: selectedFilterCategoryOption) { _ in
      print("aa 필터의 카테고리 변경 - \(selectedFilterCategoryOption?.title)")
      loadNewContent()
    }
    .onChange(of: selectedFilterRestaurantDetailOption) { _ in
      print("aa 밥집 선택한 경우 디테일 옵션 변경 - \(selectedFilterRestaurantDetailOption?.title)")
      loadNewContent()
    }
    .onChange(of: selectedFilterGradeOption) { _ in
      print("aa 별점 변경 - \(selectedFilterGradeOption?.rawValue)")
      loadNewContent()
    }
  }
  
  private var navigationBar: some View {
    CustomNavigationView(
      title: moreViewType.rawValue,
      leftItem: Image("icon-arrow-left-small-mono"),
      leftItemTapped: backButtonTapped
    )
  }
  
  private var filterBar: some View {
    FilterBarView(
      moreViewType: moreViewType,
      viewType: .stores,
      selectedSortOption: $selectedSortOption,
      selectedFilterCategoryOption: $selectedFilterCategoryOption,
      selectedFilterGradeOption: $selectedFilterGradeOption,
      sortCompletionHandler: { isSortOpened.toggle() },
      filterCompletionHandler: { isFilterOpened.toggle() },
      categoryCompletionHandler: { isFilterOpened.toggle() },
      gradeCompletionHandler: { isFilterOpened.toggle() },
      categoryCloaseButtonCompletionHandler: {
        selectedFilterCategoryOption = .all
        tempSelectedFilterCategoryOption = .all
      },
      gradeCloaseButtonCompletionHandler: {
        selectedFilterGradeOption = nil
        tempSelectedFilterGradeOption = nil
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
    .sheet(isPresented: $isFilterOpened, onDismiss: resetTempFilters) {
      var height: CGFloat {
        if moreViewType == .meal {
          return 307
        } else if moreViewType == .cafe || moreViewType == .alcohol {
          return 190
        } else {
          if tempSelectedFilterCategoryOption == .restaurant {
            return 401
          } else {
            return 349
          }
        }
      }
      
      VStack(spacing: 0) {
        Color.gray.opacity(0.3)
          .frame(width: 73, height: 6)
          .cornerRadius(30)
          .padding(.bottom, 20)
        
        FilterCategoryOptionView(
          moreViewType: moreViewType,
          selectedCategory: $tempSelectedFilterCategoryOption,
          selectedRestaurantDetail: $tempSelectedFilterRestaurantDetailOption
        )
        
        FilterGradeOptionView(
          moreViewType: moreViewType,
          selectedGrade: $tempSelectedFilterGradeOption
        )
          .padding(.bottom, 20)
        
        HStack {
          Text("적용하기")
            .frame(maxWidth: .infinity)
            .padding()
            .background(.red)
            .font(.pretendard(size: 16, weight: .medium))
            .foregroundColor(Color.white)
            .cornerRadius(12)
        }
        .onTapGesture {
          applyFilters()
          isFilterOpened = false
        }
      }
      .padding(.horizontal, 20)
      .presentationDetents([.height(height)])
    }
  }
  
  private var noDataView: some View {
    VStack(spacing: 0) {
      Spacer()
      VStack(spacing: 8) {
        Image("icon-store-mono")
          .resizable()
          .frame(width: 40, height: 40)
        
        Text("설정한 필터에 맞는 맛집이 없어요")
          .font(.pretendard(size: 15, weight: .medium))
          .foregroundStyle(Color.grey8)
      }
      .padding(.bottom, 180)
      Spacer()
    }
  }
  
  private var recommendList: some View {
    VStack(spacing: 0) {
      HStack {
        Text(moreViewType == .recommend ? "추천 맛집" : "추천 " + moreViewType.rawValue)
          .font(.pretendard(size: 18, weight: .bold))
          .foregroundColor(.black)
        Spacer()
      }
      .padding(.leading, 20)
      .padding(.top, 16)
      .padding(.bottom, 15)
      
      MealHGridView(didMealTapped: { mealModel in
        print("가게 상세로 이동")
      })
      .padding(.horizontal, 18)
      
      Separator()
        .padding(.bottom, 10)
    }
  }
  
  private var storesList: some View {
    ScrollView {
      VStack(spacing: 0) {
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
  
  private func initialSettings() {
    UITabBar.appearance().isHidden = true
    selectedSortOption = moreViewType == .best ? .registDate : .popularity
    var group: FilterCategoryOption {
      switch moreViewType {
      case .recommend: return .all
      case .meal: return .restaurant
      case .alcohol: return .bar
      case .cafe: return .cafe
      case .best: return .all
      }
    }
    selectedFilterCategoryOption = group
    tempSelectedFilterCategoryOption = group
  }
  
  private func loadInitialContent() {
    let univIdx = UserDefaultsManager.getInt(.univIdx) == 0 ? 1 : UserDefaultsManager.getInt(.univIdx)
    
    let model = GetCampusStoresRequest(
      offset: "0",
      limit: "15",
      order: selectedSortOption?.toOrderType ?? .registDate,
      group: selectedFilterCategoryOption?.toCategoryType,
      grade: nil
    )
    
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
  
  private func loadMoreContent() {
    guard !isLoading, !isLastPage else { return }
    isLoading = true
    let univIdx = UserDefaultsManager.getInt(.univIdx) == 0 ? 1 : UserDefaultsManager.getInt(.univIdx)
    let nextPage = currentPage + 1
    
    let model = GetCampusStoresRequest(
      offset: "\(nextPage)",
      limit: "15",
      order: selectedSortOption?.toOrderType ?? .registDate,
      group: selectedFilterCategoryOption?.toCategoryType,
      grade: selectedFilterGradeOption
    )
    
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
  
  /// 정렬 또는 필터를 선택하고 다시 데이터를 받아올 때 사용
  private func loadNewContent() {
    isLoading = true
    campusStores = nil // 기존 목록을 초기화
    currentPage = 0 // 페이지 번호 초기화
    let univIdx = UserDefaultsManager.getInt(.univIdx) == 0 ? 1 : UserDefaultsManager.getInt(.univIdx)
    let model = GetCampusStoresRequest(
      offset: "\(currentPage)",
      limit: "15",
      order: selectedSortOption?.toOrderType ?? .registDate,
      group: selectedFilterCategoryOption?.toCategoryType,
      grade: selectedFilterGradeOption
    )
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
  
  private func applyFilters() {
    selectedFilterCategoryOption = tempSelectedFilterCategoryOption
    selectedFilterRestaurantDetailOption = tempSelectedFilterRestaurantDetailOption
    selectedFilterGradeOption = tempSelectedFilterGradeOption
  }
  
  /// 바텀 시트가 표시될 때 임시 필터 상태를 초기화하는 메서드
  private func resetTempFilters() {
    tempSelectedFilterCategoryOption = selectedFilterCategoryOption
    tempSelectedFilterRestaurantDetailOption = selectedFilterRestaurantDetailOption
    tempSelectedFilterGradeOption = selectedFilterGradeOption
  }
}

#Preview {
  MoreStoreView(
    backButtonTapped: { print("back") },
    moreViewType: .alcohol
  )
}
