//
//  FoodMapView.swift
//  EveryMeal_iOS
//
//  Created by 김광록 on 2/12/24.
//

import SwiftUI

struct FoodMapView: View {
  var body: some View {
    UnderConstruction()
  }
}

struct UnderConstruction: View {
  var body: some View {
    VStack(spacing: 12) {
      Image("construction")
        .resizable()
        .frame(width: 200, height: 200)
      Text("해당 서비스는 준비중이에요")
        .font(.pretendard(size: 20, weight: .bold))
        .foregroundStyle(Color.everyMealBlack)
      Text("빠른 시일 내에 이용하실 수 있도록\n에브리밀이 준비하고 있어요.")
        .font(.pretendard(size: 14, weight: .regular))
        .foregroundStyle(Color.grey7)
        .multilineTextAlignment(.center)
        .lineSpacing(3)
    }
  }
}

#Preview {
  FoodMapView()
}
