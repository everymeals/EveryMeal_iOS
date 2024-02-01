//
//  AuthSuccessView.swift
//  EveryMeal_iOS
//
//  Created by 김하늘 on 1/2/24.
//

import SwiftUI

struct AuthSuccessView: View {
  @State private var viewOpacity: Double = 0.0
  var nickname: String
  
  var body: some View {
    VStack(alignment: .leading, spacing: 0) {
      VStack(alignment: .leading, spacing: 0) {
        Text("\(nickname)님,\n환영해요!")
          .font(.pretendard(size: 24, weight: .bold))
          .lineLimit(2)
          .foregroundColor(.grey9)
          .padding(.top, 76)
          .padding(.bottom, 6)
        
        Text("이제 에브리밀을\n다양하게 이용할 수 있어요")
          .font(.pretendard(size: 15, weight: .regular))
          .foregroundColor(.grey7)
      }
      .padding(.leading, 20)
      .padding(.bottom, 10)
      
      Image(.drinkSample)
        .resizable()
        .aspectRatio(contentMode: .fit)
        .frame(width: UIScreen.main.bounds.width)
      
      Spacer()
    }
    .background(.white)
    .opacity(viewOpacity)
    .onAppear {
      withAnimation(.easeInOut(duration: 2.0)) {
        self.viewOpacity = 1.0
      }
    }
  }
}

struct AuthSuccessView_Previews: PreviewProvider {
  static var previews: some View {
    AuthSuccessView(nickname: "연유크림")
  }
}

