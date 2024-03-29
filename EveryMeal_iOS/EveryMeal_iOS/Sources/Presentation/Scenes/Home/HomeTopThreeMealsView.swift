//
//  HomeTopThreeMealsView.swift
//  EveryMeal_iOS
//
//  Created by 김하늘 on 2023/08/08.
//

import SwiftUI

struct HomeTopThreeMealsView: View {
  @Binding var campusStores: [CampusStoreContent]?
  var didStoreTapped: (CampusStoreContent) -> Void
  
  var body: some View {
    VStack(spacing: 8) {
      HStack(spacing: 0) {
        Text("맛집 모아보기")
          .font(.pretendard(size: 20, weight: .bold))
          .foregroundColor(Color.black)
          .padding(.leading, 20)
          .padding(.top, 24)
        Spacer()
      }
      MealGridView(campusStores: $campusStores, didMealTapped: { storeContent in
        didStoreTapped(storeContent)
      })
    }
  }
}

// FIXME: 추후 파일로 분리 필요
struct MealGridView: View {
  @Binding var campusStores: [CampusStoreContent]?
  @State var didMealTapped: (CampusStoreContent) -> Void
  
  var body: some View {
    if let storeModels = campusStores {
      LazyVGrid(columns: [GridItem(.flexible())], spacing: 0) {
        ForEach(Array(storeModels
          .enumerated()), id: \.element) { index, storeModel in
          MealVerticalItemView(storeModel: storeModel)
            .onTapGesture {
              // TODO: 여기에 탭 제스처 처리 로직 추가
              didMealTapped(storeModel)
              print("\(storeModels[index].name) 선택됨")
            }
            .padding(.vertical, 12)
          
          if index < storeModels.count - 1 {
            Rectangle()
              .frame(height: 1)
              .foregroundColor(.grey2)
          }
        }
      }.padding(.horizontal, 20)
    }
  }
  
  
}

struct MoreRestuarantButton: View {
  var body: some View {
    HStack(alignment: .center, spacing: 10) {
      Text("맛집 더 보러 가기")
        .foregroundColor(Color.everyMealRed)
        .padding(.vertical, 13)
        .frame(maxWidth: .infinity)
        .overlay(
          RoundedRectangle(cornerRadius: 12)
            .inset(by: 0.5)
            .stroke(Color.everyMealRed, lineWidth: 1)
        )
        .contentShape(Rectangle())
    }
    .padding(.bottom, 22)
    .padding(.horizontal, 20)
  }
}

struct HomeTopThreeMealsView_Previews: PreviewProvider {
  static var previews: some View {
    HomeTopThreeMealsView(campusStores: .constant([
      CampusStoreContent(idx: 11, name: "수아당", address: nil, phoneNumber: nil, categoryDetail: "분식", distance: nil, grade: 3.0, reviewCount: 5, recommendedCount: 24, images: nil, isLiked: true),
      CampusStoreContent(idx: 22, name: "동경산책 성신여대점", address: nil, phoneNumber: nil, categoryDetail: "일식", distance: nil, grade: 3.0, reviewCount: 5, recommendedCount: 32, images: nil, isLiked: false),
      CampusStoreContent(idx: 33, name: "언앨리셰프", address: nil, phoneNumber: nil, categoryDetail: "양식", distance: nil, grade: 0, reviewCount: 0, recommendedCount: 0, images: nil, isLiked: false)
    ]), didStoreTapped: { _ in })
  }
}
