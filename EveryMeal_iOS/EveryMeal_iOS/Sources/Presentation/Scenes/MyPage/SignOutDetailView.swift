//
//  SignOutDetailView.swift
//  EveryMeal_iOS
//
//  Created by 김광록 on 11/23/23.
//

import SwiftUI

struct SignOutDetailView: View {
  @Environment(\.dismiss) private var dismiss
  @State var opinion: String = ""
  @State var isPresented: Bool = false
  @Binding var path: [MyPageNavigationViewType]

  var body: some View {
    VStack(spacing: 0) {
      HStack {
        Text("더 나은 에브리밀을 위해\n의견을 들려주세요")
          .font(.pretendard(size: 24, weight: .bold))
          .foregroundStyle(Color.grey9)
        
        Spacer()
      }
      .padding(.top, 28)
      .padding(.bottom, 24)
      .padding(.horizontal, 20)
      
      ZStack {
        RoundedRectangle(cornerRadius: 12)
          .foregroundStyle(Color.grey1)
          .frame(height: 96)
        
        TextField("탈퇴 이유를 입력해주세요", text: $opinion, axis: .vertical)
          .frame(height: 72, alignment: .topLeading)
          .font(.pretendard(size: 16))
          .padding(.horizontal, 16)
          .padding(.vertical, 12)
      }
      .padding(.horizontal, 20)
      
      Spacer()
      
      Button(action: {
        // 회원탈퇴 API
        print("탈퇴하기: \(opinion)")
        isPresented.toggle()
      }, label: {
        Text("탈퇴하기")
          .font(.pretendard(size: 16, weight: .medium))
          .foregroundStyle(Color.white)
          .frame(maxWidth: .infinity)
          .frame(height: 50)
          .background(Color.everyMealRed)
      })
      .padding(.bottom, 3)
      
    }
    .navigationTitle("탈퇴하기")
    .navigationBarTitleDisplayMode(.inline)
    .navigationBarBackButtonHidden()
    .onAppear {
      UINavigationBar.appearance().titleTextAttributes = [
        .font : UIFont(name: "Pretendard-Medium", size: 16)!,
        .foregroundColor : UIColor(red: 0.2, green: 0.24, blue: 0.29, alpha: 1)
      ]
    }
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
    .alert(
      title: "탈퇴가 완료되었어요",
      message: "그동안 에브리밀과 함께해주셔서 감사합니다.\n더 나은 서비스로 다시 만나요!",
      dismissButton: CustomAlertButton(
        title: "확인",
        action: {
          print("SplashView로 전환")
          path = []
        }
      ),
      isPresented: $isPresented
    )
  }
}

#Preview {
  SignOutDetailView(path: .constant([.withdrawalReason]))
}
