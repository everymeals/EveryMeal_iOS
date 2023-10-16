//
//  ReviewStoreSearchListCell.swift
//  EveryMeal_iOS
//
//  Created by 김하늘 on 2023/09/23.
//

import SwiftUI

struct ReviewStoreSearchListRecentCell: View {
  @State var text: String
  var deleteButtonTapped: (() -> Void)
  
  var body: some View {
    HStack {
      Text(text)
      Spacer()
      Image(systemName: "xmark")
        .foregroundColor(Color.grey5)
        .onTapGesture {
          
        }
    }
    .frame(height: 52)
  }
}

struct ReviewStoreSearchListRecentCell_Previews: PreviewProvider {
  static var previews: some View {
    ReviewStoreSearchListRecentCell(text: "dsaasd", deleteButtonTapped: {
      print("delete!")
    })
  }
}

