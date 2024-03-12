//
//  ReportEntranceView.swift
//  EveryMeal_iOS
//
//  Created by 김광록 on 2/16/24.
//

import SwiftUI

struct ReportEntranceView: View {
  @Binding var isReportOpened: Bool
  @Binding var isReportReasonOpened: Bool
  
  var body: some View {
    HStack(spacing: 12) {
      Image("icon-siren-mono")
        .resizable()
        .frame(width: 24, height: 24)
      Text("신고하기")
        .font(.pretendard(size: 16, weight: .medium))
      Spacer()
    }
    .contentShape(Rectangle())
    .onTapGesture {
      isReportOpened = false
      isReportReasonOpened = true
    }
  }
}

#Preview {
  ReportEntranceView(isReportOpened: .constant(true), isReportReasonOpened: .constant(false))
}
