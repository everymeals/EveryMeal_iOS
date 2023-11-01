//
//  MealVerticalItemView.swift
//  EveryMeal_iOS
//
//  Created by 김하늘 on 10/26/23.
//

import SwiftUI

struct MealVerticalItemView: View {
  var mealModel: MealEntity
  
  var body: some View {
    VStack(alignment: .leading, spacing: 0) {
      HStack(alignment: .center, spacing: 0) {
        VStack(alignment: .leading, spacing: 0) {
          HStack(alignment: .center, spacing: 4) {
            Text(mealModel.title)
              .foregroundColor(Color.grey9)
              .font(.pretendard(size: 17, weight: .semibold))
            Text(mealModel.type.rawValue)
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
            Text(String(mealModel.score))
              .foregroundColor(Color.grey7)
              .font(.pretendard(size: 12, weight: .medium))
            Text("(5)")
              .foregroundColor(Color.grey7)
              .font(.pretendard(size: 12, weight: .medium))
            Spacer()
          }
        }
        Spacer()
        MealItemLikeButton(isPressed: mealModel.doUserLike, likesCount: mealModel.likesCount)
      }
      .padding(.bottom, 14)
      
      let imageColumn = Array(repeating: GridItem(.flexible()), count: 3)
      if let imageURLs = mealModel.imageURLs {
        LazyVGrid(columns: imageColumn) {
          ForEach(imageURLs.indices, id: \.self) { index in
            Rectangle()
              .foregroundColor(.clear)
              .frame(maxWidth: .infinity, minHeight: 104, maxHeight: 104)
              .background(
                ZStack {
                  Image("dummyImage")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 105, height: 104) // 추후 해상도로 대응
                  
                  if index == imageURLs.indices.last && imageURLs.count == 3 {
                    ZStack {
                      Rectangle()
                        .foregroundColor(.clear)
                        .frame(maxWidth: .infinity, minHeight: 104, maxHeight: 104)
                        .background(.black.opacity(0.4))
                        .cornerRadius(8)
                      Text("+ 18")
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
  }
}

struct MealVerticalItemView_Previews: PreviewProvider {
  static var previews: some View {
    let dummyMealEntity = MealEntity(title: "동경산책 성신여대점",
                                   type: .일식,
                                   description: "ss",
                                   score: 4.0,
                                   doUserLike: false,
                                   imageURLs: ["fdsfads", "fdsafdas"],
                                   likesCount: 3)
    MealVerticalItemView(mealModel: dummyMealEntity)
    Spacer()
  }
}
