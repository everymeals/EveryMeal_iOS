//
//  SortOptionView.swift
//  EveryMeal_iOS
//
//  Created by 김광록 on 2/9/24.
//

import SwiftUI

enum SortOption: String, CaseIterable {
  case popularity = "인기순"
  case distance = "거리순"
  case registDate = "최신순"
  
  var title: String {
    return self.rawValue
  }

  var toOrderType: CampusStoreOrderType {
    switch self {
    case .popularity: return .recommendedCount
    case .distance: return .distance
    case .registDate: return .registDate
    }
  }

}

struct SortOptionView: View {
  var option: SortOption
  var isSelected: Bool
  var action: (SortOption) -> Void
  
  var body: some View {
    HStack {
      Text(option.title)
        .font(.pretendard(size: 17, weight: .semibold))
        .foregroundStyle(Color.grey9)
      
      Spacer()
      
      if isSelected {
        Image("icon-check-mono")
          .renderingMode(.template)
          .foregroundStyle(Color.everyMealRed)
      }
    }
    .contentShape(Rectangle())
    .onTapGesture {
      action(option)
    }
    .padding(.vertical, 14)
    .padding(.horizontal, 24)
  }
}

#Preview {
  SortOptionView(option: .registDate, isSelected: true) { option in
    print("\(option.title) 선택됨")
  }
}
