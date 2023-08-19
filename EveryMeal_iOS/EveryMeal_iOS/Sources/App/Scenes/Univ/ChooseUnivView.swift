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
    VStack(spacing: 0) {
      HStack {
        VStack(alignment: .leading, spacing: 12) {
          Image("school")
            .frame(width: 64, height: 64)
          
          Text("반가워요!\n대학을 선택해주세요")
            .font(Font.system(size: 24, weight: .bold))
            .foregroundColor(.grey9)
        }
        .padding(.top, 32)
        .padding(.leading, 24)
        
        Spacer()
      }
      UnivGridView(isSelected: $isSelected)
        .padding(.top, 28)
        .padding(.bottom, 15)
      ChooseButtonView(isSelected: $isSelected)
    }
  }
}

struct UnivGridView: View {

  @Binding var isSelected: Bool
  @State var selectedIndex: Int?

  let univsTitle = [
    "명지대",
    "명지대",
    "성신여대",
    "성신여대",
    "서울여대",
    "성신여대",
    "성신여대",
    "서울여대",
    "명지대",
    "명지대",
    "성신여대",
    "성신여대",
    "서울여대",
    "성신여대",
    "성신여대",
    "서울여대"
  ]
  
  let univsSubtitle = [
    "자연캠퍼스",
    "인문캠퍼스",
    "수정캠퍼스",
    "운정캠퍼스",
    "",
    "수정캠퍼스",
    "운정캠퍼스",
    "",
    "자연캠퍼스",
    "인문캠퍼스",
    "수정캠퍼스",
    "운정캠퍼스",
    "",
    "수정캠퍼스",
    "운정캠퍼스",
    ""
  ]

  var body: some View {
    let columns = [GridItem(.flexible(), spacing: 10), GridItem(.flexible(), spacing: 10)]
    
    ScrollView {
      LazyVGrid(columns: columns, spacing: 10) {
        ForEach(univsTitle.indices, id: \.self) { index in
          VStack(spacing: 8) {
            Text(univsTitle[index])
              .font(.system(size: 14, weight: .semibold))
              .foregroundColor(.grey8)
            if !univsSubtitle[index].isEmpty {
              Text(univsSubtitle[index])
                .font(.system(size: 13, weight: .regular))
                .foregroundColor(.grey6)
            }
          }
          .frame(maxWidth: .infinity)
          .frame(height: 90)
          .background(index == selectedIndex ? Color.grey3 : Color.grey1)
          .cornerRadius(10)
          .onTapGesture {
            if selectedIndex == index {
              selectedIndex = nil
            } else {
              selectedIndex = index
            }
            isSelected = selectedIndex != nil
            print("👆 tapped university cell: \(index)th \(univsTitle[index])")
          }
        }
      }
      .padding(.horizontal, 24)
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
      .padding(.horizontal, 10)
      
      Spacer()
      
      Image("icon-arrow-right-small-mono")
        .frame(width: 20, height: 20)
    }
    .frame(maxWidth: .infinity)
    .padding()
    .background(Color.grey2)
    .cornerRadius(100)
    .padding(.horizontal, 22)
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
      .padding(.bottom, 10)
  }
}

struct ChooseUnivView_Previews: PreviewProvider {
  static var previews: some View {
    ChooseUnivView()
  }
}
