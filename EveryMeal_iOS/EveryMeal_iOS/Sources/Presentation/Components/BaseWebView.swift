//
//  BaseWebView.swift
//  EveryMeal_iOS
//
//  Created by 김하늘 on 11/15/23.
//

import SwiftUI
import WebKit

struct BaseWebView: UIViewRepresentable {
  var url: String
  let webView = WKWebView()
  
  func makeUIView(context: Context) -> WKWebView {
    guard let url = URL(string: self.url) else {
      return WKWebView()
    }
    webView.load(URLRequest(url: url))
    webView.scrollView.bounces = false
    return webView
  }
  
  func updateUIView(_ uiView: UIViewType, context: Context) {
  }
}

struct BaseWebView_Previews: PreviewProvider {
    static var previews: some View {
      BaseWebView(url: "https://www.naver.com")
        .ignoresSafeArea(edges: .bottom)
    }
}
