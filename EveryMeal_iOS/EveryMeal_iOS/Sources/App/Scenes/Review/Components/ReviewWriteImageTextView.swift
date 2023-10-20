//
//  ReviewWriteImageTextView.swift
//  EveryMeal_iOS
//
//  Created by 김하늘 on 2023/09/11.
//

import SwiftUI
import PhotosUI

struct ReviewWriteImageTextView: View {
  
  init(mealModel: MealModel, saveButtonTapped: @escaping (ReviewDetailModel) -> Void, closeButtonTapped: @escaping () -> Void) {
    UITextView.appearance().backgroundColor = .clear
    self.mealModel = mealModel
    self.saveButtonTapped = saveButtonTapped
    self.closeButtonTapped = closeButtonTapped
  }
  
  @State var starChecked = Array(repeating: false, count: 5)
  @State var isBubbleShown: Bool = true
  @State var saveButtonEnabled: Bool = true
  
  @State var content: String = "ㄹㅇㄴㄹㅇㄴㅁㄹㅁ"
  @State private var textHeight = CGFloat.zero
  
  private let writeReviewScrollViewID = "writeReviewScrollViewID"
  var mealModel: MealModel
  var saveButtonTapped: (ReviewDetailModel) -> Void
  var closeButtonTapped: () -> Void
  
  
  private let navigationHeight: CGFloat = 48
  
  var body: some View {
    NavigationView {
      ZStack {
        VStack {
          CustomNavigationView(
            rightItem: Image(systemName: "xmark"),
            rightItemTapped: {
              closeButtonTapped()
            }
          )
          .padding(.bottom, 30)
          
          Spacer()
        }
        
        ScrollViewReader { reader in
          ScrollView {
            VStack {
              VStack(alignment: .center, spacing: 0) {
                Text(mealModel.type.rawValue)
                  .foregroundColor(Color.grey6)
                  .font(.system(size: 12, weight: .medium))
                  .padding(.horizontal, 6)
                  .padding(.vertical, 3)
                  .background(Color.grey2)
                  .cornerRadius(4)
                  .padding(.bottom, 12)
                  .padding(.top, 30)
                
                Text(mealModel.title)
                  .foregroundColor(Color.grey9)
                  .font(Font.system(size: 18, weight: .bold))
                  .lineLimit(1)
                  .padding(.bottom, 16)
                  .frame(width: 210)
                
                HStack(spacing: 2) {
                  ForEach(starChecked.indices, id: \.self) { index in
                    Image("icon-star-mono")
                      .resizable()
                      .renderingMode(.template)
                      .foregroundColor(starChecked[index] ? Color.everyMealYellow : Color.grey3)
                      .frame(width: 20, height: 20)
                  }
                }
                .padding(.bottom, 60)
                
                ZStack {
                  Text(content)
                    .font(Font.system(size: 16, weight: .regular))
                    .lineSpacing(4)
                    .padding(.vertical, 12)
                    .padding(.horizontal, 16)
                    .modifier(ViewHeightModifier(key: ViewHeightKey.self))
                    .frame(width: UIScreen.main.bounds.width - 40)
                  
                  // TextEditor의 height를 동적으로 조절하기 위한 Text
                  ReviewTextEditor(content: $content)
                    .frame(height: max(120, textHeight + 20))
                  
                }.onPreferenceChange(ViewHeightKey.self) {
                  reader.scrollTo(writeReviewScrollViewID, anchor: .bottom)
                  textHeight = $0
                }
                .padding(.bottom, 16)
              }
              ReviewSelectedImageView(images: [])
                .padding(.leading, 20)
              
              Spacer()
            }
          }
          .padding(.top, navigationHeight)
          
        }
        
        VStack {
          Spacer()
          ReviewSaveButton(selectEnable: $saveButtonEnabled)
            .onTapGesture {
              let dummyReviewModel = ReviewDetailModel(
                nickname: "햄식이",
                userID: "4324324",
                profileImageURL: "https://images.unsplash.com/photo-1425082661705-1834bfd09dca?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1752&q=80",
                mealModel: mealModel,
                dateBefore: 3
              )
              saveButtonTapped(dummyReviewModel)
            }
        }
        
      }
      .onAppear {
        print("score \(mealModel.score)")
        for index in 0..<Int(mealModel.score) {
          starChecked[index] = true
        }
      }
    }
    .navigationBarHidden(true)
  }
}

