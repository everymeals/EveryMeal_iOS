//
//  BaseLottieView.swift
//  EveryMeal_iOS
//
//  Created by 김광록 on 2023/11/07.
//

import SwiftUI
import UIKit
import Lottie

struct BaseLottieView: UIViewRepresentable {
  var jsonName: String
  var loopMode: LottieLoopMode = .loop
  
  func makeUIView(context: UIViewRepresentableContext<BaseLottieView>) -> UIView {
      let view = UIView(frame: .zero)
      
      let animationView = LottieAnimationView()
      let animation = LottieAnimation.named(jsonName)
      animationView.animation = animation
      animationView.contentMode = .scaleAspectFit
      animationView.loopMode = loopMode
      animationView.play()
      
      animationView.translatesAutoresizingMaskIntoConstraints = false
      view.addSubview(animationView)
      
      NSLayoutConstraint.activate([
          animationView.heightAnchor.constraint(equalTo: view.heightAnchor),
          animationView.widthAnchor.constraint(equalTo: view.widthAnchor)
      ])
      
      return view
  }
  
  func updateUIView(_ uiView: UIView, context: UIViewRepresentableContext<BaseLottieView>) {
      // Use this function to update the view in response to SwiftUI state changes.
  }
}
