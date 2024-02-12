//
//  MainTabBarView.swift
//  EveryMeal_iOS
//
//  Created by 김광록 on 2023/07/23.
//

import SwiftUI

struct MainTabBarView: View {
  let isUnivChosen = UserDefaultsManager.getBool(.isUnivChosen)
  @State var isNotUnivChosen: Bool = false
  @State private var selectedTab = 0
  @State private var favoritesCount = 10
  @State var tabBarIsHidden = false
  
  var body: some View {
    TabView(selection: $selectedTab) {
      HomeView(otherViewShowing: $tabBarIsHidden)
        .tabItem {
          Image("icon-store-mono")
            .renderingMode(.template)
          Text("맛집")
        }
        .tag(0)
      MapView(store: .init(initialState: MapViewReducer.State(), reducer: {
        MapViewReducer()
      }))
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
      MyPageView(otherViewShowing: $tabBarIsHidden)
        .tabItem {
          Image("icon-user-mono")
            .renderingMode(.template)
          Text("마이")
        }
        .tag(3)
        .badge(favoritesCount)
    }
    .onChange(of: tabBarIsHidden) { value in
      GlobalDefine.shared.tabBarController?.view.subviews.first(where: { $0.accessibilityIdentifier == "TabBarShadow" })?.layer.isHidden = value
    }
    .tabViewStyle(.automatic)
    .onAppear {
      isNotUnivChosen = !isUnivChosen
      setupTabBarAppearance()
    }
    .fullScreenCover(isPresented: $isNotUnivChosen, content: {
      OnBoardingView(isNotUnivChosen: $isNotUnivChosen)
    })
  }
  
  private func setupTabBarAppearance() {
    let appearance = UITabBarAppearance()
    appearance.configureWithOpaqueBackground()
    appearance.backgroundColor = .white
    
    let normalAttributes: [NSAttributedString.Key: Any] = [.foregroundColor: UIColor(red: 0.69, green: 0.72, blue: 0.76, alpha: 1)]
    let selectedAttributes: [NSAttributedString.Key: Any] = [.foregroundColor: UIColor(red: 1, green: 0.28, blue: 0.28, alpha: 1)]
    
    appearance.stackedLayoutAppearance.normal.titleTextAttributes = normalAttributes
    appearance.stackedLayoutAppearance.normal.iconColor = normalAttributes[.foregroundColor] as? UIColor
    
    appearance.stackedLayoutAppearance.selected.titleTextAttributes = selectedAttributes
    appearance.stackedLayoutAppearance.selected.iconColor = selectedAttributes[.foregroundColor] as? UIColor
    
    UITabBar.appearance().standardAppearance = appearance
    UITabBar.appearance().scrollEdgeAppearance = appearance
    
    UITabBar.appearance().isTranslucent = true
  }

  func getNavigationTitle() -> Text {
    switch selectedTab {
    case 0:
      return Text("에브리밀")
        .font(.pretendard(size: 20, weight: .bold))
    case 1:
      return Text("지도")
        .font(.pretendard(size: 20, weight: .bold))
    case 2:
      return Text("오늘 학식")
        .font(.pretendard(size: 20, weight: .bold))
    case 3:
      return Text("찜 리스트")
        .font(.pretendard(size: 20, weight: .bold))
    default:
      return Text("")
    }
  }
}

extension UITabBarController {
  open override func viewWillLayoutSubviews() {
    super.viewWillLayoutSubviews()
    
    if GlobalDefine.shared.tabBarController == nil {
      GlobalDefine.shared.tabBarController = self
      
      tabBar.layer.masksToBounds = true
      tabBar.layer.cornerRadius = 20
      tabBar.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
      tabBar.backgroundImage = UIImage()
      tabBar.shadowImage = UIImage()
      Constants.tabBarHeight = tabBar.frame.height
      
      let tabBarCornerRadius = tabBar.layer.cornerRadius
      var tabBarFrame = tabBar.frame
      tabBarFrame.origin.y += 1

      let shadowView = UIView(frame: tabBarFrame)
      shadowView.backgroundColor = UIColor.white
      shadowView.accessibilityIdentifier = "TabBarShadow"
      makeLayer(shadowView)
      
      view.addSubview(shadowView)
      view.bringSubviewToFront(tabBar)
      view.clipsToBounds = true
    }
  }
  
  func makeLayer(_ shadowView: UIView) {
    shadowView.layer.cornerRadius = tabBar.layer.cornerRadius
    shadowView.layer.maskedCorners = tabBar.layer.maskedCorners
    shadowView.layer.masksToBounds = false
    shadowView.layer.shadowColor = Color.grey2.cgColor
    
    shadowView.layer.shadowOpacity = 1
    shadowView.layer.shadowRadius = 1
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    MainTabBarView()
  }
}
