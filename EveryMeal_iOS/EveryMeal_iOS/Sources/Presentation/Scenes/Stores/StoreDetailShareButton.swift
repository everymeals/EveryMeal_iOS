//
//  StoreDetailShareButton.swift
//  EveryMeal_iOS
//
//  Created by 김하늘 on 3/1/24.
//

import SwiftUI

struct StoreDetailShareButton: View {
  var body: some View {
    HStack(spacing: 4) {
      Spacer()
      Image(.iconShareMono)
        .renderingMode(.template)
        .foregroundColor(.grey6)
        .frame(width: 24)
      
      Text("공유하기")
        .font(.pretendard(size: 15, weight: .semibold))
        .foregroundColor(.grey6)
      Spacer()
    }
    .padding(.vertical, 12)
    .background(Color.grey1)
    .frame(width: 111, height: 48)
    .cornerRadius(12)
    .contentShape(Rectangle())
  }
}
