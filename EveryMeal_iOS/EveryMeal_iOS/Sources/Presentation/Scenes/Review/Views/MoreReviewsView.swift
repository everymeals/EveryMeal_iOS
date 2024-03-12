//
//  MoreReviewsView.swift
//  EveryMeal_iOS
//
//  Created by 김광록 on 2023/10/16.
//

import SwiftUI

struct MoreReviewsView: View {
  @Environment(\.dismiss) private var dismiss
  
  @State var reviews: [GetStoreReviewsContent]?
  
  @State private var currentPage = 0
  @State private var isLoading = false
  @State private var isLastPage = false
  
  @State var isSortOpened = false
  @State var isFilterOpened = false
  
  /// 최신순, 인기순, 거리순
  @State private var selectedSortOption: SortOption? = .registDate
  
  /// 전체, 밥집, 카페, 술집 - 초기값: '전체'
  @State var selectedFilterCategoryOption: FilterCategoryOption? = .all
  
  /// 별점 (grade) - 초기값: 미선택
  @State var selectedFilterGradeOption: CampusStoreGradeType? = nil
  
  // '적용하기' 버튼 눌렀을때 상태 변경하기 위해 기억하고 있을 상태
  @State private var tempSelectedFilterCategoryOption: FilterCategoryOption? = .all
  /// 카테고리 '밥집'을 선택한 경우 보여지는 밥집 상세 옵션
  @State private var tempSelectedFilterRestaurantDetailOption: RestaurantDetailType? = .restaurant
  @State private var tempSelectedFilterGradeOption: CampusStoreGradeType? = nil
  
  let columns = [ GridItem(.flexible()) ]
  
  var body: some View {
    VStack {
      filterBar
      
      if (reviews ?? []).isEmpty {
        noDataView
      } else {
        reviewsList
      }
    }
    .navigationTitle("리뷰")
    .navigationBarTitleDisplayMode(.inline)
    .navigationBarBackButtonHidden()
    .toolbar { toolbarItem() }
    .onAppear(perform: loadInitialContent)
    .onChange(of: selectedSortOption) { _ in loadNewContent() }
    .onChange(of: selectedFilterCategoryOption) { _ in loadNewContent() }
    .onChange(of: selectedFilterGradeOption) { _ in loadNewContent() }
  }
  
  private var filterBar: some View {
    FilterBarView(
      viewType: .reviews,
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
      VStack(spacing: 0) {
        Color.gray.opacity(0.3)
          .frame(width: 73, height: 6)
          .cornerRadius(30)
          .padding(.bottom, 20)
        
        FilterCategoryOptionView(
          selectedCategory: $tempSelectedFilterCategoryOption,
          selectedRestaurantDetail: $tempSelectedFilterRestaurantDetailOption
        )
        
        FilterGradeOptionView(selectedGrade: $tempSelectedFilterGradeOption)
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
      .presentationDetents([.height(350)])
    }
  }
  
  private var noDataView: some View {
    VStack(spacing: 0) {
      Spacer()
      VStack(spacing: 8) {
        Image("icon-store-mono")
          .resizable()
          .frame(width: 40, height: 40)
        
        Text("설정한 필터에 맞는 리뷰가 없어요")
          .font(.pretendard(size: 15, weight: .medium))
          .foregroundStyle(Color.grey8)
      }
      .padding(.bottom, 180)
      Spacer()
    }
  }
  
  private var reviewsList: some View {
    ScrollView {
      LazyVGrid(columns: columns) {
        if let reviews = reviews {
          ForEach(reviews.indices, id: \.self) { index in
            ReviewCellView(review: reviews[index])
            
            if index < reviews.count - 1 {
              Rectangle()
                .frame(height: 1)
                .foregroundColor(.grey2)
            }
          }
        }
      }
      .padding(.horizontal, 20)
      
      if let reviews = self.reviews, !reviews.isEmpty {
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
      
    }
  }
  
  fileprivate func toolbarItem() -> ToolbarItem<(), Button<some View>> {
    return ToolbarItem(placement: .navigationBarLeading) {
      Button {
        dismiss()
      } label: {
        Image("icon-arrow-left-small-mono")
          .resizable()
          .frame(width: 24, height: 24)
      }
    }
  }
  
  // MARK: - 데이터 로드 로직
  
  private func loadInitialContent() {
    let model = GetStoreReviewsRequest(
      offset: "0",
      limit: "7",
      order: .registDate,
      group: .all,
      grade: nil,
      campusIdx: UserDefaultsManager.getInt(.univIdx) == 0 ? "1" : "\(UserDefaultsManager.getInt(.univIdx))"
    )
    Task {
      if let result = try await StoreService().getStoresReviews(requestModel: model) {
        self.reviews = result.content
        
        if let totalPages = result.totalPages {
          isLastPage = currentPage >= totalPages
        }
      }
    }
  }
  
  private func loadMoreContent() {
    guard !isLoading, !isLastPage else { return }
    isLoading = true
    let nextPage = currentPage + 1
    
    let model = GetStoreReviewsRequest(
      offset: "\(nextPage)",
      limit: "7",
      order: selectedSortOption?.toOrderTypeForReviews ?? .registDate,
      group: selectedFilterCategoryOption?.toCategoryType,
      grade: selectedFilterGradeOption,
      campusIdx: UserDefaultsManager.getInt(.univIdx) == 0 ? "1" : "\(UserDefaultsManager.getInt(.univIdx))"
    )
    
    Task {
      if let result = try await StoreService().getStoresReviews(requestModel: model) {
        if let newReviews = result.content, !newReviews.isEmpty {
          reviews?.append(contentsOf: newReviews)
          currentPage += 1
        }
        isLastPage = result.last ?? isLastPage
      }
      isLoading = false
    }
  }
  
  /// 정렬 또는 필터를 선택하고 다시 데이터를 받아올 때 사용
  private func loadNewContent() {
    isLoading = true
    reviews = nil
    currentPage = 0
    
    let model = GetStoreReviewsRequest(
      offset: "\(currentPage)",
      limit: "7",
      order: selectedSortOption?.toOrderTypeForReviews ?? .registDate,
      group: selectedFilterCategoryOption?.toCategoryType,
      grade: selectedFilterGradeOption,
      campusIdx: UserDefaultsManager.getInt(.univIdx) == 0 ? "1" : "\(UserDefaultsManager.getInt(.univIdx))"
    )
    Task {
      if let result = try await StoreService().getStoresReviews(requestModel: model) {
        self.reviews = result.content
        
        if let totalPages = result.totalPages {
          isLastPage = currentPage >= totalPages
        }
        isLoading = false
      }
    }

  }
  
  private func applyFilters() {
    selectedFilterCategoryOption = tempSelectedFilterCategoryOption
    selectedFilterGradeOption = tempSelectedFilterGradeOption
  }
  
  /// 바텀 시트가 표시될 때 임시 필터 상태를 초기화하는 메서드
  private func resetTempFilters() {
    tempSelectedFilterCategoryOption = selectedFilterCategoryOption
    tempSelectedFilterGradeOption = selectedFilterGradeOption
  }
  
}

#Preview {
  MoreReviewsView()
}
