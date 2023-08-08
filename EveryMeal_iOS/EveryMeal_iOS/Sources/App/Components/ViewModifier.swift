//
//  ViewModifier.swift
//  EveryMeal_iOS
//
//  Created by 김하늘 on 2023/08/08.
//

import SwiftUI

struct PressActions: ViewModifier {
  var onPress: () -> Void
  var onRelease: () -> Void
  
  func body(content: Content) -> some View {
    content
      .simultaneousGesture(
        DragGesture(minimumDistance: 0)
          .onChanged({ _ in
            onPress()
          })
          .onEnded({ _ in
            onRelease()
          })
      )
  }
}
