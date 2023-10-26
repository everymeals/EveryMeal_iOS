//
//  MealItemLikeButton.swift
//  EveryMeal_iOS
//
//  Created by 김하늘 on 10/26/23.
//

import SwiftUI

struct MealItemLikeButton: View {
  var likesCount: Int
  @State var isPressed: Bool = false
  
  var body: some View {
    Button(action: {
      isPressed = !isPressed
    }, label: {
      VStack(spacing: 2) {
        Image("icon-heart-mono")
          .renderingMode(.template)
          .foregroundColor(isPressed ? Color.everyMealRed : Color.grey4)
          .frame(width: 24)
          
        Text(String(likesCount))
          .foregroundColor(isPressed ? Color.everyMealRed : Color.grey4)
          .font(.system(size: 12, weight: .medium))
      }
    })
  }
}

struct MealImagesItemLikeButton_Previews: PreviewProvider {
  static var previews: some View {
    MealItemLikeButton(likesCount: 20, isPressed: true)
  }
}
