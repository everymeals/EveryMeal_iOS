//
//  MealHorizontalItemView.swift
//  EveryMeal_iOS
//
//  Created by 김하늘 on 10/26/23.
//

import SwiftUI

struct MealHorizontalItemView: View {
  var mealModel: MealEntity
  
  var body: some View {
    VStack(alignment: .leading, spacing: 8) {
      
      if let imageURLs = mealModel.imageURLs?.first {
        ZStack {
          AsyncImage(url: URL(string: imageURLs)!) { image in
            image.resizable()
              .aspectRatio(contentMode: .fill)
              .frame(width: 140, height: 140)
          } placeholder: {
            Image("dummyImage")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 140, height: 140)
          }
          
          VStack {
            HStack {
              Spacer()
              MealItemLikeButton(isPressed: mealModel.doUserLike, likesCount: mealModel.likesCount, likeCountHidden: true, deselectedColor: Color.black.opacity(0.5))
            }
            Spacer()
          }
          .padding(10)
        }
        .frame(width: 140, height: 140) // 추후 해상도로 대응
        .cornerRadius(10)
      }
      VStack(alignment: .leading, spacing: 4) {
        Text(mealModel.title)
          .foregroundColor(Color.grey9)
          .font(Font.pretendard(size: 17, weight: .semibold))
        
        HStack(spacing: 0) {
          Image("icon-star-mono")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: 14)
            .padding(.trailing, 2)
          Text(String(mealModel.score))
            .foregroundColor(Color.grey7)
            .font(.pretendard(size: 12, weight: .medium))
          Text("(\(String(mealModel.likesCount)))")
            .foregroundColor(Color.grey7)
            .font(.pretendard(size: 12, weight: .medium))
          Spacer()
        }
      }
      .padding(.bottom, 14)
    }
  }
}

struct MealHorizontalItemView_Previews: PreviewProvider {
  static var previews: some View {
    let dummyMealEntity = MealEntity(title: "동경산책 성신여대점",
                                   type: .일식,
                                   description: "ss",
                                   score: 4.0,
                                   doUserLike: false,
                                   imageURLs: ["fdsfads", "fdsafdas"],
                                   likesCount: 3)
    MealHorizontalItemView(mealModel: dummyMealEntity)
    Spacer()
  }
}
