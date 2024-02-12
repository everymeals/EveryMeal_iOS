//
//  MyPageView.swift
//  EveryMeal_iOS
//
//  Created by 김광록 on 11/14/23.
//

import SwiftUI

enum MyPageNavigationViewType: Hashable {
  case certify  // 학교 인증
  case favorites  // 저장
  case reviews
  case photos
  case inquiry  // 문의하기
  case terms  // 약관
  case license
  case withdrawal  // 탈퇴
  case withdrawalReason  // 탈퇴 사유
  case devMode
}

struct MyPageView: View {
  @State private var navigationPath: [MyPageNavigationViewType] = []
  @Binding var otherViewShowing: Bool

  var body: some View {
    NavigationStack(path: $navigationPath) {
      ScrollView(showsIndicators: false) {
        VStack(spacing: 0) {
          ProfileView()
          ChooseUniversityView()
          CustomSeparator()
          
          VStack(spacing: 0) {
            SectionView(title: "나의 설정")
            MyActivitiesRow(title: "저장")
              .onTapGesture {
                navigationPath.append(.favorites)
              }
            MyActivitiesRow(title: "리뷰 내역")
              .onTapGesture {
                navigationPath.append(.reviews)
              }
            MyActivitiesRow(title: "사진 내역")
              .onTapGesture {
                navigationPath.append(.photos)
              }
          }
          .padding(.horizontal, 20)
          
          CustomDivider()
          
          VStack(spacing: 0) {
            SectionView(title: "설정")
            MyActivitiesRow(title: "문의하기")
              .onTapGesture {
                navigationPath.append(.inquiry)
              }
            MyActivitiesRow(title: "서비스 약관")
              .onTapGesture {
                navigationPath.append(.terms)
              }
            MyActivitiesRow(title: "오픈소스 라이센스")
              .onTapGesture {
                navigationPath.append(.license)
              }
            MyActivitiesRow(title: "앱 버전", hasRightArrow: false)
            MyActivitiesRow(title: "탈퇴하기")
              .onTapGesture {
                navigationPath.append(.withdrawal)
              }
            #if DEBUG
            MyActivitiesRow(title: "개발자 모드 {}")
              .onTapGesture {
                navigationPath.append(.devMode)
              }
            #endif
          }
          .padding(.horizontal, 20)
        }
        .padding(.bottom, 50)
      }
      .mask {
        Rectangle()
      }
      .navigationDestination(for: MyPageNavigationViewType.self) { view in
        switch view {
        case .certify: SignOutView(path: $navigationPath)
        case .favorites: SignOutView(path: $navigationPath)
        case .reviews: SignOutView(path: $navigationPath)
        case .photos: SignOutView(path: $navigationPath)
        case .inquiry: SignOutView(path: $navigationPath)
        case .terms: SignOutView(path: $navigationPath)
        case .license: SignOutView(path: $navigationPath)
        case .withdrawal: SignOutView(path: $navigationPath)
        case .withdrawalReason: SignOutDetailView(path: $navigationPath)
        case .devMode:
          DevModeView()
            .toolbar(.hidden, for: .tabBar)
        }
      }
    }
    .navigationBarTitleDisplayMode(.inline)
    .navigationBarHidden(true)
    .onChange(of: navigationPath) { value in
      otherViewShowing = value.count != 0
    }
  }
}

struct MyPageView_Previews: PreviewProvider {
  static var previews: some View {
    @State var otherViewShowing: Bool = false
    MyPageView(otherViewShowing: $otherViewShowing)
  }
}

struct ProfileView: View {
  var body: some View {
    HStack {
      Image("not_certified_profile_img")
        .resizable()
        .frame(width: 60, height: 60)
      
      Text("인증하기")
        .font(.pretendard(size: 18, weight: .bold))
        .foregroundStyle(Color.grey9)
      
      Spacer()
      
      Image("icon-arrow-right-small-mono")
        .renderingMode(.template)
        .foregroundColor(Color.grey6)
        .frame(width: 24, height: 24)
    }
    .padding(.top, 28)
    .padding(.horizontal, 20)
    .padding(.bottom, 16)
  }
}

struct ChooseUniversityView: View {
  var body: some View {
    
    ZStack {
      Rectangle()
        .frame(height: 93)
        .cornerRadius(10)
        .padding(.horizontal, 20)
        .foregroundColor(.grey1)
      
      HStack(spacing: 12) {
        VStack {
          Image("school")
            .resizable()
            .frame(width: 44, height: 44)
          Spacer()
        }
        
        VStack(spacing: 5) {
          HStack {
            Text("학교 인증이 필요해요")
              .font(.pretendard(size: 15, weight: .bold))
              .foregroundStyle(Color.grey9)
            Spacer()
          }
          
          HStack {
            Text("학교를 인증하면 리뷰 작성, 사진 등록 등 에브리밀을 다양하게 이용할 수 있어요!")
              .lineSpacing(4)
              .font(.pretendard(size: 14, weight: .regular))
              .foregroundStyle(Color.grey6)
            Spacer()
          }
          Spacer()
        }
      }
      .padding(.top, 14)
      .padding(.horizontal, 34)
    }
    .padding(.bottom, 20)
    
  }
}

struct SectionView: View {
  var title: String
  
  var body: some View {
    HStack(spacing: 0) {
      Text(title)
        .font(.pretendard(size: 18, weight: .bold))
        .foregroundStyle(Color.grey9)
      Spacer()
    }
    .padding(.vertical)
  }
}

struct MyActivitiesRow: View {
  var title: String
  var hasRightArrow: Bool?
  
  var body: some View {
    HStack {
      Text(title)
        .font(.pretendard(size: 16))
        .foregroundStyle(Color.grey8)
      
      Spacer()
      
      if hasRightArrow ?? true {
        Image("icon-arrow-right-small-mono")
          .renderingMode(.template)
          .foregroundStyle(Color.grey4)
          .frame(width: 20, height: 20)
      } else {
        Text(Functions.getAppVersion())
          .font(.pretendard(size: 16, weight: .regular))
          .foregroundStyle(Color.grey5)
      }
    }
    .padding(.vertical)
    .contentShape(Rectangle())
  }
}

struct CustomDivider: View {
  var body: some View {
    Rectangle()
      .foregroundColor(.clear)
      .frame(maxWidth: .infinity, maxHeight: 12)
      .background(Color.grey1)
      .padding(.vertical)
  }
}

struct CustomSeparator: View {
  var body: some View {
    Color.grey2
      .frame(maxWidth: .infinity, maxHeight: 1)
      .padding(.horizontal, 20)
      .padding(.bottom, 5)
  }
}
