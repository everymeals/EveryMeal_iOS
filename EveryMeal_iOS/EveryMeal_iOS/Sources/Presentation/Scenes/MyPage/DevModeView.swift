//
//  DevModeView.swift
//  EveryMeal_iOS
//
//  Created by 김하늘 on 2/11/24.
//

import SwiftUI

import KeychainSwift

struct DevModeView: View {
  let keychain = KeychainSwift()
  @State var showToastType: ToastType? = nil
  @State var showSheet: Bool = false

  var body: some View {
    NavigationView {
      ZStack {
        ScrollView(showsIndicators: false) {
          VStack(spacing: 0) {
            VStack(spacing: 0) {
              SectionView(title: "개발자 모드 { }")
              MyActivitiesRow(title: "Copy RefreshToken")
                .onTapGesture {
                  UIPasteboard.general.string = keychain.get(.refreshToken)
                  showToastType = .copyComplete
                }
              MyActivitiesRow(title: "Copy AccessToken")
                .onTapGesture {
                  UIPasteboard.general.string = keychain.get(.accessToken)
                  showToastType = .copyComplete
                }
              MyActivitiesRow(title: "Show App DataBase")
                .onTapGesture {
                  showSheet = true
                }
              MyActivitiesRow(title: "Remove All Keychain")
                .onTapGesture {
                  keychain.clear()
                  showToastType = .deleteComplete
                }
            }
            .padding(.horizontal, 20)
            
            CustomDivider()
          }
          .padding(.bottom, 50)
        }
        if let type = showToastType {
          EveryMealToast(type: type) {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
              showToastType = nil
            }
          }
        }
      }
    }
    .navigationBarTitleDisplayMode(.inline)
    .navigationBarBackButtonHidden()
    .sheet(isPresented: $showSheet, content: {
      ScrollView {
        VStack {
          CustomSheetView(title: "App Database", horizontalPadding: 0, content: {
            CustomSeparator()
            HStack {
              VStack(alignment: .leading) {
                Text("UserDefualts")
                  .font(.pretendard(size: 20, weight: .bold))
                  .foregroundColor(.black)
                LazyVGrid(columns: [GridItem(.flexible())], spacing: 5) {
                  ForEach(UserDefaultsManager.KeyType.allCases, id: \.self) { key in
                    HStack(alignment: .top) {
                      Text(key.rawValue)
                        .font(.pretendard(size: 15, weight: .bold))
                        .foregroundColor(.black)
                      Spacer()
                      Text(UserDefaultsManager.getString(key))
                        .font(.pretendard(size: 15, weight: .regular))
                        .foregroundColor(.black)
                    }
                  }
                }
                Text("KeyChain")
                  .font(.pretendard(size: 20, weight: .bold))
                  .foregroundColor(.black)
                LazyVGrid(columns: [GridItem(.flexible())], spacing: 5) {
                  ForEach(KeychainKey.allCases, id: \.self) { key in
                    HStack(alignment: .top) {
                      Text(key.rawValue)
                        .font(.pretendard(size: 15, weight: .bold))
                        .foregroundColor(.black)
                      Spacer()
                      Text(keychain.get(key) ?? "none")
                        .font(.pretendard(size: 15, weight: .regular))
                        .foregroundColor(.black)
                    }
                  }
                }
              }
              Spacer()
            }
            .padding(.horizontal, 20)
            .padding(.top, 10)
          })
        }
      }
      .presentationDetents([.height(800)])
      .presentationDragIndicator(.hidden)
    })
  }
}

#Preview {
  DevModeView()
}
