//
//  ReviewDetailView.swift
//  EveryMeal_iOS
//
//  Created by 김하늘 on 10/16/23.
//

import SwiftUI

struct ReviewDetailView: View {
  
  // MARK: - States
  
  var storeName: String
  @State var storeReviewContent: StoreReviewContent
  @State var didClickedLikeButton: Bool = false
  
  // MARK: - Property
  
  var backButtonDidTapped: () -> Void
  var fontSize: CGFloat = 18
  var paddingSize: CGFloat { -(fontSize * 0.325) }
  
  var body: some View {
    VStack(alignment: .center, spacing: 0) {
      CustomNavigationView(
        title: "리뷰",
        leftItem: Image("icon-arrow-left-small-mono"),
        leftItemTapped: {
          backButtonDidTapped()
        }
      )
      ReviewUserProfileView(reviewModel: storeReviewContent)
      if let images = storeReviewContent.images {
        ReviewImagesView(storeName: storeName, urls: images)
          .aspectRatio(contentMode: .fit)
          .frame(width: UIScreen.main.bounds.width)
      }
      
      VStack(spacing: 40) {
        HStack {
          Text(storeReviewContent.content ?? "no review")
            .font(.pretendard(size: 15, weight: .regular))
            .foregroundColor(.grey8)
          Spacer()
        }

        if (storeReviewContent.images ?? []).isEmpty {
          ReviewTagView(tagName: storeName)
        }
        HStack(spacing: 6) {
          Image("icon-thumb-up-mono")
            .renderingMode(.template)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: 22)
            .foregroundColor(true ? .red : .grey5) // FIXME: 확인 후 수정 필요
          Text(String(describing: storeReviewContent.recommendedCount))
            .font(.pretendard(size: 16, weight: .semibold))
            .foregroundColor(true ? .red : .grey5) // FIXME: 확인 후 수정 필요
        }
        .onTapGesture {
          // FIXME: 임시 UI 처리. 추후 수정 필요
//          storeEntity.isLiked.toggle()
//          if storeEntity.isLiked {
//            storeEntity.recommendedCount += 1
//          } else {
//            storeEntity.recommendedCount -= 1
//          }
        }
        .padding(.vertical, 10)
        .padding(.horizontal, 21.5)
        .background(true ? Color.redLight : Color.grey2) // FIXME: 확인 후 수정 필요
        .clipShape(RoundedRectangle(cornerRadius: 8))
      }
        .padding(20)
        
      Spacer()
    }
    .navigationBarHidden(true)
  }
}

struct ReviewUserProfileView: View {
  @State var starChecked: [Bool] = Array(repeating: false, count: 5)
  var reviewModel: StoreReviewContent
  
  var body: some View {
    ZStack {
      HStack(spacing: 12) {
        if let profileURL = reviewModel.profileURL {
          AsyncImage(url: profileURL) { image in
            image.resizable()
              .frame(width: 40, height: 40, alignment: .center)
          } placeholder: {
            Image(systemName: "circle.fill")
              .resizable()
              .scaledToFit()
              .frame(maxWidth: 40)
              .foregroundColor(.gray)
          }
          .clipShape(Circle())
        }
        
        VStack(alignment: .leading, spacing: 2) {
          Text(reviewModel.nickName)
            .font(.pretendard(size: 12, weight: .semibold))
            .foregroundColor(.grey8)
          HStack(spacing: 2) {
            ForEach(starChecked.indices, id: \.self) { index in
              Image("icon-star-mono")
                .resizable()
                .renderingMode(.template)
                .foregroundColor(starChecked[index] ? Color.everyMealYellow : Color.grey3)
                .frame(width: 14, height: 14)
            }
            Text("·")
              .font(.pretendard(size: 12, weight: .semibold))
              .foregroundColor(.grey5)
            Text("\(reviewModel.dateBefore)일전")
              .font(.pretendard(size: 12, weight: .regular))
              .foregroundColor(.grey6)
          }
        }
        Spacer()
      }
      
      HStack {
        Spacer()
        VStack(alignment: .trailing) {
          Image("icon-dots-mono")
            .resizable()
            .frame(width: 24, height: 24)
            .padding(.bottom, 16)
        }
      }
    }
    .frame(height: 84)
    .padding(.horizontal, 20)
    .onAppear {
      starChecked.enumerated().forEach { startIndex, value in
        starChecked[startIndex] = startIndex < Int(reviewModel.grade)
      }
    }
  }
}

struct ReviewImagesView: View {
  @State private var currentPage: Int = 0
  var storeName: String
  
  var urls: [String]
  let defaultImageURL = "https://media.tarkett-image.com/large/TH_25094221_25187221_001.jpg"
  
