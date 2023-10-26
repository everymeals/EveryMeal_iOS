//
//  MealItemLikeButton.swift
//  EveryMeal_iOS
//
//  Created by 김하늘 on 10/26/23.
//

import SwiftUI

struct MealItemLikeButton: View {
  @State var isPressed: Bool = false
  
  var likesCount: Int
  var likeCountHidden: Bool = false
  var selectedColor: Color = .everyMealRed
  var deselectedColor: Color = .grey4
  var borderHidden: Bool = true
  
  var body: some View {
    Button(action: {
      isPressed = !isPressed
    }, label: {
      VStack(spacing: 2) {
        Image("icon-heart-mono")
          .renderingMode(.template)
          .foregroundColor(isPressed ? selectedColor : deselectedColor)
          .frame(width: 24)
          
        if !likeCountHidden {
          Text(String(likesCount))
            .foregroundColor(isPressed ? selectedColor : deselectedColor)
            .font(.system(size: 12, weight: .medium))
        }
      }
    })
  }
}

struct MealImagesItemLikeButton_Previews: PreviewProvider {
  static var previews: some View {
    MealItemLikeButton(isPressed: true, likesCount: 20)
  }
}
