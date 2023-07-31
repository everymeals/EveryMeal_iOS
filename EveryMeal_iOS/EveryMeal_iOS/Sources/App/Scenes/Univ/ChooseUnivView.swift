//
//  ChooseUnivView.swift
//  EveryMeal_iOS
//
//  Created by 김광록 on 2023/07/31.
//

import SwiftUI

struct ChooseUnivView: View {
  var body: some View {
    VStack {
      Text("반가워요!\n대학을 선택해주세요")
        .font(Font.system(size: 24, weight: .bold))
        .foregroundColor(Color(red: 0.2, green: 0.24, blue: 0.29))
        .padding(.top, 76)
        .padding(.leading, 24)
        .padding(.trailing, 158)
      Spacer()
      ChooseButtonView()
    }
  }
}

struct ChooseButtonView: View {
  var body: some View {
    Button {
      print("Tapped the Button!")
    } label: {
      Text("선택하기")
        .frame(maxWidth: .infinity)
        .padding()
        .background(Color.accentColor)
        .foregroundColor(.white)
        .cornerRadius(12)
        .padding(.horizontal, 20)
    }
  }
}

struct ChooseUnivView_Previews: PreviewProvider {
  static var previews: some View {
    ChooseUnivView()
  }
}
