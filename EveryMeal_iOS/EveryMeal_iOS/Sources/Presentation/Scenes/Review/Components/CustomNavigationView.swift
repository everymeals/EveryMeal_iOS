//
//  CustomNavigationView.swift
//  EveryMeal_iOS
//
//  Created by 김하늘 on 10/21/23.
//

import SwiftUI

struct CustomNavigationView: View {
  var title: String
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
          .font(.pretendard(size: 16, weight: .medium))
        Spacer()
      }
    }
    .padding(.horizontal, 20)
    .padding(.vertical, 12)
    .frame(height: 48)
    .background(.white)
  }
}

struct CustomNavigationView_Previews: PreviewProvider {
  static var previews: some View {
    CustomNavigationView(
      title: "리뷰 작성",
      rightItem: Image(systemName: "xmark"),
      leftItem: Image("icon-arrow-left-small-mono"),
      rightItemTapped: {
        print("right item tapped")
      },
      leftItemTapped: {
        print("left item tapped")
      })
  }
}
