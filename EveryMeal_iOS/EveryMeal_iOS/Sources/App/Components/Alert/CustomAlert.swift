//
//  CustomAlert.swift
//  EveryMeal_iOS
//
//  Created by 김광록 on 2023/10/18.
//

import SwiftUI

struct CustomAlert: View {
  
  // MARK: - Value
  // MARK: Public
  let title: String
  let message: String
  let dismissButton: CustomAlertButton?
  let primaryButton: CustomAlertButton?
  let secondaryButton: CustomAlertButton?
  
  // MARK: Private
  @State private var opacity: CGFloat = 0
  @State private var backgroundOpacity: CGFloat = 0.6
  @State private var scale: CGFloat = 0.001
  
  @Environment(\.dismiss) private var dismiss
  
  
  // MARK: - View
  // MARK: Public
  var body: some View {
    ZStack {
      dimView
      
      alertView
        .scaleEffect(scale)
        .opacity(opacity)
    }
    .ignoresSafeArea()
    .transition(.opacity)
    .task {
      animate(isShown: true)
    }
  }
  
  // MARK: Private
  private var alertView: some View {
    VStack(spacing: 0) {
      titleView
      messageView
      buttonsView
    }
    .padding([.leading, .trailing, .bottom], 16)
    .padding(.top, 24)
    .frame(width: 320)
    .background(.white)
    .cornerRadius(10)
    .shadow(color: Color.black.opacity(0.4), radius: 16, x: 0, y: 12)
  }
  
  @ViewBuilder
  private var titleView: some View {
    if !title.isEmpty {
      HStack {
        Text(title)
          .font(.system(size: 18, weight: .bold))
          .lineLimit(1)
          .foregroundColor(Color(red: 0.1, green: 0.12, blue: 0.16))
          .padding(.bottom, 4)
        Spacer()
      }
    }
  }
  
  @ViewBuilder
  private var messageView: some View {
    if !message.isEmpty {
      Text(message)
        .font(.system(size: 15))
        .lineLimit(25)
        .foregroundColor(Color(red: 0.42, green: 0.46, blue: 0.52))
        .frame(maxWidth: .infinity, alignment: .topLeading)
    }
  }
  
  private var buttonsView: some View {
    HStack(spacing: 8) {
      if dismissButton != nil {
        dismissButtonView
        
      } else if primaryButton != nil, secondaryButton != nil {
        secondaryButtonView
        primaryButtonView
      }
    }
    .padding(.top, 24)
  }
  
  @ViewBuilder
  private var primaryButtonView: some View {
    if let button = primaryButton {
      CustomAlertButton(title: button.title, buttonType: .primary) {
        animate(isShown: false) {
          dismiss()
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
          button.action?()
        }
      }
    }
  }
  
  @ViewBuilder
  private var secondaryButtonView: some View {
    if let button = secondaryButton {
      CustomAlertButton(title: button.title, buttonType: .secondary) {
        animate(isShown: false) {
          dismiss()
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
          button.action?()
        }
      }
    }
  }
  
  @ViewBuilder
  private var dismissButtonView: some View {
    if let button = dismissButton {
      CustomAlertButton(title: button.title, buttonType: .primary) {
        animate(isShown: false) {
          dismiss()
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
          button.action?()
        }
      }
    }
  }
  
  private var dimView: some View {
    Color.black
      .opacity(0.6)
      .opacity(backgroundOpacity)
  }
  
  
  // MARK: - Function
  // MARK: Private
  private func animate(isShown: Bool, completion: (() -> Void)? = nil) {
    switch isShown {
    case true:
      opacity = 1
      
      withAnimation(.easeIn(duration: 0.2)) {
        backgroundOpacity = 1
        scale = 1
      }

      DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
        completion?()
      }
      
    case false:
      withAnimation(.easeOut(duration: 0.1)) {
        backgroundOpacity = 0
        opacity = 0
      }

      DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
        completion?()
      }
      
    }
  }
}

#if DEBUG
struct CustomAlert_Previews: PreviewProvider {

  static var previews: some View {
    let dismissButton = CustomAlertButton(title: "버튼")
    let primaryButton = CustomAlertButton(title: "버튼 1")
    let secondaryButton = CustomAlertButton(title: "버튼 2")

    let title = "제목"
    let message = "부가 설명이 있을때 나타납니다."

    return VStack {
      CustomAlert(title: title, message: message, dismissButton: nil, primaryButton: nil, secondaryButton: nil)
      CustomAlert(title: title, message: message, dismissButton: dismissButton, primaryButton: nil, secondaryButton: nil)
      CustomAlert(title: title, message: message, dismissButton: nil, primaryButton: primaryButton, secondaryButton: secondaryButton)
    }
    .previewDevice("iPhone 13 Pro Max")
    .preferredColorScheme(.light)
  }
}
#endif
