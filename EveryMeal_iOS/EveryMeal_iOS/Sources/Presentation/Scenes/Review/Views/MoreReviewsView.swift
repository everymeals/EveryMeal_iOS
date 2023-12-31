//
//  MoreReviewsView.swift
//  EveryMeal_iOS
//
//  Created by 김광록 on 2023/10/16.
//

import SwiftUI

struct MoreReviewsView: View {
  @Environment(\.dismiss) private var dismiss

  let columns = [
    GridItem(.flexible())
  ]
  
  var body: some View {
    VStack {
      FilterBarView(viewType: .reviews)
      
      ScrollView (showsIndicators: false) {
        LazyVGrid(columns: columns) {
          ReviewCellView()
          
          Rectangle()
            .frame(height: 1)
            .foregroundColor(.grey2)
          
          ReviewCellView()
          
          Rectangle()
            .frame(height: 1)
            .foregroundColor(.grey2)
          
          ReviewCellView()
          
          Rectangle()
            .frame(height: 1)
            .foregroundColor(.grey2)
        }
      }
      .padding(.horizontal, 20)
      
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
    MoreReviewsView()
  }
}
