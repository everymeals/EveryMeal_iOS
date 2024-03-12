//
//  HomeReviewsView.swift
//  EveryMeal_iOS
//
//  Created by 김하늘 on 2023/08/08.
//

import SwiftUI
import Lottie

struct HomeReviewsView: View {
  @Binding var reviews: [GetStoreReviewsContent]?
  
  var body: some View {
    VStack(alignment: .leading, spacing: 8) {
      header
      
      if let reviews = reviews {
        ForEach(reviews.indices, id: \.self) { index in
          ReviewCellView(review: reviews[index])
          
          if index < reviews.count - 1 {
            Rectangle()
              .frame(height: 1)
              .foregroundColor(.grey2)
          }
        }
      }

    }
    .padding(.horizontal, 20)
    
  }
  
  private var header: some View {
    HStack {
      Text("리뷰 모아보기")
        .font(.pretendard(size: 20, weight: .bold))
        .foregroundColor(Color.everyMealBlack)
        .padding(.top, 15)
      Spacer()
    }
  }
  
}

struct MoreReviewButton: View {
  var body: some View {
    HStack(alignment: .center, spacing: 10) {
      Text("리뷰 더 보러 가기")
        .foregroundColor(Color.everyMealRed)
        .padding(.vertical, 13)
        .frame(maxWidth: .infinity)
        .overlay(
          RoundedRectangle(cornerRadius: 12)
            .inset(by: 0.5)
            .stroke(Color.everyMealRed, lineWidth: 1)
        )
    }
    .padding(.bottom, 30)
  }
}

#Preview {
  HomeReviewsView(reviews: .constant(Constants.dummyStoreReviews))
}
