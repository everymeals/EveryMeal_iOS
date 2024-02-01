//
//  EmailAuthenticationView.swift
//  EveryMeal_iOS
//
//  Created by 김하늘 on 11/1/23.
//

import SwiftUI

import ComposableArchitecture

struct EmailAuthenticationView: View {
  let store: StoreOf<EmailAuthenticationReducer>
  
  var viewType: EmailViewType
  var emailDidSent: (String, String) -> Void
  var emailVertifySuccess: () -> Void
  var backButtonTapped: () -> Void
  var authSuccess: () -> Void
  
  @State var selectedImage = UIImage(named: "apple_90")!
  @State var enteredText: String = ""
  @State var isEmailTextNotEmpty: Bool = false
  @State var isValidValue: Bool = true
  @State var showDidSentEmail: Bool = false
  @State var showSelectProfileImage: Bool = false
  @State var makeProfileSuccess: Bool = false
  @State var successButtonEnabled: Bool = true
  @State private var viewOpacity: Double = 1.0
  @State var isErrorToastShown: Bool = false
  
  @FocusState private var textfieldIsFocused: Bool
  
  var body: some View {
    WithViewStore(self.store, observe: { $0 }) { viewStore in
      NavigationView {
        ZStack {
          if !makeProfileSuccess {
            VStack {
              CustomNavigationView(
                title: viewType == .makeProfile ? "프로필 생성" : "학교 인증",
                leftItem: Image("icon-arrow-left-small-mono"),
                leftItemTapped: {
                  backButtonTapped()
                }
              )
              VStack(alignment: .leading, spacing: 0) {
                if viewType != .makeProfile {
                  Text(viewType.title)
                    .font(.pretendard(size: 24, weight: .bold))
                    .lineLimit(2)
                    .foregroundColor(.grey9)
                    .padding(.top, 8)
                    .padding(.bottom, 40)
                  
                } else {
                  HStack {
                    Spacer()
                    ZStack {
                      HStack {
                        Image(uiImage: selectedImage)
                          .resizable()
                          .clipShape(Circle())
                          .aspectRatio(contentMode: .fill)
                          .frame(width: 90, height: 90)
                        Spacer()
                      }
                      HStack {
                        Spacer()
                        VStack {
                          Spacer()
                          ZStack {
                            Circle()
                              .strokeBorder(Color.white, lineWidth: 1)
                              .background(Circle().fill(Color.grey2))
                              .frame(width: 28, height: 28)
                            
                            Image(.iconPlusMono)
                              .resizable()
                              .clipShape(Circle())
                              .aspectRatio(contentMode: .fit)
                              .frame(width: 16, height: 16)
                          }
                        }
                      }
                    }
                    .frame(width: 96, height: 90)
                    .padding(.bottom, 40)
                    .onTapGesture {
                      // TODO: 바텀시트 노출
                      showSelectProfileImage.toggle()
                      
                    }
                    Spacer()
                  }
                }
                
                Text(viewType.rawValue)
                  .font(.pretendard(size: 12, weight: .regular))
                  .foregroundColor(textfieldIsFocused ? Color.grey8 : (isValidValue ? Color.grey8 : Color.redLight))
                  .padding(.bottom, 6)
                
                TextField("\(viewType.placeholder)", text: $enteredText)
                  .font(.pretendard(size: 16, weight: .regular))
                  .frame(height: 48)
                  .padding(EdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16))
                  .foregroundColor(isEmailTextNotEmpty ? .grey8 : .grey5)
                  .background(textfieldIsFocused ? Color.grey2 : (isValidValue ? Color.grey1 : Color.redLight))
                  .overlay(
                    RoundedRectangle(cornerRadius: 12)
                      .inset(by: 0.5)
                      .stroke(textfieldIsFocused ? Color.grey3 : Color.grey2, lineWidth: 1)
                  )
                  .cornerRadius(12)
                  .onChange(of: enteredText, perform: { value in
                    print("\(value)")
                    isEmailTextNotEmpty = value != "" && value != viewType.placeholder
                  })
                  .focused($textfieldIsFocused)
                  .padding(.bottom, 6)
                
                
                if !isValidValue {
                  Text(viewType.errorMessage)
                    .font(.pretendard(size: 12, weight: .regular))
                    .foregroundColor(.red)
                  
                }
                
                Spacer()
              }
              .padding(.horizontal, 20)
              
              VStack(spacing: 12) {
                Spacer()
                if self.viewType == .enterAuthNumber {
                  Text("인증번호 다시 받기")
                    .font(.pretendard(size: 15, weight: .medium))
                    .foregroundColor(.grey6)
                    .background(
                      Color.grey5
                        .frame(height: 1)
                        .offset(y: 10)
                    )
                    .onTapGesture {
                      if isValidValue {
                        showDidSentEmail = true
                        viewStore.send(.sendEmail(viewStore.email ?? ""))
                      }
                    }
                }
                
                EveryMealButton(selectEnable: $isEmailTextNotEmpty, title: viewType == .makeProfile ? "확인" : "다음")
                  .onTapGesture {
                    UIApplication.shared.hideKeyboard()
                    
                    switch viewType {
                    case .enterEmail:
                      isValidValue = checkIsValidEmail(email: enteredText)
                      if isValidValue {
                        viewStore.send(.sendEmail(enteredText))
                      }
                    case .enterAuthNumber:
                      isValidValue = checkIsValidAuthNumber(enteredText)
                      if isValidValue {
                        guard let token = viewStore.emailToken else { return }
                        viewStore.send(.sendVertifyCode(token, enteredText))
//                        emailVertifySuccess()
                      }
                    case .makeProfile:
                      isValidValue = checkIsValidNickname(enteredText)
                      if isValidValue {
                        makeProfileSuccess = true
                      }
                    }
                  }
                  .onChange(of: viewStore.data) { value in
                    if let token = value?.data?.emailAuthToken {
                      emailDidSent(enteredText, token)
                    }
                  }
                  .onChange(of: viewStore.vertifyResult) { value in
                    if let result = value, result == true {
                      emailVertifySuccess()
                    }
                  }
                  .onChange(of: viewStore.errorToastIsShown) { isShown in
                    if let result = isShown, result == true {
                      isErrorToastShown = result
                    }
                  }
              }
            }
            if showSelectProfileImage {
              VStack {
                Spacer()
                SelectProfileImagePopupView(saveButtonTapped: { image in
                  selectedImage = image
                  showSelectProfileImage = false
                })
              }
            }
          } else {
            VStack {
              AuthSuccessView()
              EveryMealButton(selectEnable: $makeProfileSuccess, title: "완료")
                .onTapGesture {
                  authSuccess()
                }
            }
          }
          if showDidSentEmail {
            EveryMealToast(message: "인증번호를 다시 전송했어요") {
              DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
                showDidSentEmail = false
              }
            }
          }
          if isErrorToastShown {
            EveryMealToast(message: "다시 시도해주세요") {
              DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
                isErrorToastShown = false
              }
            }
          }
        }
        
      }
      .onAppear {
        UITextField.appearance().clearButtonMode = .whileEditing
      }

      .navigationBarTitleDisplayMode(.inline)
      .navigationBarBackButtonHidden()
    }
  }
}