struct ReviewSaveButton: View {
  @Binding var selectEnable: Bool
  
  var body: some View {
    Text("선택하기")
      .frame(maxWidth: .infinity)
      .padding()
      .background(selectEnable ? Color.accentColor : Color(red: 0.9, green: 0.91, blue: 0.92))
      .font(.system(size: 16, weight: .medium))
      .foregroundColor(Color.white)
      .cornerRadius(12)
      .padding(.horizontal, 20)
      .padding(.bottom, 10)
  }
}

struct ReviewTextEditor: View {
  @Binding var content: String
  @FocusState private var didTextFieldFocused: Bool
  
  var placeholder: String = "맛집에 대한 의견을 자세히 적어주시면 다른 사용자에게 도움이 돼요!"
  
  var body: some View {
    if #available(iOS 16.0, *) {
      TextEditor(text: $content)
        .scrollContentBackground(.hidden)
        .font(Font.system(size: 16, weight: .regular))
        .lineSpacing(4)
        .padding(.vertical, 12)
        .padding(.horizontal, 16)
        .foregroundColor(content == placeholder ? .grey5 : .grey8 )
        .background(Color.grey1)
        .overlay(
          RoundedRectangle(cornerRadius: 12)
            .inset(by: 0.5)
            .stroke(Color.grey2, lineWidth: 1)
        )
        .cornerRadius(12)
        .padding(.horizontal, 20)
        .focused($didTextFieldFocused)
        .onChange(of: didTextFieldFocused, perform: { value in
          if value {
            if content == placeholder {
              content = ""
            }
          } else {
            if content.isEmpty {
              content = placeholder
            }
          }
        })
        .onAppear(perform: {
          UIApplication.shared.hideKeyboard()
        })
      
    } else { // 확인 필요
      TextEditor(text: $content)
        .font(Font.system(size: 16, weight: .regular))
        .lineSpacing(4)
        .padding(.vertical, 12)
        .padding(.horizontal, 16)
        .foregroundColor(content.isEmpty ? .grey5 : .grey8 )
        .background(Color.grey1)
        .overlay(
          RoundedRectangle(cornerRadius: 12)
            .inset(by: 0.5)
            .stroke(Color.grey2, lineWidth: 1)
        )
        .cornerRadius(12)
        .padding(.horizontal, 20)
    }
  }
}

