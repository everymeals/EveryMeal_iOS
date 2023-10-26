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

struct ViewHeightModifier: ViewModifier {
  var key: ViewHeightKey.Type
  
  func body(content: Content) -> some View {
    content.background(
      GeometryReader { geometry in
        Color.clear.preference(key: key.self, value: geometry.size.height)
      }
    )
  }
}

struct ViewHeightKey: PreferenceKey {
    static var defaultValue: CGFloat = 0

    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = max(value, nextValue())
    }
}