private func checkIsValidEmail(email: String) -> Bool {
  let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
  let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
  return emailPredicate.evaluate(with: email)
}

private func checkIsValidAuthNumber(_ number: String) -> Bool {
  do {
    let emailRegex = "^[0-9]+$"
    let regex = try NSRegularExpression(pattern: emailRegex, options: .anchorsMatchLines)
    let range = NSRange(location: 0, length: number.utf16.count)
    return regex.firstMatch(in: number, options: [], range: range) != nil
  } catch {
    return false
  }
}

private func checkIsValidNickname(_ nickname: String) -> Bool {
  // TODO: 닉네임 API 호출
  return true
}

#Preview {
  EmailAuthenticationView(
    store: .init(
      initialState: EmailAuthenticationReducer.State(),
      reducer: {
        EmailAuthenticationReducer()
      }
    ),
    viewType: .makeProfile,
    emailDidSent: { email, token in },
    emailVertifySuccess: { },
    backButtonTapped: { }, 
    authSuccess: { })
}

enum EmailViewType: String {
  case enterEmail = "이메일"
  case enterAuthNumber = "인증번호"
  case makeProfile = "닉네임"
  
  var title: String {
    switch self {
    case .enterEmail: return "학교 인증을 위해\n대학 메일을 입력해주세요"
    case .enterAuthNumber: return "메일로 전달받은\n인증번호를 입력해주세요"
    case .makeProfile: return ""
    }
  }

  var errorMessage: String {
    switch self {
    case .enterEmail: return "잘못된 이메일 형식이에요"
    case .enterAuthNumber: return "잘못된 인증번호예요"
    case .makeProfile: return "이미 사용중인 닉네임이에요"
    }
  }
  
  var placeholder: String {
    switch self {
    case .enterEmail: return "everymeal@university@ac.kr"
    case .enterAuthNumber: return "6자리 숫자"
    case .makeProfile: return "닉네임 규정" // FIXME: 추후 수정
    }
  }
}
