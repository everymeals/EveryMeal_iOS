//
//  WriteReviewStoreSearchView.swift
//  EveryMeal_iOS
//
//  Created by 김하늘 on 2023/08/30.
//

import SwiftUI

struct WriteReviewStoreSearchView: View {
  @State var text: String = ""
  var closeButtonTapped: () -> Void
  @Environment(\.presentationMode) var presentationMode
  
  var body: some View {
    NavigationView {
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
        
        let searchView = BestStoreSearchView(placeholder: "검색", backButtonDidTapped: {
          presentationMode.wrappedValue.dismiss()
        })
        
        NavigationLink(destination: searchView) {
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
        }
        Spacer()
      }
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
