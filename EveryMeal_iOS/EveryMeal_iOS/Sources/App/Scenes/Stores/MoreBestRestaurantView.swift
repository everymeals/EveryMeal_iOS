//
//  MoreBestRestaurantView.swift
//  EveryMeal_iOS
//
//  Created by 김광록 on 2023/09/20.
//

import SwiftUI

struct MoreBestRestaurantView: View {
  @Environment(\.dismiss) private var dismiss

  let columns = [
    GridItem(.flexible())
  ]
  
  let data = Array(1...1000).map { "목록 \($0)"}
  
  var body: some View {
    VStack(spacing: 0) {
      FilterBarView()
      
      ScrollView {
        LazyVGrid(columns: columns) {
          BestRestaurantCell()
            .padding(.vertical, 16)
            .padding(.horizontal, 20)
          
          Rectangle()
            .frame(height: 1)
            .padding(.horizontal, 20)
            .foregroundColor(.grey2)
          
          BestRestaurantCell()
            .padding(.vertical, 16)
            .padding(.horizontal, 20)
          
          Rectangle()
            .frame(height: 1)
            .padding(.horizontal, 20)
            .foregroundColor(.grey2)
          
          BestRestaurantCell()
            .padding(.vertical, 16)
            .padding(.horizontal, 20)
          
          Rectangle()
            .frame(height: 1)
            .padding(.horizontal, 20)
            .foregroundColor(.grey2)
          
          BestRestaurantCell()
            .padding(.vertical, 16)
            .padding(.horizontal, 20)
          
        }
      }
      
      Spacer()
    }
    .padding(.bottom)
    .navigationTitle("맛집")
    .navigationBarTitleDisplayMode(.inline)
    .navigationBarBackButtonHidden()
    .toolbar {
      ToolbarItem(placement: .navigationBarLeading) {
        Button {
          dismiss()
        } label: {
          Image("icon-arrow-left-small-mono")
            .resizable()
            .frame(width: 24, height: 24)
        }
      }
    }
    
  }
}

struct MoreBestRestaurantView_Previews: PreviewProvider {
  static var previews: some View {
    HomeView()
  }
}

struct FilterBarView: View {
  var body: some View {
    HStack {
      HStack(alignment: .center, spacing: 4) {
        Text("최신순")
          .font(
            Font.custom("Pretendard", size: 14)
              .weight(.semibold)
          )
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
      
      HStack(alignment: .center, spacing: 4) {
        Text("필터")
          .font(
            Font.custom("Pretendard", size: 14)
              .weight(.semibold)
          )
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
      
      Spacer()
    }
    .padding(.horizontal, 20)
    .padding(.vertical, 8)
  }
}

struct BestRestaurantCell: View {
  @State var isPressed: Bool = false

  var body: some View {
    VStack(spacing: 10) {
      //            Rectangle()
      //              .fill(Color.yellow)
      //              .frame(height: 205)
      
      HStack(alignment: .center) {
        VStack(alignment: .leading, spacing: 6) {
          // 타이틀 + 음식점 타입
          HStack(alignment: .center, spacing: 4) {
            // 음식점 타이틀
            Text("짱마있는어쩌고저쩌꼬성신여대맛집")
              .font(
                Font.custom("Pretendard", size: 17)
                  .weight(.semibold)
              )
              .lineLimit(1)
              .foregroundColor(Color(red: 0.2, green: 0.24, blue: 0.29))
              .frame(maxWidth: 233, alignment: .topLeading)
            
            // 음식점 타입
            HStack(alignment: .center, spacing: 10) {
              Text("베이커리")
                .font(
                  Font.custom("Pretendard", size: 12)
                    .weight(.medium)
                )
                .foregroundColor(Color(red: 0.55, green: 0.58, blue: 0.63))
            }
            .padding(.horizontal, 6)
            .padding(.vertical, 3)
            .background(Color(red: 0.95, green: 0.96, blue: 0.96))
            .cornerRadius(4)
          }
          .frame(maxWidth: .infinity, alignment: .leading)
          
          // 별 + 별점
          HStack(alignment: .center, spacing: 2) {
            Image("icon-star-mono")
              .frame(width: 14, height: 14)
            
            Text("3.0 (5)")
              .font(
                Font.custom("Pretendard", size: 12)
                  .weight(.medium)
              )
              .foregroundColor(Color(red: 0.42, green: 0.46, blue: 0.52))
          }
        }
        .frame(maxWidth: .infinity, alignment: .topLeading)
        Spacer()
        
        // 좋아요 + 좋아요 cnt
        VStack(alignment: .center, spacing: 2) {
          let heartImage = isPressed ? "icon-heart-mono-bestRestaurant-fill" : "icon-heart-mono-bestRestaurant"
          Image(heartImage)
            .resizable()
            .frame(width: 24, height: 24)
            .onTapGesture {
              isPressed.toggle()
            }
          
          Text("0")
            .font(
              Font.custom("Pretendard", size: 12)
                .weight(.medium)
            )
            .foregroundColor(isPressed ? Color.everyMealRed : Color.grey4)
        }
        .padding(10)
      }
      .frame(width: 335, alignment: .center)
      
      HStack(alignment: .top, spacing: 11) {
        ZStack {
          EmptyView()
        }
        .frame(width: 104, height: 100)
        .background(
          //                 Image("PATH_TO_IMAGE")
          Rectangle()
          //                  .resizable()
          //                  .aspectRatio(contentMode: .fill)
            .frame(width: 104, height: 100)
            .clipped()
        )
        .background(Color(red: 0.95, green: 0.96, blue: 0.96))
        .cornerRadius(8)
        ZStack {
          EmptyView()
        }
        .frame(width: 104, height: 100)
        .background(
          //                 Image("PATH_TO_IMAGE")
          Rectangle()
          //                  .resizable()
          //                  .aspectRatio(contentMode: .fill)
            .frame(width: 104, height: 100)
            .clipped()
        )
        .background(Color(red: 0.95, green: 0.96, blue: 0.96))
        .cornerRadius(8)
        ZStack {
          EmptyView()
        }
        .frame(width: 104, height: 100)
        .background(
          //                 Image("PATH_TO_IMAGE")
          Rectangle()
          //                  .resizable()
          //                  .aspectRatio(contentMode: .fill)
            .frame(width: 104, height: 100)
            .clipped()
        )
        .background(Color(red: 0.95, green: 0.96, blue: 0.96))
        .cornerRadius(8)
      }
    }
  }
}
