//
//  ReviewStoreSearchListView.swift
//  EveryMeal_iOS
//
//  Created by 김하늘 on 2023/09/23.
//

import SwiftUI

struct BestStoreSearchView: View {
  
  // MARK: - States
  
  @FocusState var isSearchBarFocused: Bool
  @State private var searchText: String = ""
  @State private var searchResults: [String] = []
  @State private var scrollToTop: Bool = false
  @State private var goToWriteReview: Bool = false // 삭제 필요
  
  var nextButtonTapped: (MealEntity) -> Void
  
  // MARK: - Property
  
  var placeholder: String
  var backButtonDidTapped: () -> Void
  private let searchViewID = "searchViewID"
  
  var body: some View {
    ScrollViewReader { reader in
      ScrollView {
        VStack {
          HStack(spacing: 10) {
            Image("icon-arrow-left-small-mono")
              .frame(width: 24, height: 24)
              .onTapGesture {
                backButtonDidTapped()
              }
            BestStoreSearchBar(text: $searchText, placeholder: placeholder,
                               onSearchButtonClicked: performSearch)
            .focused($isSearchBarFocused)
            .onSubmit {
              print("commit")
            }
          }
          .padding(.leading, 12)
          .padding(.trailing, 20)
          .padding(.vertical, 12)
          .id(searchViewID)
          
          Spacer()
          // FIXME: focus 문제 해결 필요
          
          if isSearchBarFocused { // TODO: scrollToTop toggle
            let resultMealView = MealGridView(didMealTapped: { mealModel in
              nextButtonTapped(mealModel)
            })
            resultMealView
          } else {
            HStack {
              Text("최근 검색어")
                .font(.pretendard(size: 14, weight: .medium))
                .foregroundColor(Color.grey5)
              Spacer()
            }
            .padding(.leading, 20)
            .padding(.top, 18)

            ScrollView {
              LazyVGrid(columns: [GridItem(.flexible())], spacing: 0) {
                ForEach(searchResults.indices, id: \.self) { index in
                  ReviewStoreSearchListRecentCell(
                    text: searchResults[index],
                    deleteButtonTapped: {
                      searchResults.remove(at: index)
                    })
                }
              }
            }
            .padding(.horizontal, 20)
          }
        }
//        .onChange(of: scrollToTop) { _ in
//          withAnimation {
//            reader.scrollTo(searchViewID, anchor: .top)
//          }
//        }
      }
    }
    .navigationBarHidden(true)
  }
  
  func performSearch() {
    searchResults = ["Apple", "Apple Pie", "Apple Juice"].filter { $0.lowercased().contains(searchText.lowercased()) }
  }
}

struct BestStoreSearchBar: View {
  @Binding var text: String
  
  var placeholder: String
  var onSearchButtonClicked: () -> Void
  
  var body: some View {
    HStack(spacing: 10) {
      Image("icon-search-mono")
        .frame(width: 24, height: 24)
      TextField(placeholder, text: $text, onCommit: onSearchButtonClicked)
    }
    .padding(.horizontal, 16)
    .frame(height: 48)
    .background(Color.grey1)
    .border(Color.grey2)
    .cornerRadius(12)
  }
}

struct BestStoreSearchView_Previews: PreviewProvider {
  static var previews: some View {
    @State var otherViewShowing = false
    HomeView(otherViewShowing: $otherViewShowing)
//    BestStoreSearchView(nextButtonTapped: {
//      print("nextButtonTapped")
//    }, placeholder: "검색", backButtonDidTapped: {
//      print("backButton did tapped")
//    })
  }
}
