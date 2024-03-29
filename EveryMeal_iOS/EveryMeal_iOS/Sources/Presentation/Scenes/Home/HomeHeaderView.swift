//
//  HomeHeaderView.swift
//  EveryMeal_iOS
//
//  Created by 김하늘 on 2023/08/08.
//

import SwiftUI

struct HomeHeaderView: View {
  var body: some View {
    HStack(spacing: 24) {
      Image("everyMealLogo")
      Spacer()
      Image("icon-search-mono")
        .padding()
        .onTapGesture {
          print("임시 기능: 유저 디폴트 삭제")
          UserDefaultsManager.removeAllDefault()
        }
      Image("icon-heart-mono")
    }
    .padding(.horizontal, 20)
    .frame(height: 48)
  }
}

struct HomeHeaderView_Previews: PreviewProvider {
  static var previews: some View {
    HomeHeaderView()
  }
}
