//
//  StoreDetailLikeButton.swift
//  EveryMeal_iOS
//
//  Created by 김하늘 on 3/1/24.
//

import SwiftUI

struct StoreDetailLikeButton: View {
  @State var isPressed: Bool
  
  var likesCount: Int
  var selectedColor: Color = .everyMealRed
  
  var body: some View {
    HStack(spacing: 4) {
      Spacer()
      Image("icon-heart-mono")
        .renderingMode(.template)
        .foregroundColor(isPressed ? selectedColor : .grey4)
        .frame(width: 24)
      
      Text(String(likesCount))
        .font(.pretendard(size: 15, weight: .semibold))
        .foregroundColor(isPressed ? selectedColor : .grey5)
      Spacer()
    }
    .padding(.vertical, 12)
    .background(.white)
    .frame(height: 48)
    .overlay(
      RoundedRectangle(cornerRadius: 12)
        .inset(by: 0.5)
        .stroke(isPressed ? selectedColor : .grey3, lineWidth: 1)
    )
    .contentShape(Rectangle())
  }
}
