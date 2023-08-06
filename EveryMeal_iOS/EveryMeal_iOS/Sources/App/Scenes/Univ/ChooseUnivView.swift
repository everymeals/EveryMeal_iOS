//
//  ChooseUnivView.swift
//  EveryMeal_iOS
//
//  Created by 김광록 on 2023/07/31.
//

import SwiftUI

struct ChooseUnivView: View {
  @State var isSelected: Bool = false
  
  var body: some View {
    VStack {
      Text("반가워요!\n대학을 선택해주세요")
        .font(Font.system(size: 24, weight: .bold))
        .foregroundColor(Color(red: 0.2, green: 0.24, blue: 0.29))
        .padding(.top, 76)
        .padding(.leading, 24)
        .padding(.trailing, 158)
      Spacer()
      ChooseButtonView(isSelected: $isSelected)
    }
  }
}

struct ChooseButtonView: View {
  @Binding var isSelected: Bool
  
  var body: some View {
    VStack(spacing: 20) {
      AddUnivView()
        .onTapGesture {
          print("학교 추가하기 버튼 👆")
        }
      SelectUnivButton(isSelected: $isSelected)
        .onTapGesture {
          if isSelected {
            print("선택하기 버튼 👆")
          }
        }
    }
  }
}

struct AddUnivView: View {
  var body: some View {
    HStack(alignment: .center) {
      HStack(alignment: .center, spacing: 14) {
        Image("icon-chat-bubble-dots-mono")
        .frame(width: 24, height: 24)
        
        VStack(alignment: .leading, spacing: 2) {
          Text("여기에 없어요")
            .font(.system(size: 15, weight: .semibold))
            .foregroundColor(Color(red: 0.31, green: 0.35, blue: 0.41))

          Text("학교 신청하러 가기")
            .font(.system(size: 14, weight: .medium))
            .foregroundColor(Color(red: 0.69, green: 0.72, blue: 0.76))
        }
      }
      
      Spacer()
      
      Image("icon-arrow-right-small-mono")
        .frame(width: 20, height: 20)
    }
    .padding(.horizontal, 24)
    .padding(.vertical, 14)
    .frame(width: 331, alignment: .leading)
    .background(Color(red: 0.95, green: 0.96, blue: 0.96))
    .cornerRadius(100)
  }
}

struct SelectUnivButton: View {
  @Binding var isSelected: Bool
  
  var body: some View {
    Text("선택하기")
      .frame(maxWidth: .infinity)
      .padding()
      .background(isSelected ? Color.accentColor : Color(red: 0.9, green: 0.91, blue: 0.92))
      .font(.system(size: 16, weight: .medium))
      .foregroundColor(Color.white)
      .cornerRadius(12)
      .padding(.horizontal, 20)
      .padding(.bottom, 20)
  }
}

struct ChooseUnivView_Previews: PreviewProvider {
  static var previews: some View {
    ChooseUnivView()
  }
}

