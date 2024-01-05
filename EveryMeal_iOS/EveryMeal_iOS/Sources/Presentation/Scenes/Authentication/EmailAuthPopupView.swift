//
//  EmailAuthPopupView.swift
//  EveryMeal_iOS
//
//  Created by 김하늘 on 11/21/23.
//

import SwiftUI

struct EmailAuthPopupView: View {
  @State var goToAuthButtonEnabled = true
  
  var body: some View {
    HStack {
      VStack(alignment: .leading) {
        Image(.school)
          .resizable()
          .aspectRatio(contentMode: .fit)
          .frame(width: 64)
          .padding(.bottom, 20)
        Text("학교 인증이 된 사용자만\n리뷰를 남길 수 있어요")
          .font(.pretendard(size: 22, weight: .bold))
          .lineLimit(2)
          .foregroundColor(Color.grey9)
          .padding(.bottom, 8)
        Text("바이럴 마케팅 없는 신뢰적인 정보를 공유하기 위해\n학교 인증이 필요해요")
          .font(.pretendard(size: 15, weight: .regular))
          .lineLimit(2)
          .foregroundColor(Color.grey6)
      }
      Spacer()
    }
  }
}

struct EmailAuthPopupView_Previews: PreviewProvider {
  static var previews: some View {
    EmailAuthPopupView()
  }
}

