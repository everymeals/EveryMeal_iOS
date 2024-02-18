//
//  ReviewStoreSearchListView.swift
//  EveryMeal_iOS
//
//  Created by 김하늘 on 2023/09/23.
//

import SwiftUI
import Combine

struct BestStoreSearchView: View {
  
  // MARK: - States
  
  @FocusState var isSearchBarFocused: Bool
  @State private var searchText: String = ""
  @State private var searchResults: [CampusStoreContent]? = []
  @State private var scrollToTop: Bool = false
  @State private var goToWriteReview: Bool = false // 삭제 필요
  @State private var recentSearchStores = UserDefaultsManager.getArrayString(.recentSearchStores) ?? []
  private let searchPublisher = PassthroughSubject<String, Never>()
  
  var nextButtonTapped: (StoreEntity) -> Void
  
  // MARK: - Property
  
  var placeholder: String
  var backButtonDidTapped: () -> Void
  private let searchViewID = "searchViewID"
  
  var body: some View {
    let searchDebounce = searchPublisher.debounce(for: .seconds(1), scheduler: RunLoop.main)
    
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
                               onSearchButtonClicked: {
              var recordedSearchStore = UserDefaultsManager.getArrayString(.recentSearchStores) ?? []
              if !recordedSearchStore.contains(searchText) {
                recordedSearchStore.append(searchText)
                UserDefaultsManager.setValue(.recentSearchStores, value: recordedSearchStore)
              }
              UIApplication.shared.hideKeyboard()
            })
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
          
          if searchText != "" {
            let resultMealView = MealGridView(
              campusStores: $searchResults,
              didMealTapped: { storeModel in
                var recordedSearchStore = UserDefaultsManager.getArrayString(.recentSearchStores) ?? []
                if !recordedSearchStore.contains(searchText) {
                  recordedSearchStore.append(searchText)
                  UserDefaultsManager.setValue(.recentSearchStores, value: recordedSearchStore)
                }
                nextButtonTapped(storeModel)
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
                ForEach(recentSearchStores.indices, id: \.self) { index in
                  ReviewStoreSearchListRecentCell(
                    text: recentSearchStores[index],
                    deleteButtonTapped: {
                      recentSearchStores.remove(at: index)
                    })
                  .onTapGesture {
                    searchText = recentSearchStores[index]
                  }
                }
              }
            }
            .padding(.horizontal, 20)
          }
        }
        .onChange(of: searchText) { text in
          if text != "" {
            searchPublisher.send(text)
          }
        }
        .onReceive(searchDebounce) { value in
          Task {
            do {
              let model = GetCampusStoreKeywordRequest(
                campusIdx: UserDefaultsManager.getInt(.univIdx),
                keyword: value,
                offset: 0,
                limit: 10
              )
              let response = try await StoreService().getCampusStoresWithKeyword(model)
              if let result = response?.content {
                searchResults = result
              }
            }
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
  
  func search() {
    
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
//    HomeView(otherViewShowing: $otherViewShowing)
    BestStoreSearchView(nextButtonTapped: { _ in
      print("nextButtonTapped")
    }, placeholder: "검색", backButtonDidTapped: {
      print("backButton did tapped")
    })
  }
}
