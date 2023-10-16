//
//  ReviewDetailView.swift
//  EveryMeal_iOS
//
//  Created by 김하늘 on 10/16/23.
//

import SwiftUI

struct ReviewDetailView: View {
  
  // MARK: - States
  
  @State var reviewModel: ReviewDetailModel
  
  // MARK: - Property
  
  var nextButtonTapped: () -> Void
  var backButtonDidTapped: () -> Void
  
  var body: some View {
    VStack {
      
    }
    .navigationBarHidden(true)
  }
}

struct ReviewDetailModel {
  let nickname: String
  let userID: String
  let profileImageURL: String
  let mealModel: MealModel
  
  let dateBefore: Int
}

struct ReviewDetailView_Previews: PreviewProvider {
  static var previews: some View {
    let dummyMealModel = MealModel(title: "동경산책 성신여대점",
                                   type: .일식,
                                   description: "ss",
                                   score: 4.0,
                                   doUserLike: false,
                                   imageURLs: ["fdsfads", "fdsafdas"],
                                   likesCount: 3)
    let reviewModel = ReviewDetailModel(nickname: "햄식이", userID: "4324324",
                                        profileImageURL: "fdsfads",
                                        mealModel: dummyMealModel,
                                        dateBefore: 3)
    ReviewDetailView(
      reviewModel: reviewModel,
      nextButtonTapped: {
        print("nextButtonTapped")
      },
      backButtonDidTapped: {
        print("backButtonDidTapped")
      }
    )
  }
}
