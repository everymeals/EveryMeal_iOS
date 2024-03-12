//
//  UnivMealView.swift
//  EveryMeal_iOS
//
//  Created by 김광록 on 2/12/24.
//

import SwiftUI

// API Response와 파싱해서 사용할 것 (현재 임시)
// 학식 식당
struct UnivStoreInfo: Identifiable {
  let id: UUID = UUID()
  var name: String
  var grade: Double
  var recommendCount: Int
  var meals: [MealInfo]
}

struct MealInfo: Identifiable {
  let id: UUID = UUID()
  var mealTime: MealTimeType
  var menuDesc: String
}

// MARK: -

struct UnivMealView: View {
  @State var currentDate: Date = Date()
  @State var stores: [UnivStoreInfo] = []
  @State var isSelected: Bool = false
  @State private var showAdditionalButton = false
  
  let dummy: [UnivStoreInfo] = [
    UnivStoreInfo(name: "A 식당",
                  grade: 4.5,
                  recommendCount: 14,
                  meals: [MealInfo(mealTime: .breakfast, menuDesc: "미역국, 밥, 김치"),
                          MealInfo(mealTime: .lunch, menuDesc: "등록된 메뉴가 없어요"),
                          MealInfo(mealTime: .dinner, menuDesc: "짜장면, 단무지, 깍두기, 미니만두튀김, 짬뽕국, 양배추샐러드, 당근주스")]),
    UnivStoreInfo(name: "B 식당",
                  grade: 3.2,
                  recommendCount: 8,
                  meals: [MealInfo(mealTime: .lunch, menuDesc: "등록된 메뉴가 없어요"),
                          MealInfo(mealTime: .dinner, menuDesc: "등록된 메뉴가 없어요")]),
    UnivStoreInfo(name: "C 식당",
                  grade: 4.8,
                  recommendCount: 20,
                  meals: [MealInfo(mealTime: .breakfast, menuDesc: "미역국, 밥, 김치")])
  ]
  
  var body: some View {
    ZStack {
      VStack(spacing: 0) {
        UnivMealNavigationView(currentDate: $currentDate)
        UnivMealContentView(stores: $stores)
        Spacer()
      }
      
      if isSelected {
        Color.black.opacity(0.5)
          .edgesIgnoringSafeArea(.all)
          .onTapGesture {
            isSelected = false
            showAdditionalButton = false
          }
      }
      
      EditFloatingButton(isSelected: $isSelected, showAdditionalButton: $showAdditionalButton)
    }
    .onChange(of: currentDate) { newValue in
      print("선택된 날짜: \(newValue.toString())")
      // TODO: 해당 날짜로 학식 불러오기 API 재요청
    }
    .onAppear {
      // TODO: 진입 시 최초 fetch data
      stores = dummy
    }
  }
}

struct EditFloatingButton: View {
  @Binding var isSelected: Bool
  @Binding var showAdditionalButton: Bool
  
  var body: some View {
    HStack {
      Spacer()
      VStack(alignment: .trailing) {
        Spacer()
        
        if showAdditionalButton {
          AdditionalButtonView(isSelected: $isSelected, showAdditionalButton: $showAdditionalButton)
        }
        
        ZStack {
          Circle()
            .foregroundColor(isSelected ? .white : .red)
            .frame(width: 48, height: 48)
          
          Image(isSelected ? "icon-x-mono" : "icon-pencil-mono")
            .renderingMode(.template)
            .resizable()
            .frame(width: 24, height: 24)
            .foregroundStyle(isSelected ? Color.grey9 : Color.white)
        }
        .onTapGesture {
          if isSelected {
            isSelected = false
            showAdditionalButton = false
          } else {
            withAnimation {
              isSelected = true
              showAdditionalButton = true
            }
          }
        }
        
      }
    }
    .padding(20)
  }
}

struct UnivMealContentView: View {
  @Binding var stores:[UnivStoreInfo]
  
