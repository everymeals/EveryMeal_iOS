//
//  WriteReviewStoreSearchView.swift
//  EveryMeal_iOS
//
//  Created by 김하늘 on 2023/08/30.
//

import SwiftUI

enum ReviewStackViewType {
  case searchView
  case starPointView
  case imageTextView
  case reviewDetail
}

struct WriteReviewStoreSearchView: View {
  @State private var text: String = ""
  @State private var reviewNavigationStack: [ReviewStackViewType] = []
  @State var exitAlertPresent = false
  
  var closeButtonTapped: () -> Void
  @Environment(\.presentationMode) var presentationMode
  
  var body: some View {
    NavigationStack(path: $reviewNavigationStack) {
      VStack(alignment: .center, spacing: 28) {
        CustomNavigationView(
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
        let dummyMealModel = MealModel(title: "동경산책 성신여대점",
                                       type: .일식,
                                       description: "ss",
                                       score: 4.0,
                                       doUserLike: false,
                                       imageURLs: ["fdsfads", "fdsafdas"],
                                       likesCount: 3)
        switch stackViewType {
        case .searchView:
          let searchView = BestStoreSearchView(nextButtonTapped: {
            reviewNavigationStack.append(.starPointView)
          }, placeholder: "검색", backButtonDidTapped: {
            reviewNavigationStack.removeLast()
          })
          searchView
        case .starPointView:
          let startPointView = ReviewStarPointView(
            mealModel: dummyMealModel,
            nextButtonTapped: {
              reviewNavigationStack.append(.imageTextView)
            },
            backButtonTapped: {
              reviewNavigationStack.removeLast()
            })
          startPointView
        case .imageTextView, .reviewDetail:
          let reviewWriteImageTextView = ReviewWriteImageTextView(mealModel: dummyMealModel,
                                                                  nextButtonTapped: {
            print("next")
          },
          closeButtonTapped: {
            exitAlertPresent.toggle()
//            reviewNavigationStack.append(.exitAlert)
//            reviewNavigationStack.removeLast()
          })
          reviewWriteImageTextView
            .fullScreenCover(isPresented: $exitAlertPresent) {
              let alert = EverymealAlertView(
                title: "다음에 리뷰를 남길까요?",
                description: "지금까지 작성한 내용은 저장되지 않아요.",
                okButtonTitle: "계속 쓰기",
                cancelButtonTitle: "나가기",
                okButtonTapped: {
                  
                },
                cancelButtonTapped: {
                  exitAlertPresent.toggle()
                })
              alert
            }
        }
      }
      .padding(.bottom)
      .navigationBarTitleDisplayMode(.inline)
      .navigationBarHidden(true)
    }
  }
}

struct CustomNavigationView: View {
  var title: String = "리뷰 작성"
  var rightItem: Image?
  var leftItem: Image?
  var rightItemTapped: (() -> Void)?
  var leftItemTapped: (() -> Void)?
  
  var body: some View {
    ZStack {
      
      HStack(alignment: .center) {
        if let leftItem = leftItem {
          leftItem
            .renderingMode(.template)
            .foregroundColor(Color.grey5)
            .onTapGesture {
              guard let leftItemTapped = leftItemTapped else {
                return
              }
              leftItemTapped()
            }
        }
        Spacer()
        
        if let rightItem = rightItem {
          rightItem
            .foregroundColor(Color.grey5)
            .onTapGesture {
              guard let rightItemTapped = rightItemTapped else {
                return
              }
              rightItemTapped()
            }
        }
      }
      HStack {
        Spacer()
        Text(title)
          .font(.system(size: 16, weight: .medium))
        Spacer()
      }
    }
    .padding(.horizontal, 20)
    .padding(.vertical, 12)
    .frame(height: 48)
    .background(.white)
  }
}

struct WriteReviewStoreSearchView_Previews: PreviewProvider {
  static var previews: some View {
    WriteReviewStoreSearchView {
      print("close")
    }
  }
}
