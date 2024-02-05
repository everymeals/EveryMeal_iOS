//
//  HomeTopThreeMealsView.swift
//  EveryMeal_iOS
//
//  Created by 김하늘 on 2023/08/08.
//

import SwiftUI

struct HomeTopThreeMealsView: View {
  @Binding var campusStores: [CampusStoreContent]?
  
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
      MealGridView(campusStores: $campusStores, didMealTapped: { _ in })
        .padding(.top, 20)
    }
  }
}

// FIXME: 추후 파일로 분리 필요
struct MealGridView: View {
  @Binding var campusStores: [CampusStoreContent]?
  @State var didMealTapped: (StoreEntity) -> Void
  
  var body: some View {
    let storeModels = campusStores?.map { storeContent -> StoreEntity in
      StoreEntity(
        name: storeContent.name ?? "",
        categoryDetail: storeContent.categoryDetail ?? "",
        grade: storeContent.grade ?? 0.0,
        reviewCount: storeContent.reviewCount ?? 0,
        recommendedCount: storeContent.recommendedCount ?? 0,
        images: storeContent.images,
        isLiked: storeContent.isLiked ?? false
      )
    } ?? []
    
    LazyVGrid(columns: [GridItem(.flexible())], spacing: 8) {
      ForEach(storeModels, id: \.self) { storeModel in
        MealVerticalItemView(storeModel: storeModel)
          .onTapGesture {
            // 여기에 탭 제스처 처리 로직 추가
            didMealTapped(storeModel)
          }
      }
    }.padding(.horizontal, 20)
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
    }
    .padding(.bottom, 30)
    .padding(.horizontal, 20)
  }
}

struct HomeTopThreeMealsView_Previews: PreviewProvider {
  static var previews: some View {
    HomeTopThreeMealsView(campusStores: .constant([
      CampusStoreContent(idx: nil, name: "수아당", address: nil, phoneNumber: nil, categoryDetail: "분식", distance: nil, grade: 3.0, reviewCount: 5, recommendedCount: 24, images: nil, isLiked: true),
      CampusStoreContent(idx: nil, name: "동경산책 성신여대점", address: nil, phoneNumber: nil, categoryDetail: "일식", distance: nil, grade: 3.0, reviewCount: 5, recommendedCount: 32, images: nil, isLiked: false),
      CampusStoreContent(idx: nil, name: "언앨리셰프", address: nil, phoneNumber: nil, categoryDetail: "양식", distance: nil, grade: 0, reviewCount: 0, recommendedCount: 0, images: nil, isLiked: false)
    ]))
  }
}
