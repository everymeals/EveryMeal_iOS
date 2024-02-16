//
//  Constants.swift
//  EveryMeal_iOS
//
//  Created by 김하늘 on 10/12/23.
//

import UIKit

enum Constants {
  static var tabBarHeight: CGFloat = UITabBar.appearance().frame.height
  static var bottomSafeArea: CGFloat = 34
  
  // MARK: preview를 위한 dummy data
  static var dummyStore = StoreEntity(name: "동경산책 성신여대점", categoryDetail: "일식", grade: 4.0, reviewCount: 23, recommendedCount: 3, images: ["fdsfads", "fdsafdas"], isLiked: false, description: "dummy")
  
  static var dummyReviews = [
    UnivStoreReviewInfo(
      reviewIdx: 40,
      restaurantName: "MCC 식당",
      nickName: "yhy5913@gmail.com",
      profileImage: "https://everymeal-s3-buket.s3.ap-northeast-2.amazonaws.com/dev/user/bc90af33-bc6a-4009-bfc8-2c3efe0b16bd",
      isTodayReview: false,
      grade: 5,
      content: "이미지 리뷰 테스트 중인데, 암튼 비빔밥 최고",
      imageList: ["meal/df393b21-5e59-4c8d-9881-f46ac79d9ed9"],
      reviewMarksCnt: 0,
      createdAt: "5일 전"
    ),
    UnivStoreReviewInfo(
      reviewIdx: 20,
      restaurantName: "MCC 식당",
      nickName: "띵지",
      profileImage: "https://everymeal-s3-buket.s3.ap-northeast-2.amazonaws.com/dev/user/bc90af33-bc6a-4009-bfc8-2c3efe0b16bd",
      isTodayReview: true,
      grade: 1,
      content: "이것은 학식이 아니여",
      imageList: [],
      reviewMarksCnt: 1,
      createdAt: "1월 7일"
    ),
    UnivStoreReviewInfo(
      reviewIdx: 13,
      restaurantName: "MCC 식당",
      nickName: "연유크림",
      profileImage: "https://everymeal-s3-buket.s3.ap-northeast-2.amazonaws.com/dev/user/bc90af33-bc6a-4009-bfc8-2c3efe0b16bd",
      isTodayReview: true,
      grade: 4,
      content: "새해 첫 학식... 나쁘지 않음",
      imageList: [],
      reviewMarksCnt: 0,
      createdAt: "1월 2일"
    )
  ]
}
