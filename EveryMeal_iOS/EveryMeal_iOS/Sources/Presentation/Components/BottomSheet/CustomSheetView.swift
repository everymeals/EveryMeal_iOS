//
//  CustomSheetView.swift
//  EveryMeal_iOS
//
//  Created by 김광록 on 12/6/23.
//

import SwiftUI

/// `CustomSheetView`는 선택적인 제목과 버튼 구성 요소를 제공하며, 커스텀 가능한 컨텐츠를 포함합니다.
///
/// - 매개변수:
///   - title: 시트의 제목으로 사용될 선택적 `String`. 기본값은 `nil`.
///   - buttonTitle: 하단 버튼의 제목으로 사용될 선택적 `String`. 기본값은 `nil`.
///   - content: 시트에 표시될 컨텐츠를 반환하는 클로저.
///   - buttonAction: 버튼의 동작을 정의하는 선택적 클로저. 기본값은 빈 클로저.
///
/// 이 구조체는 상단에 그래버 인디케이터, 선택적인 제목과 버튼, 그리고 커스텀 가능한 컨텐츠 영역으로 일관된 레이아웃을 제공합니다.
/// 제공된 경우, 하단 버튼에는 시트를 닫는 기본 동작이 포함됩니다.
/// 기기에 물리 홈 버튼이 있는 경우 버튼 하단에 추가적인 패딩이 적용됩니다.
///
/// 사용 예시:
/// ```swift
/// CustomSheetView(title: "샘플 제목", buttonTitle: "닫기") {
///     Text("여기에 컨텐츠")
/// } buttonAction: {
///     // 여기에 버튼 동작 정의
/// }
/// ```
///
/// 뷰의 본문은 그래버, 제목, 컨텐츠, 버튼의 레이아웃을 관리하는 `VStack`을 포함합니다.
/// 초기화 매개변수를 통해 뷰의 외관과 동작을 커스텀할 수 있습니다.
struct CustomSheetView<Content>: View where Content: View {

  let title: String?
  let buttonTitle: String?
  let isButtonEnabled: Bool?
  let content: Content
  let buttonAction: () -> Void
  let backgroundTouchAction: () -> Void
  var bottomPadding: CGFloat {
    DeviceManager.shared.hasPhysicalHomeButton ? 10 : 0
  }
  
  init(title: String? = nil, buttonTitle: String? = nil, isButtonEnabled: Bool? = true, @ViewBuilder content: () -> Content, buttonAction: @escaping () -> Void = {}, backgroundTouchAction: @escaping () -> Void = {}) {
    self.title = title
    self.buttonTitle = buttonTitle
    self.isButtonEnabled = isButtonEnabled
    self.content = content()
    self.buttonAction = buttonAction
    self.backgroundTouchAction = backgroundTouchAction
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
        }, label: {
          Text(buttonTitle)
            .frame(maxWidth: .infinity)
            .padding()
            .background((isButtonEnabled ?? true) ? Color.everyMealRed : Color.grey3)
            .foregroundColor(.white)
            .cornerRadius(10)
            .padding(.bottom, bottomPadding)
        })
        .disabled(!(isButtonEnabled ?? true))
      }
    }
    .padding(.horizontal, 20)
    .background(Color.white)
  }
}


#Preview {
  FilterBarView()
}
