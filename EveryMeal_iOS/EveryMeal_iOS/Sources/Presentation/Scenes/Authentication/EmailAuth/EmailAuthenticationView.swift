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
  var emailDidSent: (SignupEntity) -> Void
  var emailVertifySuccess: (SignupEntity) -> Void
  var backButtonTapped: () -> Void
  var authSuccess: () -> Void
  
  @State var selectedImage: SelectedProfileImageModel = .init(image: UIImage(named: "apple_90")!)
  @State var enteredText: String = ""
  @State var isEmailTextNotEmpty: Bool = false
  @State var isValidValue: Bool = true
  @State var emailErrorType: EmailViewType.EmailErrorType = .invalidEmail
  @State var nicknameProfileErrorType: EmailViewType.NicknameProfileErrorType = .invalidNickname
  
  @State var showDidSentEmail: Bool = false
  @State var showTermsAndConditionAgree: Bool = false
  @State var didTermsSaveButtonEnabled: Bool = false
  @State var didTermsAgreed: Bool = false
  
  @State var showSelectProfileImage: Bool = false
  @State var makeProfileSuccess: Bool = false
  @State var successButtonEnabled: Bool = true
  
  @State private var viewOpacity: Double = 1.0
  @State var errorToastWillBeShown = ToastModel(isShown: false)
  @State var showIndicator: Bool = false
  @State var alreadySignin: Bool = false
  
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
                        if let imageURL = selectedImage.imageURL {
                          AsyncImage(url: imageURL) { image in
                            image.resizable()
                              .frame(width: 90, height: 90, alignment: .center)
                          } placeholder: {
                            Image(ProfileImageType.apple.imageSource)
                              .resizable()
                              .clipShape(Circle())
                              .aspectRatio(contentMode: .fill)
                              .frame(width: 90, height: 90)
                          }
                        } else if let image = selectedImage.image {
                          Image(uiImage: image)
                            .resizable()
                            .clipShape(Circle())
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 90, height: 90)
                        }
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
                  .foregroundColor(isValidValue ? Color.grey8 : Color.red)
                  .padding(.bottom, 6)
                
                TextField("\(viewType.placeholder)", text: $enteredText)
                  .font(.pretendard(size: 16, weight: .regular))
                  .frame(height: 48)
                  .padding(EdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16))
                  .foregroundColor(isEmailTextNotEmpty ? .grey8 : .grey5)
                  .background(isValidValue ? (textfieldIsFocused ? Color.grey2 : Color.grey1) : Color.redLight)
                  .overlay(
                    RoundedRectangle(cornerRadius: 12)
                      .inset(by: 0.5)
                      .stroke(isValidValue ? (textfieldIsFocused ? Color.grey3 : Color.grey2) : Color.grey2, lineWidth: 1)
                  )
                  .cornerRadius(12)
                  .onChange(of: enteredText, perform: { value in
                    print("\(value)")
                    isEmailTextNotEmpty = value != "" && value != viewType.placeholder
                  })
                  .focused($textfieldIsFocused)
                  .padding(.bottom, 6)
                
                
                if !isValidValue {
                  let errorMessage: String = {
                    switch viewType {
                    case .enterEmail:
                      return emailErrorType.rawValue
                    case .enterAuthNumber:
                      return viewType.errorMessage
                    case .makeProfile:
                      return nicknameProfileErrorType.rawValue
                    }
                  }()
                  Text(errorMessage)
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
                      textfieldIsFocused = false
                      showDidSentEmail = true
                      viewStore.send(.sendEmail(viewStore.signupEntity.email ?? ""))
                    }
                }
                
                EveryMealButton(selectEnable: $isEmailTextNotEmpty, title: viewType == .makeProfile ? "확인" : "다음", didTapped: {
                  UIApplication.shared.hideKeyboard()
                  
                  switch viewType {
                  case .enterEmail:
                    isValidValue = checkIsValidEmail(email: enteredText)
                    if isValidValue {
                      viewStore.send(.checkAlreadySignin(enteredText))
                    }
                  case .enterAuthNumber:
                    isValidValue = checkIsValidAuthNumber(enteredText)
                    if isValidValue {
                      viewStore.send(.sendVertifyCode(enteredText))
                    }
                  case .makeProfile:
                    viewStore.send(.signupButtonDidTappaed(selectedImage, enteredText) )
                  }
                })
                  .onChange(of: viewStore.signinAlready) { value in
                    if value == false {
                      emailErrorType = .invalidEmail
                      isValidValue = true
                      showTermsAndConditionAgree = true
                    } else if value == true { // 이미 가입된 경우
                      emailErrorType = .alreadySignin
                      isValidValue = false
                      viewStore.send(.setSigninAlready(nil))
                    }
                  }
                  .onChange(of: viewStore.sameNickname) { value in
                    if value == true {
                      nicknameProfileErrorType = .duplicatedNickname
                      isValidValue = false
                    } else if value == false {
                      nicknameProfileErrorType = .invalidNickname
                      isValidValue = true
                    }
                  }
                  .onChange(of: viewStore.signupEntity.emailSentCount) { value in
                    emailDidSent(viewStore.signupEntity)
                  }
                  .onChange(of: didTermsSaveButtonEnabled) { value in
                    if value {
                      viewStore.send(.sendEmail(enteredText))
                      viewStore.send(.setSigninAlready(nil))
                    }
                  }
                  .onChange(of: viewStore.vertifyDidSuccess) { value in
                    if let result = value, result == true {
                      emailVertifySuccess(viewStore.signupEntity)
                    }
                  }
                  .onChange(of: viewStore.saveImageToAWSSuccess) { value in
                    if let result = value, result == true {
                      viewStore.send(.signup)
                    }
                  }
                  .onChange(of: viewStore.imageKeyAlreadyExist) { value in
                    if let result = value, result == true {
                      viewStore.send(.signup)
                      viewStore.send(.imageKeyAlreadyExist(false))
                    }
                  }
                  .onChange(of: viewStore.loginSuccess) { value in
                    if let result = value, result == true {
                      makeProfileSuccess = true
                    }
                  }
                  .onChange(of: viewStore.errorToastWillBeShown) { model in
                    errorToastWillBeShown = model
                    if model.isShown {
                      textfieldIsFocused = false
                    }
                  }
                  .onChange(of: viewStore.isEmailSending) { value in
                    showIndicator = value
                  }
              }
            }
            .sheet(isPresented: $showSelectProfileImage, content: {
              VStack {
                CustomSheetView(title: "이미지 선택", horizontalPadding: 0, content: {
                  SelectProfileImagePopupView(saveButtonTapped: { image in
                    selectedImage = image
                    showSelectProfileImage = false
                  })
                })
              }
              .presentationDetents([.height(429)])
              .presentationDragIndicator(.hidden)
            })
            .sheet(isPresented: $showTermsAndConditionAgree, content: {
              VStack {
                CustomSheetView(title: "이용을 위한 동의가 필요해요",
                                buttonTitle: "동의하기",
                                isButtonEnabled: didTermsAgreed,
                                horizontalPadding: 20,
                                content: {
                  AgreePopupView(nextButtonEnabled: $didTermsAgreed)
                    .padding(.top, 20)
                }, buttonAction: {
                  didTermsSaveButtonEnabled = true
                  showTermsAndConditionAgree = false
                })
              }
              .presentationDetents([.height(299)])
              .presentationDragIndicator(.hidden)
            })
          } else {
            VStack {
              AuthSuccessView(nickname: viewStore.signupEntity.nickname ?? "에브리밀")
                .onAppear {
                  
                }
              EveryMealButton(selectEnable: $makeProfileSuccess, title: "완료", didTapped: {
                authSuccess()
              })
            }
          }
          if showDidSentEmail {
            EveryMealToast(type: .emailVertifyRetry) {
              DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
                showDidSentEmail = false
              }
            }
          }
          if errorToastWillBeShown.isShown {
            EveryMealToast(type: errorToastWillBeShown.type) {
              DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
                viewStore.send(.showToastWithError(.init(isShown: false)))
              }
            }
          }
        }
        
