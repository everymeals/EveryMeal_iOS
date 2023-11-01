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
      Text("뭐먹지")
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
    .tabViewStyle(.automatic)
    .onAppear(perform: {
      UITabBar.appearance().unselectedItemTintColor = UIColor(red: 0.69, green: 0.72, blue: 0.76, alpha: 1)
      UITabBar.appearance().isTranslucent = true
    })
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

extension UITabBarController {
  open override func viewWillLayoutSubviews() {
    super.viewWillLayoutSubviews()
    
    tabBar.layer.masksToBounds = true
    tabBar.layer.cornerRadius = 20
    tabBar.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
    tabBar.backgroundImage = UIImage()
    tabBar.shadowImage = UIImage()
    Constants.tabBarHeight = tabBar.frame.height
    
    if let shadowView = view.subviews.first(where: { $0.accessibilityIdentifier == "TabBarShadow" }) {
      shadowView.frame = tabBar.frame
    } else {
      let tabBarCornerRadius = tabBar.layer.cornerRadius
      var tabBarFrame = tabBar.frame
      tabBarFrame.origin.y += 1

      let shadowView = UIView(frame: tabBarFrame)
      
      shadowView.backgroundColor = UIColor.white
      shadowView.accessibilityIdentifier = "TabBarShadow"
      shadowView.layer.cornerRadius = tabBarCornerRadius
      shadowView.layer.maskedCorners = tabBar.layer.maskedCorners
      shadowView.layer.masksToBounds = false
      shadowView.layer.shadowColor = Color.grey2.cgColor
      
      shadowView.layer.shadowOpacity = 1
      shadowView.layer.shadowRadius = 1
      
      view.addSubview(shadowView)
      view.bringSubviewToFront(tabBar)
      view.clipsToBounds = true
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    MainTabBarView()
  }
}
