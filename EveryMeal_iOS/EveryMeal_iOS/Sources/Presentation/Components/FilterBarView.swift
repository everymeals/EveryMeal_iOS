//
//  FilterBarView.swift
//  EveryMeal_iOS
//
//  Created by 김광록 on 2023/10/30.
//

import SwiftUI

struct FilterBarView: View {
  // FIXME: 나중에 확인 후 타입 분기가 필요 없을 시 제거할 것
  enum ViewType {
    case reviews
    case stores
  }
  
  @State var viewType: ViewType = .reviews
  @Binding var selectedSortOption: SortOption?
  var sortCompletionHandler: (() -> Void)?
  var filterCompletionHandler: (() -> Void)?
  
  var body: some View {
    HStack {
      HStack(alignment: .center, spacing: 4) {
        Text(selectedSortOption?.title ?? SortOption.registDate.title)
          .font(.pretendard(size: 14, weight: .semibold))
          .multilineTextAlignment(.center)
          .foregroundColor(Color(red: 0.42, green: 0.46, blue: 0.52))
        
        Image("icon-arrow-right-small-mono")
          .resizable()
          .frame(width: 12, height: 12)
          .rotationEffect(Angle(degrees: 90))
      }
      .padding(.horizontal, 12)
      .padding(.vertical, 6)
      .background(Color(red: 0.95, green: 0.96, blue: 0.96))
      .cornerRadius(100)
      .onTapGesture {
        sortCompletionHandler?()
      }
      
      HStack(alignment: .center, spacing: 4) {
        Text("필터")
          .font(.pretendard(size: 14, weight: .semibold))
          .multilineTextAlignment(.center)
          .foregroundColor(Color(red: 0.42, green: 0.46, blue: 0.52))
        
        Image("icon-arrow-right-small-mono")
          .resizable()
          .frame(width: 12, height: 12)
          .rotationEffect(Angle(degrees: 90))
      }
      .padding(.horizontal, 12)
      .padding(.vertical, 6)
      .background(Color(red: 0.95, green: 0.96, blue: 0.96))
      .cornerRadius(100)
      .onTapGesture {
        filterCompletionHandler?()
      }
      
      Spacer()
    }
    .padding(.horizontal, 20)
    .padding(.vertical, 8)
    
  }
}

struct FilterBarView_Previews: PreviewProvider {
  static var previews: some View {
    FilterBarView(selectedSortOption: .constant(.registDate))
  }
}
