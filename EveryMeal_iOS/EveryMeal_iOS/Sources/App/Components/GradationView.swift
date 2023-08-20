//
//  GradationView.swift
//  EveryMeal_iOS
//
//  Created by 김광록 on 2023/08/20.
//

import SwiftUI

struct GradationView: View {
  var body: some View {
    Rectangle()
      .foregroundColor(.clear)
      .frame(height: 30)
      .background(
        LinearGradient(
          stops: [
            Gradient.Stop(color: .white.opacity(0), location: 0.00),
            Gradient.Stop(color: .white, location: 1.00),
          ],
          startPoint: UnitPoint(x: 0.5, y: 0),
          endPoint: UnitPoint(x: 0.5, y: 1)
        )
      )
    
  }
}
