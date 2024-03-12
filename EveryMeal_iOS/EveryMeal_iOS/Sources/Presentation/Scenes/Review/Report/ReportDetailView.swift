//
//  ReportDetailView.swift
//  EveryMeal_iOS
//
//  Created by 김광록 on 2/16/24.
//

import SwiftUI

struct ReportDetailView: View {
  @State private var selectedOptionIndex: Int?
  @Binding var isReportReasonOpened: Bool
  
  let options = ["해당 가게와 무관한 리뷰", "비속어 및 혐오 발언", "음란성 게시물"]
  
  var body: some View {
    VStack(spacing: 20) {
      VStack(spacing: 8) {
        ForEach(options.indices, id: \.self) { index in
          reportOption(text: options[index], index: index)
        }
      }
      
      okButton
    }
  }
  
  @ViewBuilder
  private func reportOption(text: String, index: Int) -> some View {
    HStack {
      Text(text)
        .padding(.vertical, 14)
      Spacer()
      Image("icon-check-mono")
        .renderingMode(.template)
        .foregroundColor(selectedOptionIndex == index ? Color.everyMealRed : Color.grey4)
    }
    .contentShape(Rectangle())
    .onTapGesture {
      if selectedOptionIndex == index {
        selectedOptionIndex = nil
      } else {
        selectedOptionIndex = index
      }
    }
  }
  
  private var okButton: some View {
    Button(
      action: {
        Log.kkr("확인 클릭: \(selectedOptionIndex!)")
        isReportReasonOpened = false
        // TODO: 신고하기 API 추가
      }, label: {
        Text("확인")
          .frame(maxWidth: .infinity)
          .padding()
          .background((selectedOptionIndex != nil) ? Color.everyMealRed : Color.grey3)
          .foregroundColor(.white)
          .cornerRadius(10)
          .padding(.bottom, DeviceManager.shared.hasPhysicalHomeButton ? 10.0 : 0)
      }
    )
    .disabled(selectedOptionIndex == nil)
  }
  
}

#Preview {
  ReportDetailView(isReportReasonOpened: .constant(true))
}
