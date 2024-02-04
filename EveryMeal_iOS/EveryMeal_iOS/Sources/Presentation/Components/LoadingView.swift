//
//  LoadingView.swift
//  EveryMeal_iOS
//
//  Created by 김하늘 on 2/1/24.
//

import SwiftUI

struct LoadingView: View {
  var body: some View {
    ZStack {
      Rectangle()
        .foregroundColor(Color.black.opacity(0.8))
        .ignoresSafeArea()
      ProgressView()
        .tint(Color.yellow)
    }
  }
}

struct LoadingView_Previews: PreviewProvider {
  static var previews: some View {
    LoadingView()
  }
}