//        if showIndicator {
//          LoadingView()
//        }
      }
      .onAppear {
        UITextField.appearance().clearButtonMode = .whileEditing
      }

      .navigationBarTitleDisplayMode(.inline)
      .navigationBarBackButtonHidden()
    }
  }
  
  private func checkIsValidEmail(email: String) -> Bool {
    emailErrorType = .invalidEmail
    let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
    let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
    return emailPredicate.evaluate(with: email) && !alreadySignin
  }
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
  do {
    let regexString = "^[가-힣a-zA-Z0-9]{2,7}$"
    let regex = try NSRegularExpression(pattern: regexString, options: .anchorsMatchLines)
    let range = NSRange(location: 0, length: nickname.utf16.count)
    return regex.firstMatch(in: nickname, options: [], range: range) != nil && (2...7).contains(nickname.count)
  } catch {
    return false
  }
}

#Preview {
  EmailAuthenticationView(
    store: .init(
      initialState: EmailAuthenticationReducer.State(signupEntity: SignupEntity()),
      reducer: {
        EmailAuthenticationReducer()
      }
    ),
    viewType: .makeProfile,
    emailDidSent: { _ in },
    emailVertifySuccess: { _ in},
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
  
  enum EmailErrorType: String {
    case invalidEmail = "잘못된 이메일 형식이에요"
    case alreadySignin = "이미 가입된 이메일이에요"
  }
  
  enum NicknameProfileErrorType: String {
    case invalidNickname = "한글, 영어, 숫자를 이용해 2~7자로 지어주세요"
    case duplicatedNickname = "이미 사용중인 닉네임이에요"
  }
}
