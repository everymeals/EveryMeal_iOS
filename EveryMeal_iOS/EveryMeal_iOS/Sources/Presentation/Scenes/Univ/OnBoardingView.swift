//
//  OnBoardingView.swift
//  EveryMeal_iOS
//
//  Created by 김광록 on 2023/11/07.
//

import SwiftUI
import Lottie

struct OnBoardingView: View {
  @State private var didFinishOnboarding = false
  @Binding var isNotUnivChosen: Bool

  struct Board {
    let image: String
    let title: String
  }
  
  struct Boards {
    let items: [Board] = [
      Board(image: "bowl", title: "우리 오늘 뭐먹지?"),
      Board(image: "everymeal_splash", title: ""),
      Board(image: "school", title: "학식에서\n학교 주변 맛집까지"),
      Board(image: "everymeal_logo", title: "에브리밀에서\n간편하게")
    ]
  }
  
  let boards = Boards()
  @State private var currentIndex = 0
  
  var body: some View {
    VStack {
      if didFinishOnboarding {
        ChooseUnivView(isNotUnivChosen: $isNotUnivChosen)
      } else {
        OnboardingTabView(currentIndex: $currentIndex, boards: boards)
        PageIndicator(currentIndex: $currentIndex, count: boards.items.count)
        OnBoardingNextButton(didFinishOnboarding: $didFinishOnboarding)
        
      }
    }
    
  }
}

// MARK: - Component Views (SubViews)

struct OnboardingTabView: View {
  @Binding var currentIndex: Int
  var boards: OnBoardingView.Boards
  
  var body: some View {
    TabView(selection: $currentIndex) {
      ForEach(boards.items.indices, id: \.self) { index in
        VStack {
          if boards.items[index].image == "everymeal_splash" {
            BaseLottieView(jsonName: boards.items[index].image)
              .frame(width: 200, height: 200)
          } else {
            Image(boards.items[index].image)
              .resizable()
              .scaledToFit()
              .tag(index)
              .clipped()
              .frame(width: 145, height: 145)
            
            Text(boards.items[index].title)
              .font(.pretendard(size: 22, weight: .bold))
              .multilineTextAlignment(.center)
              .lineSpacing(5)
              .padding(.top, 20)
          }
        }
      }
    }
    .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never)) // Hide default indicators
    .padding(.top, 60)
  }
}

struct PageIndicator: View {
  @Binding var currentIndex: Int
  var count: Int
  
  var body: some View {
    HStack(spacing: 8) {
      ForEach(0..<count, id: \.self) { index in
        Circle()
          .fill(currentIndex == index ? Color.everyMealRed : Color.grey3)
          .frame(width: 8, height: 8)
          .onTapGesture {
            currentIndex = index
          }
      }
    }
    .padding(.top, 40)
    .padding(.bottom, 90)
  }
}

struct OnBoardingNextButton: View {
  @Binding var didFinishOnboarding: Bool
  
  var body: some View {
    Button(action: {
      didFinishOnboarding = true
    }) {
      Text("시작하기")
        .font(.pretendard(size: 16, weight: .medium))
        .foregroundColor(.white)
        .frame(maxWidth: .infinity)
        .padding()
        .background(Color.everyMealRed)
        .cornerRadius(12)
    }
    .padding(.horizontal, 20)
    .padding(.bottom, DeviceManager.shared.hasPhysicalHomeButton ? 24 : 0)
  }
}

struct OnBoardingView_Previews: PreviewProvider {
  static var previews: some View {
    OnBoardingView(isNotUnivChosen: .constant(true))
  }
}
