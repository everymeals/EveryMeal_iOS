//
//  MainTabBarView.swift
//  EveryMeal_iOS
//
//  Created by 김광록 on 2023/07/23.
//

import SwiftUI

struct MainTabBarView: View {
  @State private var selectedTab = 0
  @State private var favoritesCount = 10
  
  var body: some View {
    NavigationView {
      TabView(selection: $selectedTab) {
        HomeView()
          .tabItem {
            Image("icon-store-mono")
              .renderingMode(.template)
            Text("맛집")
          }
          .tag(0)
        MapView()
          .tabItem {
            Image("icon-folk-knife-mono")
              .renderingMode(.template)
            Text("학식")
          }
          .tag(1)
          ChooseUnivView()
          .tabItem {
            Image("icon-chat-bubble-question-mono")
              .renderingMode(.template)
            Text("뭐먹지")
          }
          .tag(2)
        Text("마이")
          .tabItem {
            Image("icon-user-mono")
              .renderingMode(.template)
            Text("마이")
          }
          .tag(3)
          .badge(favoritesCount)
      }
      .onAppear(perform: {
        UITabBar.appearance().unselectedItemTintColor = UIColor(red: 0.69, green: 0.72, blue: 0.76, alpha: 1)
      })
      .navigationBarTitle(getNavigationTitle(), displayMode: .inline)
      .navigationBarItems(
        trailing: selectedTab == 0 ? NavigationLink(destination: SearchView()) {
          Image(systemName: "magnifyingglass")
        } : nil
      )
    }
  }
  
  func getNavigationTitle() -> Text {
    switch selectedTab {
    case 0:
      return Text("에브리밀")
        .font(.system(size: 20, weight: .bold))
    case 1:
      return Text("지도")
        .font(.system(size: 20, weight: .bold))
    case 2:
      return Text("오늘 학식")
        .font(.system(size: 20, weight: .bold))
    case 3:
      return Text("찜 리스트")
        .font(.system(size: 20, weight: .bold))
    default:
      return Text("")
    }
  }

}

struct SearchView: View {
  @State private var searchText: String = ""
  @State private var searchResults: [String] = []
  
  var body: some View {
    VStack {
      SearchBar(text: $searchText, onSearchButtonClicked: performSearch)
        .padding(.horizontal)
      
      List(searchResults, id: \.self) { result in
        Text(result)
      }
    }
  }
  
  func performSearch() {
    searchResults = ["Apple", "Apple Pie", "Apple Juice"].filter { $0.lowercased().contains(searchText.lowercased()) }
  }
}

struct SearchBar: View {
  @Binding var text: String
  var onSearchButtonClicked: () -> Void
  
  var body: some View {
    HStack {
      TextField("검색어 입력", text: $text, onCommit: onSearchButtonClicked)
        .textFieldStyle(RoundedBorderTextFieldStyle())
      
      Button(action: onSearchButtonClicked) {
        Text("검색")
      }
      .padding(.horizontal)
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    MainTabBarView()
  }
}
