//
//  ReviewStarPointView.swift
//  EveryMeal_iOS
//
//  Created by 김하늘 on 2023/09/11.
//

import SwiftUI

struct ReviewStarPointView: View {
  private let navigationHeight: CGFloat = 48
  
  @State var text: String = ""
  @State var starChecked = Array(repeating: false, count: 5)
  @State var isBubbleShown: Bool = true
  @State var mealModel: MealEntity
  var nextButtonTapped: (MealEntity) -> Void
  var backButtonTapped: () -> Void
  
  
  var body: some View {
    NavigationView {
      ZStack {
        VStack(alignment: .center, spacing: 28) {
          Spacer()
            .frame(height: 1)
          CustomNavigationView(
            title: "리뷰 작성",
            leftItem: Image("icon-arrow-left-small-mono"),
            leftItemTapped: {
              backButtonTapped()
            }
          )
          HStack(spacing: 0) {
            Text("다녀온 맛집은\n어떠셨나요?")
              .font(.pretendard(size: 24, weight: .bold))
              .foregroundColor(Color.grey9)
              .padding(.leading, 20)
            Spacer()
          }
          
          Spacer()
        }
        VStack(alignment: .center, spacing: 0) {
          Spacer()
          Text(mealModel.type.rawValue)
            .foregroundColor(Color.grey6)
            .font(.pretendard(size: 12, weight: .medium))
            .padding(.horizontal, 6)
            .padding(.vertical, 3)
            .background(Color.grey2)
            .cornerRadius(4)
            .padding(.bottom, 12)
          
          Text(mealModel.title)
            .foregroundColor(Color.grey9)
            .font(Font.pretendard(size: 18, weight: .bold))
            .lineLimit(1)
            .padding(.bottom, 50)
            .frame(width: 210)
          
          HStack(spacing: 2) {
            ForEach(starChecked.indices, id: \.self) { index in
              Image("icon-star-mono")
                .resizable()
                .renderingMode(.template)
                .foregroundColor(starChecked[index] ? Color.everyMealYellow : Color.grey3)
                .frame(width: 40, height: 40)
                .onTapGesture {
                  starChecked.enumerated().forEach { startIndex, value in
                    print("index  \(index), starIndex \(startIndex)")
                    starChecked[startIndex] = startIndex <= index
                    if startIndex == starChecked.count - 1 {
                      mealModel.score = Double(index+1)
                      DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        nextButtonTapped(mealModel)
                      }
                    }
                  }
                }
            }
          }
          .padding(.bottom, 14)
          SpeachBubbleView(text: "별점으로 평가해주세요!", isShown: $isBubbleShown)
          Spacer()
        }
        .frame(height: UIScreen.main.bounds.height - navigationHeight)
      }
    }
    .navigationBarHidden(true)
  }
}

struct SpeachBubbleView: View {
  var text: String
  var backgroundColor: Color = .redLight
  var textColor: Color = .red
  @Binding var isShown: Bool
  
  var body: some View {
    if isShown {
      VStack(spacing: 0) {
        Image("SpeakButtonPolygon")
          .resizable()
          .renderingMode(.template)
          .frame(width: 26, height: 26)
          .foregroundColor(backgroundColor)
          .padding(.bottom, -18)
        
        Text(text)
          .foregroundColor(textColor)
          .font(.pretendard(size: 12, weight: .medium))
          .padding(.horizontal, 10)
          .padding(.vertical, 7)
          .background(backgroundColor)
          .cornerRadius(6)
      }
    }
  }
}

struct ReviewStarPointView_Previews: PreviewProvider {
  static var previews: some View {
    let dummyMealEntity = MealEntity(title: "동경산책 성신여대점",
                                   type: .일식,
                                   description: "ss",
                                   score: 4.0,
                                   doUserLike: false,
                                   imageURLs: ["fdsfads", "fdsafdas"],
                                   likesCount: 3)
    ReviewStarPointView(
      mealModel: dummyMealEntity,
      nextButtonTapped: { _ in
        print("go next")
      }, backButtonTapped: {
        print("go back")
      })
  }
}
