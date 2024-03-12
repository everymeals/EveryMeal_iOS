//
//  MealHorizontalItemView.swift
//  EveryMeal_iOS
//
//  Created by 김하늘 on 10/26/23.
//

import SwiftUI

struct MealHorizontalItemView: View {
  var storeModel: StoreEntity
  
  var body: some View {
    VStack(alignment: .leading, spacing: 8) {
      
      if let imageURLs = storeModel.images?.first {
        ZStack {
          AsyncImage(url: URL(string: imageURLs)!) { image in
            image.resizable()
              .aspectRatio(contentMode: .fill)
          } placeholder: {
            Rectangle()
              .foregroundStyle(Color.grey3)
          }
          
          heartView
        }
        .frame(width: 140, height: 140)
        .cornerRadius(10)
      } else {
        Rectangle()
          .frame(width: 140, height: 140)
          .foregroundStyle(Color.grey3)
          .cornerRadius(10)
      }
          
      labelView
    }
    .frame(width: 140, height: 209)
  }
  
  private var labelView: some View {
    VStack(alignment: .leading, spacing: 4) {
      Text(storeModel.name)
        .foregroundColor(Color.grey9)
        .font(Font.pretendard(size: 17, weight: .semibold))
      
      HStack(spacing: 0) {
        Image("icon-star-mono")
          .resizable()
          .aspectRatio(contentMode: .fit)
          .frame(width: 14)
          .padding(.trailing, 2)
        Text(String(storeModel.grade))
          .foregroundColor(Color.grey7)
          .font(.pretendard(size: 12, weight: .medium))
        Text("(\(String(storeModel.recommendedCount)))")
          .foregroundColor(Color.grey7)
          .font(.pretendard(size: 12, weight: .medium))
        Spacer()
      }
    }
    .padding(.bottom, 14)
  }
  
  private var heartView: some View {
    VStack {
      HStack {
        Spacer()
        MealItemLikeButton(isPressed: storeModel.isLiked, likesCount: storeModel.recommendedCount, likeCountHidden: true, deselectedColor: Color.black.opacity(0.5))
      }
      Spacer()
    }
    .padding(10)
  }
  
}

struct MealHorizontalItemView_Previews: PreviewProvider {
  static var previews: some View {
    MealHorizontalItemView(storeModel: Constants.dummyStore)
    Spacer()
  }
}
