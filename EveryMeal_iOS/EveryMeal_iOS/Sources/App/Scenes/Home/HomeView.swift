//
//  HomeView.swift
//  EveryMeal_iOS
//
//  Created by 김광록 on 2023/07/24.
//

import SwiftUI

struct HomeView: View {
  var body: some View {
    VStack() {
      Image("Rectangle 2")
      List() {
        StoreCell()
        StoreCell()
        StoreCell()
        StoreCell()
        StoreCell()
        StoreCell()
        StoreCell()
        StoreCell()
      }.listStyle(.inset)
    }
    .padding()
  }
}

struct HomeView_Previews: PreviewProvider {
  static var previews: some View {
    HomeView()
  }
}

struct StoreCell: View {
  let phoneNumber = "02-123-4567"
  @State private var showingSheet = false

  var body: some View {
    VStack(alignment: .leading) {
      Text("아방궁")
        .font(.title2)
      HStack {
        Text("강남구 역삼로1길 18, 평익빌딩 옆에")
          .lineLimit(1)
          .foregroundColor(.gray)
          .padding(5)
        Spacer()
        HStack {
          Image(systemName: "phone")
          Text(phoneNumber)
            .lineLimit(1)
        }
        .foregroundColor(.blue)
        .padding(5)
        .onTapGesture {
          showingSheet = true
        }
      }
      .actionSheet(isPresented: $showingSheet) {
          ActionSheet(
            title: Text("전화를 거시겠습니까?"),
            buttons: [
              .default(Text("\(phoneNumber)"), action: {
                if let url = URL(string: "https://www.naver.com") {
                  UIApplication.shared.open(url, options: [:], completionHandler: nil)
                }
              }),
              .cancel(Text("취소"))
            ]
          )
      }
    }
  }
}

struct ToastView: View {
  var body: some View {
    Text("Hello, Toast!")
      .font(.headline)
      .padding()
      .background(Color.black)
      .foregroundColor(.white)
      .cornerRadius(10)
  }
}

