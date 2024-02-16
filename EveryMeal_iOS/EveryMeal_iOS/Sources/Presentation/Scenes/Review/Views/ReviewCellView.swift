//
//  ReviewCellView.swift
//  EveryMeal_iOS
//
//  Created by 김광록 on 2/16/24.
//

import SwiftUI

struct ReviewCellView: View {
  var review: GetStoreReviewsContent
  
  @State var isReportOpened: Bool = false
  @State var isReportReasonOpened: Bool = false
  
  var body: some View {
    VStack(spacing: 12) {
      VStack(alignment: .leading, spacing: 9) {
        VStack(alignment: .leading, spacing: 14) {
          header
          reviewContent
        }
        reviewThumbsUpView
      }
      .sheet(isPresented: $isReportOpened, content: {
        VStack {
          CustomSheetView {
            ReportEntranceView(isReportOpened: $isReportOpened, isReportReasonOpened: $isReportReasonOpened)
          }
        }
        .presentationDetents([.height(100)])
        .presentationDragIndicator(.hidden)
      })
      .sheet(isPresented: $isReportReasonOpened, content: {
        VStack {
          CustomSheetView(title: "무엇으로 신고하시나요?") {
            ReportDetailView(isReportReasonOpened: $isReportReasonOpened)
          }
        }
        .presentationDetents([.height(330)])
        .presentationDragIndicator(.hidden)
      })
      
      moveMapButton
    }
    .padding(.horizontal, 0)
    .padding(.vertical, 16)
    .frame(maxWidth: .infinity, alignment: .leading)
  }
  
  private var header: some View {
    HStack(spacing: 12) {
      Circle().frame(width: 40, height: 40).foregroundColor(.grey5)
      VStack {
        VStack(alignment: .leading, spacing: 3.5) {
          Text(review.nickName ?? "")
            .font(.pretendard(size: 12, weight: .semibold))
            .foregroundStyle(Color.grey8)
          
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
            isReportOpened.toggle()
          }
      }
    }
  }
  
  private var reviewContent: some View {
    HStack(alignment: .top, spacing: 12) {
      Text(review.content ?? "")
        .font(.pretendard(size: 14))
        .foregroundColor(.grey8)
        .frame(maxWidth: .infinity, minHeight: 42, alignment: .topLeading)
        .padding(.top, 3)
        .lineLimit(3)
        .lineSpacing(6)
      
      if !((review.images?.isEmpty) == nil) {
        let imageURLString = "\((review.images?.first)!)"
        ZStack(alignment: .topTrailing) {
          AsyncImage(url: URL(string: imageURLString)!)
            .frame(width: 64, height: 64)
            .cornerRadius(8)
          
          let imagesCount = review.images?.count ?? 0
          if imagesCount > 1 {
            Text("+\(imagesCount - 1)")
              .font(.pretendard(size: 10, weight: .medium))
              .foregroundStyle(Color.white)
              .padding(4)
              .background(Color.black.opacity(0.5))
              .cornerRadius(4)
              .padding([.top, .trailing], 6)
          }
        }
      }
      
    }
  }
  
  private var reviewThumbsUpView: some View {
    HStack(spacing: 4) {
      Image("icon-thumb-up-mono")
      Text("\(review.reviewMarksCnt ?? 0)")
        .font(.pretendard(size: 14, weight: .medium))
        .foregroundColor(.grey6)
    }
    .onTapGesture {
      // TODO: 로티 애니메이션 적용
      print("좋아요 버튼")
    }
  }
  
  private var moveMapButton: some View {
    HStack {
      Image("icon-pin-location-mono")
      Text(review.storeName ?? "")
        .font(.pretendard(size: 14, weight: .semibold))
        .foregroundColor(.grey7)
        .lineLimit(0)
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
      print("\(review.storeName ?? "")를 선택함")
    }
  }
  
}

#Preview {
  ReviewCellView(review: Constants.dummyStoreReview)
}
