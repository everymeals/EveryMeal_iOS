//
//  MoreReviewsView.swift
//  EveryMeal_iOS
//
//  Created by 김광록 on 2023/10/16.
//

import SwiftUI

struct MoreReviewsView: View {
  @Environment(\.dismiss) private var dismiss

  var body: some View {
    VStack {
      FilterBarView()

      Text("Hello, World!")
      
      Spacer()
    }
    .navigationTitle("리뷰")
    .navigationBarTitleDisplayMode(.inline)
    .navigationBarBackButtonHidden()
    .toolbar {
      ToolbarItem(placement: .navigationBarLeading) {
        Button {
          dismiss()
        } label: {
          Image("icon-arrow-left-small-mono")
            .resizable()
            .frame(width: 24, height: 24)
        }
      }
    }
  }
}

struct MoreReviewsView_Previews: PreviewProvider {
  static var previews: some View {
    HomeView()
  }
}
