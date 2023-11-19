//
//  SignOutView.swift
//  EveryMeal_iOS
//
//  Created by 김광록 on 11/19/23.
//

import SwiftUI

struct SignOutView: View {
  @State var isSelected: Bool = false
  @State var selectedReason: String?
  
  private let signOutReasons = [
    "앱을 잘 쓰지 않아요",
    "사용성이 불편해요",
    "오류가 자주 발생해요",
    "학교가 바뀌었어요",
    "기타"
  ]
  
  var body: some View {
    VStack(spacing: 40) {
      TitleDescView()
      
      VStack(alignment: .leading, spacing: 12) {
        ForEach(signOutReasons, id: \.self) { reason in
          ZStack {
            SignOutReasonCellView(why: reason, isSelected: self.selectedReason == reason)
          }
          .onTapGesture {
            self.selectedReason = reason
            self.isSelected = true
          }
        }
      }
      .frame(maxWidth: .infinity)
      .padding(.horizontal, 20)
      
      Spacer()
      
      OkButtonView(isSelected: $isSelected)
    }
    
  }
}

#Preview {
  SignOutView()
}

struct SignOutReasonCellView: View {
  var why: String = ""
  var isSelected: Bool
  
  var body: some View {
    HStack(alignment: .center) {
      Text(why)
        .font(.pretendard(size: 15, weight: .semibold))
        .foregroundColor(isSelected ? .everyMealRed : .grey8)
      Spacer()
      Image("icon-check-circle-mono")
        .renderingMode(.template)
        .foregroundColor(isSelected ? .everyMealRed : .grey4)
        .frame(width: 20, height: 20)
    }
    .padding(.horizontal, 16)
    .padding(.vertical, 18)
    .frame(maxWidth: .infinity, alignment: .center)
    .cornerRadius(10)
    .overlay(
      RoundedRectangle(cornerRadius: 10)
        .inset(by: 0.5)
        .stroke(isSelected ? .everyMealRed : Color.grey3, lineWidth: 1)
    )
  }
}

struct OkButtonView: View {
  @Binding var isSelected: Bool
  
  var bottomPadding: CGFloat {
    DeviceManager.shared.hasPhysicalHomeButton ? 24 : 0
  }
  
  var body: some View {
    Button {
      if isSelected {
        print("탈퇴하기 버튼 클릭")
      }
    } label: {
      Text("탈퇴하기")
        .frame(maxWidth: .infinity)
        .padding()
        .background(isSelected ? Color.everyMealRed : Color.grey3)
        .font(.pretendard(size: 16, weight: .medium))
        .foregroundColor(Color.white)
        .cornerRadius(12)
        .padding(.horizontal, 20)
        .padding(.bottom, bottomPadding)
    }
    .disabled(!isSelected)
  }
}

struct TitleDescView: View {
  var body: some View {
    HStack {
      VStack(alignment: .leading, spacing: 6) {
        Text("에브리밀을 정말 떠나시겠어요?")
          .font(.pretendard(size: 24, weight: .bold))
          .foregroundColor(.grey9)
        
        Text("탈퇴 이유를 알려주시면 큰 도움이 돼요")
          .font(.pretendard(size: 15, weight: .regular))
          .foregroundColor(.grey7)
      }
      Spacer()
    }
    .padding(.leading, 20)
    .padding(.top, 28)
  }
}
