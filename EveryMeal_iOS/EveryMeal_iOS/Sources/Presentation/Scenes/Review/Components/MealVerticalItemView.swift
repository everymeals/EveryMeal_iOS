//
//  MealVerticalItemView.swift
//  EveryMeal_iOS
//
//  Created by 김하늘 on 10/26/23.
//

import SwiftUI

struct MealVerticalItemView: View {
  var storeModel: StoreEntity
  
  var body: some View {
    VStack(alignment: .leading, spacing: 0) {
      HStack(alignment: .center, spacing: 0) {
        VStack(alignment: .leading, spacing: 0) {
          HStack(alignment: .center, spacing: 4) {
            Text(storeModel.name)
              .foregroundColor(Color.grey9)
              .font(.pretendard(size: 17, weight: .semibold))
            Text(storeModel.categoryDetail)
              .foregroundColor(Color.grey6)
              .font(.pretendard(size: 12, weight: .medium))
              .padding(.horizontal, 6)
              .padding(.vertical, 3)
              .background(Color.grey2)
              .cornerRadius(4)
          }
          .padding(.bottom, 6)
          
          HStack(spacing: 0) {
            Image("icon-star-mono")
              .resizable()
              .aspectRatio(contentMode: .fit)
              .frame(width: 14)
              .padding(.trailing, 2)
            Text(String(storeModel.grade))
              .foregroundColor(Color.grey7)
              .font(.pretendard(size: 12, weight: .medium))
            Text("(5)")
              .foregroundColor(Color.grey7)
              .font(.pretendard(size: 12, weight: .medium))
            Spacer()
          }
        }
        Spacer()
        MealItemLikeButton(isPressed: storeModel.isLiked, likesCount: storeModel.recommendedCount)
      }
      .padding(.bottom, 14)
      
      let imageColumn = Array(repeating: GridItem(.flexible()), count: 3)

      if let imageURLs = storeModel.images {
        LazyVGrid(columns: imageColumn) {
          ForEach(0..<min(imageURLs.count, 3), id: \.self) { index in
            Rectangle()
              .foregroundColor(.clear)
              .frame(maxWidth: .infinity, minHeight: 104, maxHeight: 104)
              .background(
                ZStack {
                  AsyncImage(url: URL(string: imageURLs[index]))
                  
                  if index == 2 && imageURLs.count > 3 {
                    ZStack {
                      Rectangle()
                        .foregroundColor(.clear)
                        .frame(maxWidth: .infinity, minHeight: 104, maxHeight: 104)
                        .background(.black.opacity(0.4))
                        .cornerRadius(8)
                      Text("+ \(imageURLs.count - 3)")
                        .font(.pretendard(size: 16, weight: .medium))
                        .foregroundColor(Color.white)
                    }
                  }
                }
              )
              .cornerRadius(8)
          }
        }
      }
    }
    .background(Color.black.opacity(0.001))
  }
}

struct MealVerticalItemView_Previews: PreviewProvider {
  static var previews: some View {
    let dummy = StoreEntity(name: "동경산책 성신여대점",
                            categoryDetail: "일식",
                            grade: 4.0,
                            reviewCount: 34,
                            recommendedCount: 29,
                            images: ["fdsfads", "fdsafdas", "fdsafdas", "fdsafdas", "fdsafdas"],
                            isLiked: false)
    
    MealVerticalItemView(storeModel: dummy)
    Spacer()
  }
}