struct ReviewSelectedImageView: View {
  @State var images: [Image]
  @State var showImagePicker: Bool = false
  @State var authorizationStatus: PHAuthorizationStatus = .denied
  @State private var showingAccessAlert = false
  
  
  var body: some View {
    ScrollView(.horizontal, showsIndicators: false) {
      LazyHGrid(rows: [GridItem(.fixed(20))]) {
        VStack(alignment: .center, spacing: 2) {
          Image("icon-picture-mono")
            .resizable()
            .renderingMode(.template)
            .foregroundColor(.grey5)
            .frame(width: 24, height: 24)
          
          Text("\(images.count)/10")
            .foregroundColor(Color.grey7)
            .font(.system(size: 12, weight: .medium))
            .fixedSize()
        }
        .onTapGesture {
          requestAuthorization()
        }
        .alert(isPresented: $showingAccessAlert) {
          Alert(
            title: Text("사진 권한을 허용해야 사진 추가가 가능해요!"), message: nil,
            dismissButton: .default(Text("OK"), action: {
              Functions.openAppSettings()
            })
          )
        }
        .padding(.horizontal, 33)
        .padding(.vertical, 24)
        .background(.white)
        .frame(width: 91, height: 91)
        .cornerRadius(10)
        .overlay(
          RoundedRectangle(cornerRadius: 10)
            .stroke(Color(red: 0.9, green: 0.91, blue: 0.92), lineWidth: 1)
        )
        .padding(.trailing, 8)
        .sheet(isPresented: $showImagePicker) {
          makePHPicker()
        }
        
        ForEach(images.indices, id: \.self) { index in
          ZStack(alignment: .center) {
            images[index]
              .resizable()
              .aspectRatio(contentMode: .fill)
              .frame(width: 91, height: 91)
              .cornerRadius(8)
            VStack {
              HStack(alignment: .top) {
                Spacer()
                ZStack {
                  Circle()
                    .frame(width: 26, height: 26)
                    .foregroundColor(.black.opacity(0.6))
                  Image("icon-x-mono")
                    .resizable()
                    .frame(width: 16, height: 16)
                }
              }
              Spacer()
            }
            .padding(.trailing, 5)
            .padding(.top, 5)
            .frame(width: 91, height: 91)
            .cornerRadius(10)
            .onTapGesture {
              images.remove(at: index)
            }
            
            RoundedRectangle(cornerRadius: 10)
              .stroke(Color(red: 0.9, green: 0.91, blue: 0.92), lineWidth: 1)
          }
          .padding(.trailing, 8)
        }
        Spacer()
      }
    }
  }
  
  private func requestAuthorization() {
    let requiredAccessLevel: PHAccessLevel = .readWrite
    PHPhotoLibrary.requestAuthorization(for: requiredAccessLevel) { status in
      switch status {
      case .authorized:
        _ = makePHPicker()
        showImagePicker = true
      default:
        showingAccessAlert = true
      }
    }
  }
  
  private func makePHPicker() -> some View {
    var configuration = PHPickerConfiguration(photoLibrary: PHPhotoLibrary.shared())
    configuration.filter = .any(of: [.images, .livePhotos])
    configuration.selectionLimit = 10 // FIXME: 기획 확인 후 변경
    return ImagePicker(configuration: configuration, isPresented: $showImagePicker, selectedImages: $images)
  }
}

struct ReviewWriteImageTextView_Previews: PreviewProvider {
  static var previews: some View {
    let dummyMealModel = MealModel(title: "동경산책 성신여대점",
                                   type: .일식,
                                   description: "ss",
                                   score: 4.0,
                                   doUserLike: false,
                                   imageURLs: ["fdsfads", "fdsafdas"],
                                   likesCount: 3)
    ReviewWriteImageTextView(mealModel: dummyMealModel,
                             saveButtonTapped: {_ in 
      print("save")
    }, closeButtonTapped: {
      print("close")
    })
  }
}

struct ViewHeightKey: PreferenceKey {
    static var defaultValue: CGFloat = 0

    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = max(value, nextValue())
    }
}

struct ViewHeightModifier: ViewModifier {
    var key: ViewHeightKey.Type
    
    func body(content: Content) -> some View {
        content.background(
            GeometryReader { geometry in
                Color.clear.preference(key: key.self, value: geometry.size.height)
            }
        )
    }
}

extension UIApplication {
  func hideKeyboard() {
    let scenes = UIApplication.shared.connectedScenes
    let windowScene = scenes.first as? UIWindowScene
    let window = windowScene?.windows.first
    let tapRecognizer = UITapGestureRecognizer(target: window, action: #selector(UIView.endEditing))
    tapRecognizer.cancelsTouchesInView = false
    tapRecognizer.delegate = self
    window?.addGestureRecognizer(tapRecognizer)
  }
}

extension UIApplication: UIGestureRecognizerDelegate {
  public func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
    return false
  }
}