  var body: some View {
    ZStack {
      ScrollView(.horizontal) {
        LazyHStack(spacing: 0) {
          ForEach(urls, id: \.self) { url in
            AsyncImage(url: URL(string: url)!) { image in
              image.resizable()
                .scaledToFit()
                .frame(width: UIScreen.main.bounds.width,
                       height: UIScreen.main.bounds.width,
                       alignment: .center)
            } placeholder: {
              Rectangle()
                .foregroundColor(.gray)
                .frame(width: UIScreen.main.bounds.width,
                       height: UIScreen.main.bounds.width,
                       alignment: .center)
            }
            
          }
        }
        .background(GeometryReader { geometry in
          Color.clear
            .preference(key: ScrollOffsetPreferenceKey.self, value: geometry.frame(in: .named("scroll")).origin)
        })
        .onPreferenceChange(ScrollOffsetPreferenceKey.self) { value in
          let offset = value.x == 0 ? 0 : -value.x
          let screenWidth = UIScreen.main.bounds.width
          let centerX = offset + (screenWidth / 2)
          currentPage = Int(floor(centerX/screenWidth) + 1)
        }
        
      }
      .coordinateSpace(name: "scroll")
      .frame(width: UIScreen.main.bounds.width,
             height: UIScreen.main.bounds.width,
             alignment: .center)
      
      VStack {
        Spacer()
        HStack(spacing: 0) {
          ReviewTagView(tagName: storeName)
          
          Spacer()
          
          Text("\(currentPage)/\(urls.count)")
            .font(.pretendard(size: 14, weight: .regular))
            .foregroundColor(.white)
            .padding(6)
            .frame(height: 25)
            .background(.ultraThinMaterial) // TODO: 시스템 블러로 대응해도 될지 논의 필요
            .clipShape(RoundedRectangle(cornerRadius: 20))
        }
        .padding(.horizontal, 14)
      }
      .padding(.bottom, 10)
    }
    .onAppear {
      UIScrollView.appearance().isPagingEnabled = true
      UIScrollView.appearance().showsHorizontalScrollIndicator = false
    }
  }
}

struct ReviewTagView: View {
  @State var tagName: String
  
  var body: some View {
    HStack {
      Image("icon-pin-location-mono")
        .renderingMode(.template)
        .resizable()
        .aspectRatio(contentMode: .fit)
        .foregroundColor(.white)
        .frame(width: 16)
        .padding(.trailing, 4)
      
      Text(tagName)
        .font(.pretendard(size: 14, weight: .medium))
        .lineLimit(1)
        .foregroundColor(.white)
      
      Image("icon-arrow-right-small-mono")
        .renderingMode(.template)
        .resizable()
        .aspectRatio(contentMode: .fit)
        .foregroundColor(.white)
        .frame(width: 14)
    }
    .padding(6)
    .background(.ultraThinMaterial) // TODO: 시스템 블러로 대응해도 될지 논의 필요
    .clipShape(RoundedRectangle(cornerRadius: 6))
  }
}

struct ScrollOffsetPreferenceKey: PreferenceKey {
    static var defaultValue: CGPoint = .zero
    static func reduce(value: inout CGPoint, nextValue: () -> CGPoint) { }
}

struct ReviewDetailModel: Hashable, Equatable {
  let nickname: String
  let userID: String
  let profileImageURL: String
  var storeModel: StoreEntity
  let dateBefore: Int
  
  static func == (lhs: ReviewDetailModel, rhs: ReviewDetailModel) -> Bool {
    return lhs.userID == rhs.userID && lhs.storeModel.name == rhs.storeModel.name
   }
}

struct ReviewDetailView_Previews: PreviewProvider {
  static var previews: some View {
    let dummyContent = StoreReviewContent(
      reviewIdx: 0,
      content: "사장님이 친절하시고 안주가 다 너무 맛있었습니다~! 분위기가 좋아서 다음에 또 갈 것 같아요!! 동기들이랑 여럿이서 가도 자리 넉넉하고 좋았어요!! ^_^",
      grade: 0,
      createdAt: "2024-02-25T10:02:40.954Z",
      nickName: "fdsafdsfsdfds",
      profileImageUrl: "https://crcf.cookatmarket.com/product/images/2019/11/tudi_1574662390_2739_720.jpg",
      recommendedCount: 0,
      images: [
        "https://crcf.cookatmarket.com/product/images/2019/11/tudi_1574662390_2739_720.jpg",
        "https://img.khan.co.kr/news/2023/04/20/news-p.v1.20230420.527bc9f1e42f4edfa5dec034ee3b91bd_P1.jpg"
      ])
    ReviewDetailView(
      storeName: "fds", 
      storeReviewContent: dummyContent,
      backButtonDidTapped: {
        print("backButtonDidTapped")
      }
    )
  }
}
