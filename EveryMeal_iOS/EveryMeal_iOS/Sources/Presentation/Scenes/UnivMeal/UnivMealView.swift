//
//  UnivMealView.swift
//  EveryMeal_iOS
//
//  Created by 김광록 on 2/12/24.
//

import SwiftUI

struct UnivMealView: View {
  @State var currentDate: Date = Date()
  
  var body: some View {
    VStack(spacing: 0) {
      navigation
      Spacer()
    }
  }
  
  var navigation: some View {
    VStack(spacing: 2) {
      HStack(spacing: 0) {
        title
        Spacer()
        arrows
      }
      .frame(height: 31)
      
      subTitle
    }
    .padding(.top, 20)
    .padding(.bottom, 28)
    .padding(.horizontal, 20)
  }
  
  var title: some View {
    Text("오늘의 학식")
      .font(.pretendard(size: 22, weight: .bold))
      .foregroundStyle(Color.everyMealBlack)
  }
  
  var subTitle: some View {
    HStack {
      Text(currentDate.toKoreanDateString())
        .font(.pretendard(size: 15, weight: .medium))
        .foregroundStyle(Color.grey7)
      Spacer()
    }
  }
  
  var arrows: some View {
    HStack(spacing: 0) {
      Image("icon-arrow-left-small-mono")
        .renderingMode(.template)
        .resizable()
        .frame(width: 20, height: 20)
        .foregroundStyle(Color.grey6)
        .padding(8)
        .onTapGesture {
          setDate(.minus)
        }
      
      Image("icon-arrow-left-small-mono")
        .renderingMode(.template)
        .resizable()
        .frame(width: 20, height: 20)
        .foregroundStyle(Color.grey6)
        .scaleEffect(x: -1, y: 1)
        .padding(8)
        .onTapGesture {
          setDate(.plus)
        }
    }
  }
  
  enum DateCase {
    case plus, minus
  }
  
  private func setDate(_ dateCase: DateCase) {
    let calendar = Calendar.current
    switch dateCase {
    case .plus:
      if let newDate = calendar.date(byAdding: .day, value: 1, to: currentDate) {
        currentDate = newDate
      }
    case .minus:
      if let newDate = calendar.date(byAdding: .day, value: -1, to: currentDate) {
        currentDate = newDate
      }
    }
  }
  
}

#Preview {
  UnivMealView()
}
