//
//  FilterBarView.swift
//  EveryMeal_iOS
//
//  Created by 김광록 on 2023/10/30.
//

import SwiftUI

struct FilterBarView: View {
  enum ViewType {
    case reviews
    case stores
  }
  
  @State var viewType: ViewType = .reviews
  @State var isSortOpened = false
  @State var isFilterOpened = false
  
  var body: some View {
    HStack {
      HStack(alignment: .center, spacing: 4) {
        Text("최신순")
          .font(.system(size: 14, weight: .semibold))
          .multilineTextAlignment(.center)
          .foregroundColor(Color(red: 0.42, green: 0.46, blue: 0.52))
        
        Image("icon-arrow-right-small-mono")
          .resizable()
          .frame(width: 12, height: 12)
          .rotationEffect(Angle(degrees: 90))
      }
      .padding(.horizontal, 12)
      .padding(.vertical, 6)
      .background(Color(red: 0.95, green: 0.96, blue: 0.96))
      .cornerRadius(100)
      .onTapGesture {
        isSortOpened.toggle()
      }
      .alert(
        title: "다음에 리뷰를 남길까요?",
        message: "지금까지 작성한 내용은 저장되지 않아요.",
        primaryButton: CustomAlertButton(title: "나가기", action: { print("나기기") }),
        secondaryButton: CustomAlertButton(title: "계속 쓰기", action: { print("계속 쓰기") }),
        isPresented: $isSortOpened
      )
      
      HStack(alignment: .center, spacing: 4) {
        Text("필터")
          .font(.system(size: 14, weight: .semibold))
          .multilineTextAlignment(.center)
          .foregroundColor(Color(red: 0.42, green: 0.46, blue: 0.52))
        
        Image("icon-arrow-right-small-mono")
          .resizable()
          .frame(width: 12, height: 12)
          .rotationEffect(Angle(degrees: 90))
      }
      .padding(.horizontal, 12)
      .padding(.vertical, 6)
      .background(Color(red: 0.95, green: 0.96, blue: 0.96))
      .cornerRadius(100)
      .onTapGesture {
        isFilterOpened.toggle()
      }
      .alert(title: "이거는 버튼 하나 짜리\nddd\nddd\ndd", message: "하하하하하하하\n하하하하하하하\n하하하하하하하\n하하하하하하하\n하하하하하하하\n하하하하하하하\n하하하하하하하\n하하하하하하하\n하하하하하하하\n하하하하하하하\n하하하하하하하\n하하하하하하하\n하하하하하하하\n하하하하하하하\n하하하하하하하\n하하하하하하하\n하하하하하하하\n하하하하하하하\n하하하하하하하\n하하하하하하하\n하하하하하하하\n하하하하하하하\n하하하하하하하\n하하하하하하하\n하하하하하하하\n하하하하하하하\n하하하하하하하\n하하하하하하하\n하하하하하하하\n하하하하하하하\n하하하하하하하\n하하하하하하하\n하하하하하하하\n하하하하하하하\n하하하하하하하\n하하하하하하하\n하하하하하하하\n하하하하하하하\n하하하하하하하\n하하하하하하하\n하하하하하하하\n하하하하하하하\n하하하하하하하\n하하하하하하하\n하하하하하하하\n하하하하하하하\n하하하하하하하\n하하하하하하하\n하하하하하하하", dismissButton: CustomAlertButton(title: "버튼\n두줄"), isPresented: $isFilterOpened)
      
      Spacer()
    }
    .padding(.horizontal, 20)
    .padding(.vertical, 8)
    
  }
}

struct FilterBarView_Previews: PreviewProvider {
  static var previews: some View {
    FilterBarView()
  }
}
