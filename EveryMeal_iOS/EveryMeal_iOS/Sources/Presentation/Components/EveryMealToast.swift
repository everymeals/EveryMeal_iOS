//
//  EveryMealToast.swift
//  EveryMeal_iOS
//
//  Created by 김하늘 on 11/21/23.
//

import SwiftUI

struct EveryMealToast: View {
  @State var showToast: Bool = false
  
  var type: ToastType?
  var completion: (() -> Void)? = nil
  
  var body: some View {
    
    Text(type?.message ?? "다시 시도해주세요")
      .font(.pretendard(size: 14, weight: .semibold))
      .foregroundColor(.white)
      .padding(.vertical, 12)
      .padding(.horizontal, 14)
      .background(Color(red: 0.2, green: 0.24, blue: 0.29).opacity(0.55))
      .cornerRadius(10)
      .toast(completion: completion)
    
  }
}

struct EveryMealToast_Previews: PreviewProvider {
  static var previews: some View {
    @State var isHidden: Bool = true
    EveryMealToast(type: .emailVertifyRetry) {
      
    }
  }
}

struct ToastModifier: ViewModifier {
  @State var isShown: Bool = false
  var completion: () -> Void
  
  func body(content: Content) -> some View {
    content
      .opacity(isShown ? 1 : 0)
      .offset(y: isShown ? (UIScreen.main.bounds.height / 2 - 102) : UIScreen.main.bounds.height)
      .onAppear(perform: {
        withAnimation(Animation.spring()) {
          self.isShown = true
          DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            withAnimation(Animation.easeInOut) {
              self.isShown = false
              completion()
            }
          }
        }
      })
  }
}

extension View {
  func toast(completion: (() -> Void)? = nil) -> some View {
    self.modifier(ToastModifier(completion: {
      if let completion = completion {
        completion()
      }
    }))
  }
}

enum ToastType {
  case emailVertifyRetry
  case alreadySigninEmail
  case copyComplete
  case deleteComplete
  case reviewSuccess

  var message: String {
    switch self {
    case .emailVertifyRetry: "인증번호를 다시 전송했어요"
    case .alreadySigninEmail: "이미 가입된 이메일입니다"
    case .copyComplete: "✅ 복사되었습니다"
    case .deleteComplete: "🗑️ 삭제되었습니다"
    case .reviewSuccess: "✅ 리뷰가 등록되었어요"
    }
  }
}

struct ToastModel: Equatable {
  var isShown: Bool
  var type: ToastType?
}
