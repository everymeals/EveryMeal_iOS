//
//  WriteReviewStoreSearchView.swift
//  EveryMeal_iOS
//
//  Created by 김하늘 on 2023/08/30.
//

import SwiftUI

struct WriteReviewStoreSearchView: View {
  @State var text: String = ""
  var closeButtonTapped: () -> Void
  
  var body: some View {
    NavigationView {
      VStack(alignment: .center, spacing: 28) {
        CustomNavigationView {
          closeButtonTapped()
        }
        HStack(spacing: 0) {
          Text("다녀온 맛집은\n어디인가요?")
            .font(.system(size: 24, weight: .bold))
            .foregroundColor(Color.grey9)
            .padding(.leading, 20)
          Spacer()
        }
        BestStoreSearchView(placeholder: "검색")
        Spacer()
      }
    }
  }
}

struct CustomNavigationView: View {
  var title: String = "리뷰 작성"
  var rightItem: Image = Image(systemName: "xmark")
  var closeButtonTapped: () -> Void
  
  var body: some View {
    HStack(alignment: .center, spacing: 10) {
      Spacer()
      Text(title)
        .font(.system(size: 16, weight: .medium))
        .padding(.leading, 20)
      Spacer()
      rightItem
        .foregroundColor(Color.grey5)
        .onTapGesture {
          closeButtonTapped()
        }
    }
    .padding(.horizontal, 20)
    .padding(.vertical, 12)
    .frame(height: 48)
    .background(.white)
  }
}

struct WriteReviewStoreSearchView_Previews: PreviewProvider {
  static var previews: some View {
    WriteReviewStoreSearchView {
      print("close")
    }
  }
}

struct BestStoreSearchView: View {
  @State private var searchText: String = ""
  @State private var searchResults: [String] = []
  var placeholder: String
  
  var body: some View {
    VStack {
      BestStoreSearchBar(placeholder: placeholder,
                text: $searchText,
                onSearchButtonClicked: performSearch)
        .padding(.horizontal, 20)
      
      List(searchResults, id: \.self) { result in
        Text(result)
      }
    }
  }
  
  func performSearch() {
    searchResults = ["Apple", "Apple Pie", "Apple Juice"].filter { $0.lowercased().contains(searchText.lowercased()) }
  }
}

struct BestStoreSearchBar: View {
  var placeholder: String
  @Binding var text: String
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
    .cornerRadius(12)
    .border(Color.grey2)
  }
}
