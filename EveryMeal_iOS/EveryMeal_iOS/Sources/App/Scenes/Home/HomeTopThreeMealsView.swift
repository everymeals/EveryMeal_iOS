//
//  HomeTopThreeMealsView.swift
//  EveryMeal_iOS
//
//  Created by 김하늘 on 2023/08/08.
//

import SwiftUI

struct HomeTopThreeMealsView: View {
  var body: some View {
    VStack(spacing: 8) {
      HStack(spacing: 0) {
        Text("맛집 모아보기")
          .font(.system(size: 20, weight: .bold))
          .foregroundColor(Color.black)
          .padding(.leading, 20)
          .padding(.top, 24)
        Spacer()
      }
      MeaslTopThreeView()
        Button {
          print("맛집 더 보러 가기")
        } label: {
          Text("맛집 더 보러 가기")
            .padding(.vertical, 13)
            .frame(maxWidth: .infinity)
            .overlay(
              RoundedRectangle(cornerRadius: 12)
                .inset(by: 0.5)
                .stroke(Color.everyMealRed, lineWidth: 1)
            )
        }
    }
  }
}

struct MeaslTopThreeView: View {
  
  let dummtModels: [MealModel] = [MealModel(title: "수아당",
                                            type: .분식,
                                            description: "ss",
                                            score: 3.0,
                                            doUserLike: true,
                                            imageURLs: ["fdsafdas", "fdsafdas", "fdsafdas"],
                                            likesCount: 24),
                                  MealModel(title: "동경산책 성신여대점",
                                            type: .일식,
                                            description: "ss",
                                            score: 4.0,
                                            doUserLike: false,
                                            imageURLs: ["fdsfads", "fdsafdas"],
                                            likesCount: 32),
                                  MealModel(title: "언앨리셰프",
                                            type: .양식,
                                            description: "ss",
                                            score: 2.5,
                                            doUserLike: false,
                                            imageURLs: nil,
                                            likesCount: 0)
  ]
  
  let columns = [
    GridItem(.flexible())
  ]
  
  var body: some View {
    ScrollView {
      LazyVGrid(columns: columns, spacing: 8) {
        ForEach(dummtModels.indices, id: \.self) { index in
          TopMealsView(mealModel: dummtModels[index])
          Spacer()
        }
      }
      }
    }
    .padding(20)
  }
}

struct TopMealsView: View {
  var mealModel: MealModel
  
  var body: some View {
    VStack(alignment: .leading, spacing: 0) {
      HStack(alignment: .center, spacing: 0) {
        VStack(alignment: .leading, spacing: 0) {
          HStack(alignment: .center, spacing: 4) {
            Text(mealModel.title)
              .foregroundColor(Color.grey9)
              .font(Font.system(size: 17, weight: .semibold))
            Text(mealModel.type.rawValue)
              .foregroundColor(Color.grey6)
              .font(.system(size: 12, weight: .medium))
              .padding(.horizontal, 6)
              .padding(.vertical, 3)
              .background(Color.grey2)
              .cornerRadius(4)
          }
          .padding(.bottom, 6)
          
          HStack(spacing: 0) {
            Image("icon-star-mono")
              .resizable()
              .frame(width: 14)
              .padding(.trailing, 2)
            Text(String(mealModel.score))
              .foregroundColor(Color.grey7)
              .font(.system(size: 12, weight: .medium))
            Text("(5)")
              .foregroundColor(Color.grey7)
              .font(.system(size: 12, weight: .medium))
            Spacer()
          }
        }
        Spacer()
        LikeButton(likesCount: mealModel.likesCount, isPressed: mealModel.doUserLike)
      }
      .padding(.bottom, 14)
      
      let imageColumn = Array(repeating: GridItem(.flexible()), count: 3)
      if let imageURLs = mealModel.imageURLs {
        LazyVGrid(columns: imageColumn) {
          ForEach(imageURLs.indices, id: \.self) { index in
            Rectangle()
              .foregroundColor(.clear)
              .frame(maxWidth: .infinity, minHeight: 104, maxHeight: 104)
              .background(
                ZStack {
                  Image("Rectangle 2")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 105, height: 104) // 추후 해상도로 대응
                  
                  if index == imageURLs.indices.last && imageURLs.count == 3 {
                    ZStack {
                      Rectangle()
                        .foregroundColor(.clear)
                        .frame(maxWidth: .infinity, minHeight: 104, maxHeight: 104)
                        .background(.black.opacity(0.4))
                        .cornerRadius(8)
                      Text("+ 18")
                        .font(.system(size: 16, weight: .medium))
                        .foregroundColor(Color.white)
                    }
                  }
                }
              )
              .cornerRadius(8)
          }
        }
      }
    }
  }
}

struct LikeButton: View {
  var likesCount: Int
  @State var isPressed: Bool = false
  
  var body: some View {
    Button(action: {
      isPressed = !isPressed
    }, label: {
      VStack(spacing: 2) {
        Image("icon-heart-mono")
          .renderingMode(.template)
          .foregroundColor(isPressed ? Color.everyMealRed : Color.grey4)
          .frame(width: 24)
          
        Text(String(likesCount))
          .foregroundColor(isPressed ? Color.everyMealRed : Color.grey4)
          .font(.system(size: 12, weight: .medium))
      }
    })
  }
}

struct MealModel {
  var title: String
  var type: MealType
  var description: String
  var score: Double
  var doUserLike: Bool
  var imageURLs: [String]?
  var likesCount: Int
}

enum MealType: String {
  case 분식
  case 일식
  case 한식
  case 양식
  case 중식
}


struct HomeTopThreeMealsView_Previews: PreviewProvider {
  static var previews: some View {
    HomeView()
  }
}
