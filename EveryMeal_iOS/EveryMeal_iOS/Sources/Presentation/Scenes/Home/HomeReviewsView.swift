//
//  HomeReviewsView.swift
//  EveryMeal_iOS
//
//  Created by 김하늘 on 2023/08/08.
//

import SwiftUI
import Lottie

struct HomeReviewsView: View {
  var body: some View {
    VStack(alignment: .leading, spacing: 8) {
      HStack {
        Text("리뷰 모아보기")
          .font(.pretendard(size: 20, weight: .bold))
          .foregroundColor(Color.everyMealBlack)
          .padding(.top, 15)
        Spacer()
      }
      
      ReviewCellView()
      
      Rectangle()
        .frame(height: 1)
        .foregroundColor(.grey2)
      
      ReviewCellView()
      
      Rectangle()
        .frame(height: 1)
        .foregroundColor(.grey2)
      
      ReviewCellView()
      
    }
    .padding(.horizontal, 20)
    
  }
}

struct ReviewCellView: View {
  var body: some View {
    VStack(spacing: 12) {
      VStack(alignment: .leading, spacing: 9) {
        VStack(alignment: .leading, spacing: 14) {
          HStack(spacing: 12) {
            Circle().frame(width: 40, height: 40).foregroundColor(.grey5)
            VStack {
              VStack(alignment: .leading, spacing: 3.5) {
                Text("햄식이")
                HStack(spacing: 2) {
                  Image("icon-star-mono")
                  Image("icon-star-mono")
                  Image("icon-star-mono")
                  Image("icon-star-mono")
                  Image("icon-star-mono")
                  Text("·")
                    .font(.pretendard(size: 12, weight: .semibold))
                    .multilineTextAlignment(.center)
                    .foregroundColor(.grey5)
                  Text("3일전")
                    .font(.pretendard(size: 12, weight: .regular))
                    .foregroundColor(.grey5)
                }
              }
            }
            Spacer()
            VStack {
              Image("icon-dots-mono")
                .onTapGesture {
                  print("오른쪽 점 세개 버튼")
                }
              Spacer()
            }
          }
          
          HStack(spacing: 12) {
            // TODO: 오른쪽에 사진 없는 경우와 글이 3줄 미만인 경우 UI 잡기
            Text("매장 안쪽으로 들어가면 꽤 넓은 공간이 나와서 공부하기 좋아요 근데 전에 저녁에 왔을 때 있던 알바생 분은 친절하셨는데, 오전에 낮에 왔을 때 계신")
              .font(.pretendard(size: 14))
              .foregroundColor(.grey8)
              .frame(maxWidth: .infinity, minHeight: 63, maxHeight: 63, alignment: .topLeading)
              .lineLimit(3)
              .lineSpacing(6)
            
            Rectangle()
              .frame(width: 64, height: 64)
              .cornerRadius(8)
              .foregroundColor(.grey5)
          }
        }
        
        HStack(spacing: 4) {
          Image("icon-thumb-up-mono")
          Text("2")
            .font(.pretendard(size: 14, weight: .medium))
            .foregroundColor(.grey6)
        }
        .onTapGesture {
          // TODO: 로티 애니메이션 적용
          print("좋아요 버튼")
        }
      }
      
      HStack {
        Image("icon-pin-location-mono")
        Text("스타벅스 성신여대점")
          .font(.pretendard(size: 14, weight: .semibold))
          .foregroundColor(.grey7)
        Spacer()
        Image("icon-arrow-right-small-mono")
          .frame(width: 16, height: 16)
      }
      .frame(maxWidth: .infinity)
      .padding(.horizontal, 14)
      .padding(.vertical, 12)
      .background(Color.grey2)
      .cornerRadius(8)
      .onTapGesture {
        print("스타벅스 성신여대점")
      }
      
    }
    .padding(.horizontal, 0)
    .padding(.vertical, 16)
    .frame(maxWidth: .infinity, alignment: .leading)
  }
}

struct MoreReviewButton: View {
  var body: some View {
    HStack(alignment: .center, spacing: 10) {
      Text("리뷰 더 보러 가기")
        .foregroundColor(Color.everyMealRed)
        .padding(.vertical, 13)
        .frame(maxWidth: .infinity)
        .overlay(
          RoundedRectangle(cornerRadius: 12)
            .inset(by: 0.5)
            .stroke(Color.everyMealRed, lineWidth: 1)
        )
    }
    .padding(.bottom, 30)
  }
}

struct HomeReviewsView_Previews: PreviewProvider {
  static var previews: some View {
    HomeView()
  }
}
