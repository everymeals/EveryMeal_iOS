//
//  FilterBarView.swift
//  EveryMeal_iOS
//
//  Created by 김광록 on 2023/10/30.
//

import SwiftUI

struct FilterBarView: View {
  enum ViewType {
    case reviews
    case stores
  }
  
  @State var viewType: ViewType = .reviews
  @State var isSortOpened = false
  @State var isFilterOpened = false
  var completionHandler: (() -> Void)?
  
  var body: some View {
    HStack {
      HStack(alignment: .center, spacing: 4) {
        Text("최신순")
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
//        isSortOpened.toggle()
        completionHandler?()
      }
      .sheet(isPresented: $isSortOpened, content: {
        VStack {
          CustomSheetView(title: "무엇으로 신고하시나요?", buttonTitle: "확인") {
            VStack {
              HStack {
                Text("해당 가게와 무관한 리뷰")
                  .padding(.vertical, 14)
                Spacer()
                Image("icon-check-mono")
                  .renderingMode(.template)
                  .foregroundStyle(Color.grey4)
              }
              .contentShape(Rectangle())
              .onTapGesture {
                print("11")
              }
              HStack {
                Text("비속어 및 혐오 발언")
                  .padding(.vertical, 14)
                Spacer()
                Image("icon-check-mono")
                  .renderingMode(.template)
                  .foregroundStyle(Color.grey4)
              }
              .contentShape(Rectangle())
              .onTapGesture {
                print("22")
              }
              HStack {
                Text("음란성 게시물")
                  .padding(.vertical, 14)
                Spacer()
                Image("icon-check-mono")
                  .renderingMode(.template)
                  .foregroundStyle(Color.grey4)
              }
              .contentShape(Rectangle())
              .onTapGesture {
                print("33")
              }
            }
          }
        }
        .presentationDetents([.height(330)])
        .presentationDragIndicator(.hidden)
      })
//      .sheet(isPresented: $isSortOpened, content: {
//        VStack {
//          CustomSheetView(isPresented: $isSortOpened) {
//            HStack {
//              Image("icon-siren-mono")
//              Text("신고하기")
//              Spacer()
//            }
//          }
//        }
//        .presentationDetents([.height(126)])
//        .presentationDragIndicator(.hidden)
//      })
      
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
        //isFilterOpened.toggle()
        completionHandler?()
      }
      .alert(title: "이거는 버튼 하나 짜리\nddd\nddd\ndd", message: "하하하하하하하\n하하하하하하하\n하하하하하하하\n하하하하하하하\n하하하하하하하\n하하하하하하하\n하하하하하하하\n하하하하하하하\n하하하하하하하\n하하하하하하하\n하하하하하하하\n하하하하하하하\n하하하하하하하\n하하하하하하하\n하하하하하하하\n하하하하하하하\n하하하하하하하\n하하하하하하하\n하하하하하하하\n하하하하하하하\n하하하하하하하\n하하하하하하하\n하하하하하하하\n하하하하하하하\n하하하하하하하\n하하하하하하하\n하하하하하하하\n하하하하하하하\n하하하하하하하\n하하하하하하하\n하하하하하하하\n하하하하하하하\n하하하하하하하\n하하하하하하하\n하하하하하하하\n하하하하하하하\n하하하하하하하\n하하하하하하하\n하하하하하하하\n하하하하하하하\n하하하하하하하\n하하하하하하하\n하하하하하하하\n하하하하하하하\n하하하하하하하\n하하하하하하하\n하하하하하하하\n하하하하하하하\n하하하하하하하", dismissButton: CustomAlertButton(title: "버튼\n두줄"), isPresented: $isFilterOpened)
      
      Spacer()
    }
    .padding(.horizontal, 20)
    .padding(.vertical, 8)
    
  }
}

struct FilterBarView_Previews: PreviewProvider {
  static var previews: some View {
    FilterBarView()
  }
}
