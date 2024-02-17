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
  }
  
  private var filterBar: some View {
    FilterBarView(
      viewType: .reviews,
      selectedSortOption: $selectedSortOption
    )
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
    let univIdx = UserDefaultsManager.getInt(.univIdx) == 0 ? "1" : "\(UserDefaultsManager.getInt(.univIdx))"
    let model = GetStoreReviewsRequest(offset: "0", limit: "7", order: .name, group: .all, campusIdx: univIdx)
    Task {
      if let result = try await StoreService().getStoresReviews(requestModel: model) {
        self.reviews = result.content
        
        if let totalPages = result.totalPages {
          isLastPage = currentPage >= totalPages
        }
      }
    }
  }
  
}

#Preview {
  MoreReviewsView()
}
