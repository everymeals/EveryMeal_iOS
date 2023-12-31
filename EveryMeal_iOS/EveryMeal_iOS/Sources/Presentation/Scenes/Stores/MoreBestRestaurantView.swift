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
    NavigationView {
      VStack(spacing: 0) {
        FilterBarView(viewType: .stores)
        
        ScrollView(showsIndicators: false) {
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
    .toolbar(.hidden, for: .tabBar)
  }
}

struct MoreBestRestaurantView_Previews: PreviewProvider {
  static var previews: some View {
    @State var otherViewShowing = false
    HomeView(otherViewShowing: $otherViewShowing)
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
              .font(.pretendard(size: 17, weight: .semibold))
              .lineLimit(1)
              .foregroundColor(Color(red: 0.2, green: 0.24, blue: 0.29))
              .frame(maxWidth: 233, alignment: .topLeading)
            
            // 음식점 타입
            HStack(alignment: .center, spacing: 10) {
              Text("베이커리")
                .font(.pretendard(size: 12, weight: .semibold))
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
              .font(.pretendard(size: 12, weight: .semibold))
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
            .font(.pretendard(size: 12, weight: .semibold))
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
