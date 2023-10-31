//
//  WriteReviewStoreSearchView.swift
//  EveryMeal_iOS
//
//  Created by 김하늘 on 2023/08/30.
//

import SwiftUI

enum ReviewStackViewType: Hashable {
  case searchView
  case starPointView(MealModel)
  case imageTextView(MealModel)
  case reviewDetail(ReviewDetailModel)
  
  func hash(into hasher: inout Hasher) {
    switch self {
    case .searchView:
      hasher.combine(0)
    case .starPointView(let mealModel):
      hasher.combine(1)
      hasher.combine(mealModel)
    case .imageTextView(let mealModel):
      hasher.combine(2)
      hasher.combine(mealModel)
    case .reviewDetail(let reviewDetailModel):
      hasher.combine(3)
      hasher.combine(reviewDetailModel)
    }
  }
}

struct WriteReviewStoreSearchView: View {
  @Environment(\.presentationMode) var presentationMode
  
  @State private var text: String = ""
  @State private var reviewNavigationStack: [ReviewStackViewType] = []
  @State var exitAlertPresent = false
  
  var closeButtonTapped: () -> Void
  
  var body: some View {
    NavigationStack(path: $reviewNavigationStack) {
      VStack(alignment: .center, spacing: 28) {
        CustomNavigationView(
          title: "리뷰 작성",
          rightItem: Image(systemName: "xmark"),
          rightItemTapped: {
            closeButtonTapped()
          })
        
        HStack(spacing: 0) {
          Text("다녀온 맛집은\n어디인가요?")
            .font(.system(size: 24, weight: .bold))
            .foregroundColor(Color.grey9)
            .padding(.leading, 20)
          Spacer()
        }
        
        HStack(spacing: 10) {
          Image("icon-search-mono")
            .frame(width: 24, height: 24)
            .padding(.leading, 16)
          Text("검색")
            .font(.system(size: 16, weight: .regular))
            .foregroundColor(Color.grey5)
          Spacer()
        }
        .frame(height: 48)
        .background(Color.grey1)
        .border(Color.grey2)
        .cornerRadius(12)
        .padding(.horizontal, 16)
        .onTapGesture {
          reviewNavigationStack.append(.searchView)
        }
        Spacer()
      }
      .navigationDestination(for: ReviewStackViewType.self) { stackViewType in
        switch stackViewType {
        case .searchView:
          let searchView = BestStoreSearchView(nextButtonTapped: { selectedMealModel in
            reviewNavigationStack.append(.starPointView(selectedMealModel))
          }, placeholder: "검색", backButtonDidTapped: {
            reviewNavigationStack.removeLast()
          })
          searchView
        case let .starPointView(mealModel):
          let startPointView = ReviewStarPointView(
            mealModel: mealModel,
            nextButtonTapped: { mealModel in
              reviewNavigationStack.append(.imageTextView(mealModel))
            },
            backButtonTapped: {
              reviewNavigationStack.removeLast()
            })
          startPointView
        case let .imageTextView(mealModel):
          let reviewWriteImageTextView = ReviewWriteImageTextView(
            mealModel: mealModel,
            saveButtonTapped: { reviewModel in
              // TODO: 토스트 노출
              reviewNavigationStack.append(.reviewDetail(reviewModel))
            },
            closeButtonTapped: {
              exitAlertPresent.toggle()
            })
          reviewWriteImageTextView
            .fullScreenCover(isPresented: $exitAlertPresent) {
              let alert = EverymealAlertView(
                title: "다음에 리뷰를 남길까요?",
                description: "지금까지 작성한 내용은 저장되지 않아요.",
                okButtonTitle: "계속 쓰기",
                cancelButtonTitle: "나가기",
                okButtonTapped: {
                  exitAlertPresent.toggle()
                },
                cancelButtonTapped: {
                  exitAlertPresent.toggle()
                  reviewNavigationStack.removeAll()
                })
              alert
            }
        case let .reviewDetail(reviewModel):
          let reviewDetailView = ReviewDetailView(
            reviewModel: reviewModel,
            backButtonDidTapped: {
              reviewNavigationStack.removeLast()
            })
          reviewDetailView
        }
      }
      .padding(.bottom)
      .navigationBarTitleDisplayMode(.inline)
      .navigationBarHidden(true)
    }
  }
}

struct WriteReviewStoreSearchView_Previews: PreviewProvider {
  static var previews: some View {
    WriteReviewStoreSearchView {
      print("close")
    }
  }
}
