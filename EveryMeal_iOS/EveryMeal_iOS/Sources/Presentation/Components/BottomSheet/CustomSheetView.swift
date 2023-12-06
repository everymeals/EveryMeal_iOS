//
//  CustomSheetView.swift
//  EveryMeal_iOS
//
//  Created by 김광록 on 12/6/23.
//

import SwiftUI

/// 사용 예시
///```swift
///.onTapGesture {
///  isPresented.toggle()
///}
///.sheet(isPresented: $isPresented, content: {
///  VStack {
///    CustomSheetView(title: "무엇으로 신고하시나요?", buttonTitle: "확인", isPresented: $isSortOpened) {
///      VStack {
///        HStack {
///          Text("해당 가게와 무관한 리뷰")
///            .padding(.vertical, 14)
///          Spacer()
///          Image("icon-check-mono")
///            .renderingMode(.template)
///            .foregroundStyle(Color.grey4)
///        }
///        HStack {
///          Text("비속어 및 혐오 발언")
///            .padding(.vertical, 14)
///          Spacer()
///          Image("icon-check-mono")
///            .renderingMode(.template)
///            .foregroundStyle(Color.grey4)
///        }
///        HStack {
///          Text("음란성 게시물")
///            .padding(.vertical, 14)
///          Spacer()
///          Image("icon-check-mono")
///            .renderingMode(.template)
///            .foregroundStyle(Color.grey4)
///        }
///      }
///    }
///  }
///  .presentationDetents([.height(330)])
///  .presentationDragIndicator(.hidden)
///})
///```
struct CustomSheetView<Content>: View where Content: View {
  @Environment(\.dismiss) var dismiss

  let title: String?
  let buttonTitle: String?
  let content: Content
  let buttonAction: () -> Void
  var bottomPadding: CGFloat {
    DeviceManager.shared.hasPhysicalHomeButton ? 10 : 0
  }
  
  init(title: String? = nil, buttonTitle: String? = nil, @ViewBuilder content: () -> Content, buttonAction: @escaping () -> Void = {}) {
    self.title = title
    self.buttonTitle = buttonTitle
    self.content = content()
    self.buttonAction = buttonAction
  }
  
  var body: some View {
    VStack {
      // Grabber
      Rectangle()
        .foregroundColor(.clear)
        .frame(width: 73, height: 6)
        .background(Color.grey3)
        .cornerRadius(30)
        .padding()
      
      // Optional Title
      if let title = title {
        HStack {
          Text(title)
            .font(.pretendard(size: 22, weight: .bold))
          Spacer()
        }
      }
      
      // Content
      content
      
      Spacer()
      
      // Optional Button
      if let buttonTitle = buttonTitle {
        Button(action: {
          buttonAction()
          dismiss()
        }, label: {
          Text(buttonTitle)
            .frame(maxWidth: .infinity)
            .padding()
            .background(Color.everyMealRed)
            .foregroundColor(.white)
            .cornerRadius(10)
            .padding(.bottom, bottomPadding)
        })
      }
    }
    .padding(.horizontal, 20)
    .background(Color.white)
  }
}


#Preview {
  FilterBarView()
}
