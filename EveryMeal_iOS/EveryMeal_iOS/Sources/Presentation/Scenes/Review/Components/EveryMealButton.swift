//
//  EveryMealButton.swift
//  EveryMeal_iOS
//
//  Created by 김하늘 on 10/26/23.
//

import SwiftUI

struct EveryMealButton: View {
  @Binding var selectEnable: Bool
  var title: String = "저장하기"
  var deselectableColor: Color = .grey3
  var selectableColor: Color = .red
  var textColor: Color = .white
  
  var body: some View {
    HStack {
      Text(title)
        .frame(maxWidth: .infinity)
        .padding()
        .background(selectEnable ? selectableColor : deselectableColor)
        .font(.system(size: 16, weight: .medium))
        .foregroundColor(Color.white)
        .cornerRadius(12)
        .padding(.horizontal, 20)
        .padding(.bottom, 10)
    }
    .padding(.top, 20)
    .background(.white)
  }
}

struct ReviewSaveButton_Previews: PreviewProvider {
  static var previews: some View {
    @State var didSelected = true
    EveryMealButton(selectEnable: $didSelected)
  }
}
