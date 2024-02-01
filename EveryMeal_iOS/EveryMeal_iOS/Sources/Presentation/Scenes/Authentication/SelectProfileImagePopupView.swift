//
//  SelectProfileImagePopupView.swift
//  EveryMeal_iOS
//
//  Created by 김하늘 on 12/27/23.
//

import SwiftUI
import Photos
import PhotosUI

enum SelectImageType: CaseIterable {
  case camera
  case rice
  case sushi
  case puding
  case library
  case apple
  case egg
  case ramen
  
  var imageSource: ImageResource {
    switch self {
    case .camera: return .iconCameraMono
    case .rice: return .rice90
    case .sushi: return .sushi90
    case .puding: return .puding90
    case .library: return .iconPictureMono
    case .apple: return .apple90
    case .egg: return .egg90
    case .ramen: return .ramen90
    }
  }
}

struct SelectProfileImagePopupView: View {
  @State var goToAuthButtonEnabled = true
  @State var selectIconColumns: [SelectImageType] = []
  @State var selectedImages: [UIImage] = [UIImage(named: "apple_90")!]
  @State var changeSelectedImage: Bool = false
  
  var saveButtonTapped: (UIImage) -> Void
  private let columns = Array(repeating: GridItem(.fixed(50), spacing: 20), count: 4)
  
  var body: some View {
    VStack(alignment: .leading) {
      Text("이미지 선택")
        .font(.pretendard(size: 22, weight: .bold))
        .lineLimit(2)
        .foregroundColor(Color.grey9)
        .padding(.all, 20)
      
      VStack(spacing: 32) {
        if changeSelectedImage,
           let selectedImage = selectedImages.first {
          Image(uiImage: selectedImage)
            .resizable()
            .clipShape(Circle())
            .aspectRatio(contentMode: .fill)
            .frame(width: 90, height: 90)
        } else if let selectedImage = selectedImages.first {
          Image(uiImage: selectedImage)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: 90)
        }
        
        LazyVGrid(columns: columns, spacing: 14) {
          ForEach($selectIconColumns.indices, id: \.self) { index in
            if selectIconColumns[index] != .camera,
               selectIconColumns[index] != .library {
              Image(selectIconColumns[index].imageSource)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 50)
                .onTapGesture {
                  let resource = selectIconColumns[index].imageSource
                  selectedImages = [UIImage(resource: resource)]
                }
            } else {
              CameraLibraryView(type: selectIconColumns[index],
                                images: $selectedImages)
            }
          }
        }
      }
      .onChange(of: selectedImages, perform: { value in
        DispatchQueue.main.async {
          changeSelectedImage = !value.isEmpty
        }
      })
      
      EveryMealButton(selectEnable: $goToAuthButtonEnabled, title: "확인")
        .onTapGesture {
          saveButtonTapped(selectedImages.first ?? UIImage())
        }
    }
    .background(Color.white)
    .onAppear {
      if selectIconColumns.isEmpty {
        SelectImageType.allCases.forEach { type in
          self.selectIconColumns.append(type)
        }
      }
    }
  }
}

struct CameraLibraryView: View {
  var type: SelectImageType
  @State var showImagePicker: Bool = false
  @State var showCameraPicker: Bool = false
  @State private var showingAccessAlert = false
  
  @Binding var images: [UIImage]
  
  var body: some View {
    ZStack {
      Circle()
        .strokeBorder(Color.white, lineWidth: 1)
        .background(Circle().fill(Color.grey2))
        .frame(width: 50, height: 50)
      
      Image(type.imageSource)
        .resizable()
        .renderingMode(.template)
        .foregroundColor(.grey6)
        .aspectRatio(contentMode: .fit)
        .frame(width: 22)
    }
    .onTapGesture {
      switch type {
      case .camera:
        requestCameraAuthorization()
      case .library:
        requestLibraryAuthorization()
      default:
        return
      }
    }
    .alert(isPresented: $showingAccessAlert) {
      let text = type == .camera ? Text("카메라 권한을 허용해야 사진 추가가 가능해요!") : Text("사진 권한을 허용해야 사진 추가가 가능해요!")
      return Alert(
        title: text, message: nil,
        dismissButton: .default(Text("OK"), action: {
          Functions.openAppSettings()
        })
      )
    }
    .sheet(isPresented: $showImagePicker) {
      makePHPicker()
        .ignoresSafeArea()
    }
    .fullScreenCover(isPresented: $showCameraPicker) {
      CameraPicker(image: $images, isActive: $showCameraPicker)
        .ignoresSafeArea()
    }
  }
  
  private func requestLibraryAuthorization() {
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
    configuration.selectionLimit = 1
    return ImagePicker(configuration: configuration, isPresented: $showImagePicker, selectedImages: $images)
  }
  
  private func requestCameraAuthorization() {
    let status = AVCaptureDevice.authorizationStatus(for: .video)
    if status == .authorized {
      showCameraPicker = true
    } else {
      AVCaptureDevice.requestAccess(for: .video) { accessGranted in
        DispatchQueue.main.async {
          if accessGranted {
            showCameraPicker = true
          } else {
            showingAccessAlert = true
          }
        }
      }
    }
  }
}

struct SelectProfileImagePopupView_Previews: PreviewProvider {
  static var previews: some View {
    SelectProfileImagePopupView() { _ in }
  }
}