  var body: some View {
    ScrollView {
      VStack(spacing: 0) {
        ForEach(stores) { store in
          storeInfoView(store: store)
          
          VStack(spacing: 0) {
            ForEach(store.meals) { meal in
              DietCell(mealTime: meal.mealTime, menuDesc: meal.menuDesc)
            }
          }
          
          // FIXME: 마지막 데이터에는 구분선 그리지 않도록 수정
          UnivMealSeparatorView()
          
        }
      }
    }
    .frame(maxWidth: .infinity)
  }
  
  func storeInfoView(store: UnivStoreInfo) -> some View {
    HStack {
      VStack(spacing: 6) {
        HStack {
          Text(store.name)
            .font(.pretendard(size: 18, weight: .bold))
          Spacer()
        }
        HStack {
          Image("icon-star-mono")
            .resizable()
            .renderingMode(.template)
            .frame(width: 14, height: 14)
            .foregroundStyle(Color.everyMealYellow)
          
          HStack(spacing: 0) {
            Text(String(format: "%.1f", store.grade))
              .font(.pretendard(size: 14, weight: .medium))
              .foregroundStyle(Color.grey7)
            Text("(\(store.recommendCount))")
              .font(.pretendard(size: 14, weight: .medium))
              .foregroundStyle(Color.grey7)
          }
          
          Spacer()
        }
      }
      Spacer()
      Text("리뷰 보기")
        .font(.pretendard(size: 14, weight: .semibold))
        .padding(.vertical, 6)
        .padding(.horizontal, 8)
        .background(Color.redLight)
        .clipShape(Rectangle())
        .foregroundStyle(Color.red)
        .cornerRadius(6)
        .onTapGesture {
          print("\(store.name)의 리뷰 보기 누름")
        }
    }
    .padding(.horizontal, 20)
    .padding(.bottom, 12)
  }
}

struct UnivMealNavigationView: View {
  @Binding var currentDate: Date
  
  var body: some View {
    VStack(spacing: 2) {
      HStack(spacing: 0) {
        title
        Spacer()
        arrows
      }
      .frame(height: 31)
      
      dateView
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
  
  var dateView: some View {
    HStack {
      Text(currentDate.toKoreanDateString())
        .font(.pretendard(size: 15, weight: .medium))
        .foregroundStyle(Color.grey7)
      Spacer()
    }
  }
  
  var arrows: some View {
    HStack(spacing: 2) {
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

struct UnivMealSeparatorView: View {
  var body: some View {
    Rectangle()
      .frame(maxWidth: .infinity, maxHeight: 12)
      .foregroundStyle(Color.grey1)
      .padding(.top, 12)
      .padding(.bottom, 24)
  }
}

#Preview {
  UnivMealView()
}

struct AdditionalButtonView: View {
  @Binding var isSelected: Bool
  @Binding var showAdditionalButton: Bool
  
  var body: some View {
    VStack(spacing: 14) {
//      HStack(spacing: 4) {
//        Image("icon-camera-mono")
//          .renderingMode(.template)
//          .resizable()
//          .frame(width: 16, height: 16)
//          .foregroundStyle(Color.everyMealRed)
//        Text("사진만 올리기")
//          .font(.pretendard(size: 16, weight: .regular))
//          .foregroundStyle(Color.grey9)
//      }
//      .padding(.horizontal, 12)
//      .padding(.vertical, 10)
//      .background()
//      .cornerRadius(6)
//      .onTapGesture {
//        isSelected = false
//        showAdditionalButton = false
//      }
      
      HStack(spacing: 4) {
        Image("icon-document-mono")
          .resizable()
          .frame(width: 16, height: 16)
        Text("리뷰 작성하기")
          .font(.pretendard(size: 16, weight: .regular))
          .foregroundStyle(Color.grey9)
      }
      .padding(.horizontal, 12)
      .padding(.vertical, 10)
      .background()
      .cornerRadius(6)
      .onTapGesture {
        isSelected = false
        showAdditionalButton = false
      }
      
    }
    .offset(x: 0, y: -14)
    .transition(.scale)
  }
}
