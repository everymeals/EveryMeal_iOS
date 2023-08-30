//
//  HomeTopMenuView.swift
//  EveryMeal_iOS
//
//  Created by 김하늘 on 2023/08/08.
//

import SwiftUI

struct HomeTopMenuView: View {
  @State var isPresented = false
  
  var body: some View {
    VStack {
      GoToReviewBannerView()
        .padding(.top, 12)
        .padding(.horizontal, 20)
        .onTapGesture {
          self.isPresented.toggle()
        }
        .fullScreenCover(isPresented: $isPresented) {
          WriteReviewStoreSearchView {
            isPresented.toggle()
          }
        }

      TopMenuButtonsView()
    }
  }
}

struct GoToReviewBannerView: View {
  var body: some View {
    HStack(alignment: .center) {
      HStack(alignment: .center, spacing: 14) {
        Image("BurgerIcon")
          .frame(width: 40, height: 40)
        
        VStack(alignment: .leading, spacing: 2) {
          Text("슈니 원픽 맛집은 어디?")
            .font(.system(size: 15, weight: .semibold))
            .foregroundColor(Color.grey8)
          
          Text("맛집 리뷰를 남겨보세요")
            .font(.system(size: 14, weight: .medium))
            .foregroundColor(Color.grey5)
        }
      }
      Spacer()
      Image("icon-arrow-right-small-mono")
        .frame(width: 20, height: 20)
    }
    .padding(.horizontal, 24)
    .padding(.vertical, 14)
    .background(Color.grey1)
    .cornerRadius(12)
  }
}

struct TopMenuButtonsView: View {
  @State var isSelected: [Bool] = Array.init(repeating: false, count: 4)
  
  let titles = [
    "추천",
    "밥집",
    "카페",
    "술집"
  ]
  
  let menuImageName = [
    "ic_HomeMenu_recommend",
    "ic_HomeMenu_bap",
    "ic_HomeMenu_cake",
    "ic_HomeMenu_beer"
  ]
  
  let columns = [
    GridItem(.flexible()),
    GridItem(.flexible()),
    GridItem(.flexible()),
    GridItem(.flexible()),
  ]
  
  var body: some View {
    ScrollView {
      LazyVGrid(columns: columns, spacing: 8) {
        ForEach(titles.indices, id: \.self) { index in
          TopMenuButton(title: titles[index],
                        imageName: menuImageName[index])
        }
      }
    }
    .padding(20)
  }
}

struct TopMenuButton: View {
  var title: String
  var imageName: String
  @State var isPressed: Bool = false
  
  var body: some View {
    VStack(spacing: 1) {
      Image(imageName)
        .frame(width: 40, height: 40)
      Text(title)
        .font(.system(size: 14))
        .foregroundColor(Color.grey9)
    }
    .frame(width: 77)
    .padding(.vertical, 4)
    .background(isPressed ? Color.grey2 : Color.clear)
    .cornerRadius(12)
    .modifier(PressActions(onPress: {
      isPressed = true
    }, onRelease: {
      isPressed = false
    }))
  }
}

struct HomeTopMenuView_Previews: PreviewProvider {
  static var previews: some View {
    HomeView()
  }
}
