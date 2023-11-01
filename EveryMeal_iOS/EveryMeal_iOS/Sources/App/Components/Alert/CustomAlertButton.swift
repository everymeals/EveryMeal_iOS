//
//  CustomAlertButton.swift
//  EveryMeal_iOS
//
//  Created by 김광록 on 2023/10/18.
//

import SwiftUI

struct CustomAlertButton: View {
  
  // MARK: - Value
  // MARK: Public
  let title: LocalizedStringKey
  var buttonType: ButtonType? = nil
  var action: (() -> Void)? = nil
  
  enum ButtonType {
    case primary
    case secondary
  }
  
  // MARK: - View
  // MARK: Public
  var body: some View {
    let fontColor: Color = buttonType == .primary ? .white : .grey7
    let backgroundColor: Color = buttonType == .primary ? .everyMealRed : .grey2
    
    Button {
      action?()
    } label: {
      Text(title)
        .font(.system(size: 16, weight: .medium))
        .lineLimit(1)
        .multilineTextAlignment(.center)
        .foregroundColor(fontColor)
        .frame(maxWidth: .infinity, maxHeight: 54)
        .background(backgroundColor)
        .cornerRadius(12)
    }
    
  }
}
