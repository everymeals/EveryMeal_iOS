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
  
  // MARK: - preview를 위한 dummy data -> 나중에 지우는게 좋을듯.. 너무 지저분함
  
  static let dummyStore = StoreEntity(name: "동경산책 성신여대점", categoryDetail: "일식", grade: 4.0, reviewCount: 23, recommendedCount: 3, images: ["fdsfads", "fdsafdas"], isLiked: false, description: "dummy")
  
  /// 학생 식당 리뷰 더미 데이터 (리스트)
  static let dummyUnivStoreReview = UnivStoreReviewInfo(
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
  )
  
  /// 학생 식당 리뷰 더미 데이터
  static let dummyUnivStoreReviews = [
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
  
  /// 주변 맛집 리뷰 더미 데이터 (1개)
  static let dummyStoreReview = GetStoreReviewsContent(
    reviewIdx: 14,
    content: "오늘 학식 진짜 미침...안먹으면 땅을 치고 후회함",
    grade: 1,
    createdAt: "2023-12-17T16:19:24.532839",
    formattedCreatedAt: "12월 17일",
    nickName: "연유크림",
    profileImageUrl: "https://everymeal-s3-buket.s3.ap-northeast-2.amazonaws.com/dev/user/bc90af33-bc6a-4009-bfc8-2c3efe0b16bd",
    reviewMarksCnt: 0,
    images: [
      "https://everymeal-s3-buket.s3.ap-northeast-2.amazonaws.com/dev/store/d5dfed0f-c3c3-43e0-a9d3-88f213bd1a4b",
      "https://everymeal-s3-buket.s3.ap-northeast-2.amazonaws.com/dev/store/d5dfed0f-c3c3-43e0-a9d3-88f213bd1a4b",
      "https://everymeal-s3-buket.s3.ap-northeast-2.amazonaws.com/dev/store/ea9be6e1-c5cb-4772-a5a8-15bb89b604a0",
      "https://everymeal-s3-buket.s3.ap-northeast-2.amazonaws.com/dev/store/d5dfed0f-c3c3-43e0-a9d3-88f213bd1a4b",
      "https://everymeal-s3-buket.s3.ap-northeast-2.amazonaws.com/dev/store/ea9be6e1-c5cb-4772-a5a8-15bb89b604a0",
      "https://everymeal-s3-buket.s3.ap-northeast-2.amazonaws.com/dev/store/2fc69eae-7b63-4b72-9bcd-1ba009ac842a",
      "https://everymeal-s3-buket.s3.ap-northeast-2.amazonaws.com/dev/store/d5dfed0f-c3c3-43e0-a9d3-88f213bd1a4b",
      "https://everymeal-s3-buket.s3.ap-northeast-2.amazonaws.com/dev/store/ea9be6e1-c5cb-4772-a5a8-15bb89b604a0",
      "https://everymeal-s3-buket.s3.ap-northeast-2.amazonaws.com/dev/store/ea9be6e1-c5cb-4772-a5a8-15bb89b604a0",
      "https://everymeal-s3-buket.s3.ap-northeast-2.amazonaws.com/dev/store/2fc69eae-7b63-4b72-9bcd-1ba009ac842a",
      "https://everymeal-s3-buket.s3.ap-northeast-2.amazonaws.com/dev/store/ea9be6e1-c5cb-4772-a5a8-15bb89b604a0",
      "https://everymeal-s3-buket.s3.ap-northeast-2.amazonaws.com/dev/store/d5dfed0f-c3c3-43e0-a9d3-88f213bd1a4b",
      "https://everymeal-s3-buket.s3.ap-northeast-2.amazonaws.com/dev/store/ea9be6e1-c5cb-4772-a5a8-15bb89b604a0",
      "https://everymeal-s3-buket.s3.ap-northeast-2.amazonaws.com/dev/store/d5dfed0f-c3c3-43e0-a9d3-88f213bd1a4b",
      "https://everymeal-s3-buket.s3.ap-northeast-2.amazonaws.com/dev/store/ea9be6e1-c5cb-4772-a5a8-15bb89b604a0",
      "https://everymeal-s3-buket.s3.ap-northeast-2.amazonaws.com/dev/store/2fc69eae-7b63-4b72-9bcd-1ba009ac842a",
      "https://everymeal-s3-buket.s3.ap-northeast-2.amazonaws.com/dev/store/d5dfed0f-c3c3-43e0-a9d3-88f213bd1a4b",
      "https://everymeal-s3-buket.s3.ap-northeast-2.amazonaws.com/dev/store/ea9be6e1-c5cb-4772-a5a8-15bb89b604a0",
      "https://everymeal-s3-buket.s3.ap-northeast-2.amazonaws.com/dev/store/ea9be6e1-c5cb-4772-a5a8-15bb89b604a0",
      "https://everymeal-s3-buket.s3.ap-northeast-2.amazonaws.com/dev/store/2fc69eae-7b63-4b72-9bcd-1ba009ac842a",
      "https://everymeal-s3-buket.s3.ap-northeast-2.amazonaws.com/dev/store/ea9be6e1-c5cb-4772-a5a8-15bb89b604a0",
      "https://everymeal-s3-buket.s3.ap-northeast-2.amazonaws.com/dev/store/d5dfed0f-c3c3-43e0-a9d3-88f213bd1a4b",
      "https://everymeal-s3-buket.s3.ap-northeast-2.amazonaws.com/dev/store/ea9be6e1-c5cb-4772-a5a8-15bb89b604a0",
      "https://everymeal-s3-buket.s3.ap-northeast-2.amazonaws.com/dev/store/d5dfed0f-c3c3-43e0-a9d3-88f21"
    ],
    storeIdx: 386,
    storeName: "히포 브런치하우스"
  )
  
  /// 주변 맛집 리뷰 더미 데이터
  static let dummyStoreReviews = [
    GetStoreReviewsContent(
      reviewIdx: 14,
      content: "오늘 학식 진짜 미침...안먹으면 땅을 치고 후회함",
      grade: 1,
      createdAt: "2023-12-17T16:19:24.532839",
      formattedCreatedAt: "12월 17일",
      nickName: "연유크림",
      profileImageUrl: "https://everymeal-s3-buket.s3.ap-northeast-2.amazonaws.com/dev/user/bc90af33-bc6a-4009-bfc8-2c3efe0b16bd",
      reviewMarksCnt: 0,
      images: [
        "https://everymeal-s3-buket.s3.ap-northeast-2.amazonaws.com/dev/store/d5dfed0f-c3c3-43e0-a9d3-88f213bd1a4b",
        "https://everymeal-s3-buket.s3.ap-northeast-2.amazonaws.com/dev/store/d5dfed0f-c3c3-43e0-a9d3-88f213bd1a4b",
        "https://everymeal-s3-buket.s3.ap-northeast-2.amazonaws.com/dev/store/ea9be6e1-c5cb-4772-a5a8-15bb89b604a0",
        "https://everymeal-s3-buket.s3.ap-northeast-2.amazonaws.com/dev/store/d5dfed0f-c3c3-43e0-a9d3-88f213bd1a4b",
        "https://everymeal-s3-buket.s3.ap-northeast-2.amazonaws.com/dev/store/ea9be6e1-c5cb-4772-a5a8-15bb89b604a0",
        "https://everymeal-s3-buket.s3.ap-northeast-2.amazonaws.com/dev/store/2fc69eae-7b63-4b72-9bcd-1ba009ac842a",
        "https://everymeal-s3-buket.s3.ap-northeast-2.amazonaws.com/dev/store/d5dfed0f-c3c3-43e0-a9d3-88f213bd1a4b",
        "https://everymeal-s3-buket.s3.ap-northeast-2.amazonaws.com/dev/store/ea9be6e1-c5cb-4772-a5a8-15bb89b604a0",
        "https://everymeal-s3-buket.s3.ap-northeast-2.amazonaws.com/dev/store/ea9be6e1-c5cb-4772-a5a8-15bb89b604a0",
        "https://everymeal-s3-buket.s3.ap-northeast-2.amazonaws.com/dev/store/2fc69eae-7b63-4b72-9bcd-1ba009ac842a",
        "https://everymeal-s3-buket.s3.ap-northeast-2.amazonaws.com/dev/store/ea9be6e1-c5cb-4772-a5a8-15bb89b604a0",
        "https://everymeal-s3-buket.s3.ap-northeast-2.amazonaws.com/dev/store/d5dfed0f-c3c3-43e0-a9d3-88f213bd1a4b",
        "https://everymeal-s3-buket.s3.ap-northeast-2.amazonaws.com/dev/store/ea9be6e1-c5cb-4772-a5a8-15bb89b604a0",
        "https://everymeal-s3-buket.s3.ap-northeast-2.amazonaws.com/dev/store/d5dfed0f-c3c3-43e0-a9d3-88f213bd1a4b",
        "https://everymeal-s3-buket.s3.ap-northeast-2.amazonaws.com/dev/store/ea9be6e1-c5cb-4772-a5a8-15bb89b604a0",
        "https://everymeal-s3-buket.s3.ap-northeast-2.amazonaws.com/dev/store/2fc69eae-7b63-4b72-9bcd-1ba009ac842a",
        "https://everymeal-s3-buket.s3.ap-northeast-2.amazonaws.com/dev/store/d5dfed0f-c3c3-43e0-a9d3-88f213bd1a4b",
        "https://everymeal-s3-buket.s3.ap-northeast-2.amazonaws.com/dev/store/ea9be6e1-c5cb-4772-a5a8-15bb89b604a0",
        "https://everymeal-s3-buket.s3.ap-northeast-2.amazonaws.com/dev/store/ea9be6e1-c5cb-4772-a5a8-15bb89b604a0",
        "https://everymeal-s3-buket.s3.ap-northeast-2.amazonaws.com/dev/store/2fc69eae-7b63-4b72-9bcd-1ba009ac842a",
        "https://everymeal-s3-buket.s3.ap-northeast-2.amazonaws.com/dev/store/ea9be6e1-c5cb-4772-a5a8-15bb89b604a0",
        "https://everymeal-s3-buket.s3.ap-northeast-2.amazonaws.com/dev/store/d5dfed0f-c3c3-43e0-a9d3-88f213bd1a4b",
        "https://everymeal-s3-buket.s3.ap-northeast-2.amazonaws.com/dev/store/ea9be6e1-c5cb-4772-a5a8-15bb89b604a0",
        "https://everymeal-s3-buket.s3.ap-northeast-2.amazonaws.com/dev/store/d5dfed0f-c3c3-43e0-a9d3-88f21"
      ],
      storeIdx: 386,
      storeName: "히포 브런치하우스"
    ),
    GetStoreReviewsContent(
      reviewIdx: 15,
      content: "오늘 학식 진짜 미침...안먹으면 땅을 치고 후회함",
      grade: 2,
      createdAt: "2023-12-17T16:21:05.075552",
      formattedCreatedAt: "12월 17일",
      nickName: "연유크림",
      profileImageUrl: "https://everymeal-s3-buket.s3.ap-northeast-2.amazonaws.com/dev/user/bc90af33-bc6a-4009-bfc8-2c3efe0b16bd",
      reviewMarksCnt: 0,
      images: nil,
      storeIdx: 386,
      storeName: "히포 브런치하우스"
    ),
    GetStoreReviewsContent(
      reviewIdx: 16,
      content: "오늘 학식 진짜 미침...안먹으면 땅을 치고 후회함",
      grade: 5,
      createdAt: "2023-12-25T21:20:18.871012",
      formattedCreatedAt: "12월 25일",
      nickName: "연유크림",
      profileImageUrl: "https://everymeal-s3-buket.s3.ap-northeast-2.amazonaws.com/dev/user/bc90af33-bc6a-4009-bfc8-2c3efe0b16bd",
      reviewMarksCnt: 0,
      images: nil,
      storeIdx: 386,
      storeName: "히포 브런치하우스"
    )
  ]
  
}
