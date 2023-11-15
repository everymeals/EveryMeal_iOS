//
//  SplashView.swift
//  EveryMeal_iOS
//
//  Created by 김광록 on 2023/07/23.
//

import SwiftUI
import Lottie

struct SplashView: View {
  @State private var didFinishedLoading = false
  @State private var showingAlert = false
  @State private var alertMessage = ""
  
  var body: some View {
    VStack {
      if didFinishedLoading {
        MainTabBarView()
      } else {
        BaseLottieView(jsonName: "everymeal_splash", loopMode: .playOnce)
          .frame(width: 250, height: 250)
          .offset(y: -50)
          .onAppear {
            startLottieAnimation()
          }
      }
    }
    .edgesIgnoringSafeArea(.all)
    .alert(isPresented: $showingAlert) {
      Alert(
        title: Text(""),
        message: Text(alertMessage),
        primaryButton: .default(Text("재시도"), action: {
          startLottieAnimation()  // performAPIFetch를 재시도
        }),
        secondaryButton: .cancel(Text("취소"), action: {
          
        })
      )
    }
  }
  
  private func startLottieAnimation() {
    // 애니메이션의 completion handler 내에서 API 호출을 수행합니다.
    // 예를 들어, BaseLottieView가 애니메이션 완료 콜백을 제공하는 경우 다음과 같이 사용할 수 있습니다.
    performAPIFetch { success, errorMessage in
      if success {
        withAnimation {
          self.didFinishedLoading = true
        }
      } else {
        // 실패 처리를 여기에 작성합니다.
        // 예를 들어, 사용자에게 오류 메시지를 표시하거나, 재시도할 수 있는 옵션을 제공합니다.
        showingAlert = true
        alertMessage = errorMessage
      }
    }
  }
  
  private func performAPIFetch(completion: @escaping (Bool, String) -> Void) {
    // API 호출 로직을 구현합니다.
    // 여기서는 예시로 2초 후에 완료되었다고 가정하고 있습니다.
    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
      // API 호출 결과에 따라서 success 값을 true 또는 false로 설정
      // false인 경우, 에러코드 또는 메시지 전달
      let apiResult = true
      let errorMsg = "네트워크 연결 확인 후 다시 시도해주세요."
      completion(apiResult, errorMsg) // 예시로 true를 반환합니다.
    }
  }
  
}

struct SplashView_Previews: PreviewProvider {
  static var previews: some View {
    SplashView()
  }
}
