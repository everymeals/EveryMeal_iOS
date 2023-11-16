//
//  EmailAuthenticationView.swift
//  EveryMeal_iOS
//
//  Created by 김하늘 on 11/1/23.
//

import SwiftUI

enum EmailViewType: String {
  case enterEmail = "이메일"
  case enterAuthNumber = "인증번호"
  
  var title: String {
    switch self {
    case .enterEmail: return "학교 인증을 위해\n대학 메일을 입력해주세요"
    case .enterAuthNumber: return "메일로 전달받은\n인증번호를 입력해주세요"
    }
  }

  var errorMessage: String {
    switch self {
    case .enterEmail: return "잘못된 이메일 형식이에요"
    case .enterAuthNumber: return "잘못된 인증번호예요"
    }
  }
}

struct EmailAuthenticationView: View {
  var viewType: EmailViewType
  @State var emailText: String = ""
  @State var isEmailTextNotEmpty: Bool = false
  @State var isValidEmail: Bool = true
  @State var emaildidSent: Bool = false
  
  private let placeholder = "everymeal@university@ac.kr"
  
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
          Text(viewType.title)
            .font(.pretendard(size: 24, weight: .bold))
            .lineLimit(2)
            .foregroundColor(.grey9)
            .padding(.bottom, 40)
          
          Text(viewType.rawValue)
            .font(.pretendard(size: 12, weight: .regular))
            .foregroundColor(.grey8)
            .padding(.bottom, 6)
          
          TextField("\(placeholder)", text: $emailText)
            .font(.pretendard(size: 16, weight: .regular))
            .frame(width: .infinity, height: 48)
            .padding(EdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16))
            .foregroundColor(.grey5)
            .background(isValidEmail ? Color.grey1 : Color.redLight )
            .overlay(
              RoundedRectangle(cornerRadius: 12)
                .inset(by: 0.5)
                .stroke(Color.grey2, lineWidth: 1)
            )
            .cornerRadius(12)
            .onChange(of: emailText, perform: { value in
              print("\(value)")
              isEmailTextNotEmpty = value != "" && value != placeholder
            })
            .padding(.bottom, 6)
          
          if !isValidEmail { // FIXME: 인증번호 오류도 같이 처리
            Text(viewType.errorMessage)
              .font(.pretendard(size: 12, weight: .regular))
              .foregroundColor(.red)
          }
          
          Spacer()
        }
        .padding(.top, 28)
        .padding(.horizontal, 20)
        
        EveryMealButton(selectEnable: $isEmailTextNotEmpty, title: "다음")
          .onTapGesture {
            isValidEmail = checkIsValidEmail(email: emailText)
            if isValidEmail == true {
              // TODO: 인증번호 전송 후 인증번호 입력 화면으로 넘김
              emaildidSent = true
            }
          }
      }
    }
    .navigationBarHidden(true)
  }
}

private func checkIsValidEmail(email: String) -> Bool {
    let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
    let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
    return emailPredicate.evaluate(with: email)
}

struct EmailAuthenticationViiew_Previews: PreviewProvider {
  static var previews: some View {
    EmailAuthenticationView(viewType: .enterEmail, backButtonTapped: {
      
    })
  }
}

