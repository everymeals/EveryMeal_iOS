//
//  View+Extensions.swift
//  EveryMeal_iOS
//
//  Created by 김광록 on 2023/10/18.
//

import SwiftUI

extension View {
  func alert(title: String = "", message: String = "", dismissButton: CustomAlertButton = CustomAlertButton(title: "ok"), isPresented: Binding<Bool>) -> some View {
    let title   = NSLocalizedString(title, comment: "")
    let message = NSLocalizedString(message, comment: "")
    
    return modifier(CustomAlertModifier(title: title, message: message, dismissButton: dismissButton, isPresented: isPresented))
  }
  
  func alert(title: String = "", message: String = "", primaryButton: CustomAlertButton, secondaryButton: CustomAlertButton, isPresented: Binding<Bool>) -> some View {
    let title   = NSLocalizedString(title, comment: "")
    let message = NSLocalizedString(message, comment: "")
    
    return modifier(CustomAlertModifier(title: title, message: message, primaryButton: primaryButton, secondaryButton: secondaryButton, isPresented: isPresented))
  }
  
}
