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
      CustomNavigationView(
        title: "리뷰",
        leftItem: Image("icon-arrow-left-small-mono"),
        leftItemTapped: {
          
        }
      )
      ReviewUserProfileView(reviewModel: reviewModel)
      ReviewImagesView(urls: reviewModel.mealModel.imageURLs)
      
      Spacer()
    }
    .navigationBarHidden(true)
  }
}

struct ReviewUserProfileView: View {
  var reviewModel: ReviewDetailModel
  @State var starChecked: [Bool] = Array(repeating: false, count: 5)
  
  var body: some View {
    ZStack {
      HStack(spacing: 12) {
        AsyncImage(url: URL(string: reviewModel.profileImageURL)!) { image in
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
        
        VStack(alignment: .leading, spacing: 2) {
          Text(reviewModel.nickname)
            .font(.system(size: 12, weight: .semibold))
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
              .font(.system(size: 12, weight: .semibold))
              .foregroundColor(.grey5)
            Text("\(reviewModel.dateBefore)일전")
              .font(.system(size: 12, weight: .regular))
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
      UIScrollView.appearance().isPagingEnabled = true
      UIScrollView.appearance().showsHorizontalScrollIndicator = false
      starChecked.enumerated().forEach { startIndex, value in
          starChecked[startIndex] = startIndex < reviewModel.mealModel.likesCount
      }
    }
  }
}

struct ReviewImagesView: View {
  var urls: [String]?
  let defaultImageURL = "https://media.tarkett-image.com/large/TH_25094221_25187221_001.jpg"
  
  var body: some View {
    VStack(spacing: 0) {
      ZStack(alignment: .top) {
        ScrollView(.horizontal) {
          LazyHStack(spacing: 0) {
            ForEach(urls ?? [defaultImageURL], id: \.self) { url in
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
        }
        .frame(width: UIScreen.main.bounds.width,
               height: UIScreen.main.bounds.width,
               alignment: .center)
        VStack {
          HStack(spacing: 0) {
            HStack {
              Image("icon-pin-location-mono")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .foregroundColor(.white)
                .frame(width: 16)
                .padding(.trailing, 4)
              
              Text("만약 태그 이름이 길어지면 이렇게 보이게해주세요")
                .font(.system(size: 14, weight: .medium))
                .lineLimit(1)
                .foregroundColor(.white)
              
              Spacer()
              
              Image("icon-arrow-right-small-mono")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .foregroundColor(.white)
                .frame(width: 14)
            }
            .padding(6)
            .background(.ultraThinMaterial) // TODO: 시스템 블러로 대응해도 될지 논의 필요
            .clipShape(RoundedRectangle(cornerRadius: 6))
            
            Rectangle()
              .frame(width: 18)
              .foregroundColor(.clear)
            Spacer()
            
            Text("1/\(urls?.count ?? 1)")
              .font(.system(size: 14, weight: .regular))
              .foregroundColor(.white)
              .padding(6)
              .frame(height: 25)
              .background(.ultraThinMaterial) // TODO: 시스템 블러로 대응해도 될지 논의 필요
              .clipShape(RoundedRectangle(cornerRadius: 20))
          }
          .padding(.horizontal, 14)
          
        }
      }
      Spacer()
    }
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
                                   imageURLs: [
                                    "https://www.eatingwell.com/thmb/m5xUzIOmhWSoXZnY-oZcO9SdArQ=/1500x0/filters:no_upscale():max_bytes(150000):strip_icc()/article_291139_the-top-10-healthiest-foods-for-kids_-02-4b745e57928c4786a61b47d8ba920058.jpg",
                                    "https://crcf.cookatmarket.com/product/images/2019/11/tudi_1574662390_2739_720.jpg",
                                    "https://img.khan.co.kr/news/2023/04/20/news-p.v1.20230420.527bc9f1e42f4edfa5dec034ee3b91bd_P1.jpg"
                                   ],
                                   likesCount: 3)
    let reviewModel = ReviewDetailModel(nickname: "햄식이", userID: "4324324",
                                        profileImageURL: "https://images.unsplash.com/photo-1425082661705-1834bfd09dca?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1752&q=80",
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
