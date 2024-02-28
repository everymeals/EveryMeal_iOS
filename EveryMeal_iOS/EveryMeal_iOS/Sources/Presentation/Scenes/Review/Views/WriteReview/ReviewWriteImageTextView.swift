//
//  ReviewWriteImageTextView.swift
//  EveryMeal_iOS
//
//  Created by 김하늘 on 2023/09/11.
//

import SwiftUI
import PhotosUI

import ComposableArchitecture

struct ReviewWriteImageTextView: View {
  
  let store: StoreOf<ReviewWriteImageTextViewReducer>
  
  @State var starChecked = Array(repeating: false, count: 5)
  @State var isBubbleShown: Bool = true
  @State var saveButtonEnabled: Bool = true
  
  @Binding var selectedImages: [UIImage]
  @State var content: String = ""
  @State private var textHeight = CGFloat.zero
  @State private var bubbleShown: Bool = true
  @State private var showToast: Bool = false
  
  private let writeReviewScrollViewID = "writeReviewScrollViewID"
  var saveButtonTapped: ((String, StoreReviewContent) -> Void)?
  var closeButtonTapped: (() -> Void)?
  var starButtonTapped: ((ReviewDetailModel) -> Void)?
  
  
  private let navigationHeight: CGFloat = 48
  
  var body: some View {
    WithViewStore(self.store, observe: { $0 }) { viewStore in
      NavigationView {
        ZStack {
          VStack {
            CustomNavigationView(
              title: "리뷰 작성",
              rightItem: Image(systemName: "xmark"),
              rightItemTapped: {
                if let closeButtonTapped = closeButtonTapped {
                  closeButtonTapped()
                }
              }
            )
            .padding(.bottom, 30)
            
            Spacer()
          }
          
          ScrollViewReader { reader in
            ScrollView {
              VStack {
                VStack(alignment: .center, spacing: 0) {
                  Text(viewStore.storeContent.categoryDetail ?? "")
                    .foregroundColor(Color.grey6)
                    .font(.pretendard(size: 12, weight: .medium))
                    .padding(.horizontal, 6)
                    .padding(.vertical, 3)
                    .background(Color.grey2)
                    .cornerRadius(4)
                    .padding(.bottom, 12)
                    .padding(.top, 30)
                  
                  Text(viewStore.storeContent.name ?? "")
                    .foregroundColor(Color.grey9)
                    .font(Font.pretendard(size: 18, weight: .bold))
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
                  .onTapGesture {
                    let dummyReviewModel = ReviewDetailModel(
                      storeModel: viewStore.storeContent,
                      content: content
                    )
                    if let starButtonTapped = starButtonTapped {
                      starButtonTapped(dummyReviewModel)
                    }
                  }
                  .padding(.bottom, 6)
                  
                  SpeachBubbleView(text: "별점을 수정할 수 있어요!", isShown: $bubbleShown)
                    .padding(.bottom, 20)
                  
                  ZStack {
                    // TextEditor의 height를 동적으로 조절하기 위한 Text
                    
                    Text(content)
                      .font(Font.pretendard(size: 16, weight: .regular))
                      .lineSpacing(4)
                      .padding(.vertical, 12)
                      .padding(.horizontal, 16)
                      .modifier(ViewHeightModifier(key: ViewHeightKey.self))
                      .frame(width: UIScreen.main.bounds.width - 40)
                    
                    ReviewTextEditor(content: $content)
                      .frame(height: max(120, textHeight + 20))
                    
                  }.onPreferenceChange(ViewHeightKey.self) {
                    reader.scrollTo(writeReviewScrollViewID, anchor: .bottom)
                    textHeight = $0
                  }
                  .padding(.bottom, 16)
                }
                ReviewSelectedImageView(images: $selectedImages)
                  .padding(.leading, 20)
                
                Spacer()
              }
            }
            .id(writeReviewScrollViewID)
            .padding(.top, navigationHeight)
            
          }
          
          VStack {
            Spacer()
            EveryMealButton(selectEnable: $saveButtonEnabled, title: "등록하기", didTapped: {
              let imageData = selectedImages.compactMap { $0.jpegData(compressionQuality: 1) }
              viewStore.send(.requestImageKeys(imageData))
            })
          }
          if showToast {
            EveryMealToast(type: .reviewSuccess) {
              DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
                showToast = false
              }
            }
          }
          
        }
        .onAppear {
          print("score \(viewStore.storeContent.grade)")
          for index in 0..<Int(viewStore.storeContent.grade ?? 1) {
            starChecked[index] = true
          }
        }
        .onChange(of: viewStore.imageConfiges) { configs in
          if configs.count == selectedImages.count {
            viewStore.send(.saveImages)
          } else {
            // TODO: 토스트 노출?
          }
        }
        .onChange(of: viewStore.saveImageSuccess) { value in
          if value {
//            let model = WriteStoreReviewRequest(storeIdx: <#T##Int#>, grade: viewStore.storeEntity.grade, content: content, imageList: viewStore.imageConfiges.map { $0.imageKey })
//            viewStore.send(.saveReview(model))
          }
        }
        .onChange(of: viewStore.saveReviewSuccess) { value in
          if value,
             let saveReviewSuccess = saveReviewSuccess {
            showToast = true
            saveReviewSuccess(ReviewDetailModel(
              storeModel: viewStore.storeContent,
              content: content
            ))
          }
        }
      }
      .onAppear {
        UITextView.appearance().backgroundColor = .clear
      }
      .navigationBarHidden(true)
    }
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
        .font(Font.pretendard(size: 16, weight: .regular))
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
          content = placeholder
          UIApplication.shared.hideKeyboard()
        })
    } else { // 확인 필요
      TextEditor(text: $content)
        .font(Font.pretendard(size: 16, weight: .regular))
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
  @Binding var images: [UIImage]
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
            .font(.pretendard(size: 12, weight: .medium))
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
            .inset(by: 0.5)
            .stroke(Color(red: 0.9, green: 0.91, blue: 0.92), lineWidth: 1)
        )
        .padding(.trailing, 8)
        .sheet(isPresented: $showImagePicker) {
          makePHPicker()
            .ignoresSafeArea()
        }
        
        ForEach(images.indices, id: \.self) { index in
          ZStack(alignment: .center) {
            Image(uiImage: images[index])
              .resizable()
              .aspectRatio(contentMode: .fill)
              .frame(width: 91, height: 91)
              .cornerRadius(10)
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
          }
          .overlay(
            RoundedRectangle(cornerRadius: 10)
              .inset(by: 0.5)
              .stroke(Color(red: 0.9, green: 0.91, blue: 0.92), lineWidth: 1)
          )
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

//struct ReviewWriteImageTextView_Previews: PreviewProvider {
//  static var previews: some View {
//    let dummy = StoreEntity(name: "동경산책 성신여대점", categoryDetail: "일식", grade: 4.0, reviewCount: 52, recommendedCount: 3, images: ["fdsfads", "fdsafdas"], isLiked: false, description: "dummy")
//    let reducer = ReviewWriteImageTextViewReducer()
//    @Binding var aa: [UIImage] = projectedValue
//
//    ReviewWriteImageTextView(
//      store: .init(initialState: ReviewWriteImageTextViewReducer.State(storeEntity: StoreEntity(name: "", categoryDetail: "", grade: 0.0, reviewCount: 0, recommendedCount: 0, isLiked: false)), reducer: {
//        ReviewWriteImageTextViewReducer()
//      }), selectedImages: aa, storeModel: dummy,
//      saveButtonTapped: {_ in
//        print("save")
//      },
//      closeButtonTapped: {
//        print("close")
//      }, starButtonTapped: { _ in })
//  }
//}