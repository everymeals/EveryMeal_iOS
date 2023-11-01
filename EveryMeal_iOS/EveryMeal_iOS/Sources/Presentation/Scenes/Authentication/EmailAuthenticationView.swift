//
//  EmailAuthenticationView.swift
//  EveryMeal_iOS
//
//  Created by 김하늘 on 11/1/23.
//

import SwiftUI

struct EmailAuthenticationView: View {
  @State var emailText: String = ""
  @State var isEmailTextEmpty: Bool = true
  
  var backButtonTapped: () -> Void
  
  var body: some View {
    NavigationView {
      VStack {
        CustomNavigationView(
          title: "학교 인증",
          leftItem: Image("icon-arrow-left-small-mono"),
          leftItemTapped: {
            backButtonTapped()
          }
        )
        VStack(alignment: .leading, spacing: 0) {
          Text("학교 인증을 위해\n대학 메일을 입력해주세요")
            .font(.pretendard(size: 24, weight: .bold))
            .lineLimit(2)
            .foregroundColor(.grey9)
            .padding(.bottom, 40)
          
          Text("이메일")
            .font(.pretendard(size: 12, weight: .regular))
            .foregroundColor(.grey8)
            .padding(.bottom, 6)
          
          TextField("\("everymeal@university@ac.kr")", text: $emailText)
            .font(.pretendard(size: 16, weight: .regular))
            .frame(width: .infinity, height: 48)
            .padding(EdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16))
            .foregroundColor(.grey5)
            .background(Color.grey1)
            .overlay(
              RoundedRectangle(cornerRadius: 12)
                .inset(by: 0.5)
                .stroke(Color.grey2, lineWidth: 1)
            )
            .cornerRadius(12)
            .onChange(of: $emailText, perform: { value in
              is value.isEmpty
              
            })
          
          
          Spacer()
          EveryMealButton(selectEnable: <#T##Binding<Bool>#>)
        }
        .padding(.top, 28)
        .padding(.leading, 20)
      }
    }
    .navigationBarHidden(true)
  }
}

struct EmailAuthenticationViiew_Previews: PreviewProvider {
  static var previews: some View {
    EmailAuthenticationView(backButtonTapped: {
      
    })
  }
}

