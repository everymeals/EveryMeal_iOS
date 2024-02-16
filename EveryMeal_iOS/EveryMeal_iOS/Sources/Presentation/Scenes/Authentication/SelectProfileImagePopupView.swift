//
//  SelectProfileImagePopupView.swift
//  EveryMeal_iOS
//
//  Created by 김하늘 on 12/27/23.
//

import SwiftUI
import Photos
import PhotosUI

struct SelectedProfileImageModel: Equatable {
  var imageURL: URL?
  var image: UIImage?
  var imageKey: String?
}

struct SelectProfileImagePopupView: View {
  @State var goToAuthButtonEnabled = true
  @State var allProfileImageType: [ProfileImageType] = []
  @State var selectIconColumns: [ProfileImageEntity] = []
//  @State var selectedImages: [UIImage] = [UIImage(named: "apple_90")!]
  @State var selectedImages: SelectedProfileImageModel = .init(image: UIImage(named: "apple_90")!)
  @State var changeSelectedImage: Bool = false
  
  var saveButtonTapped: (SelectedProfileImageModel) -> Void
  private let columns = Array(repeating: GridItem(.fixed(50), spacing: 20), count: 4)
  
  var body: some View {
    VStack(alignment: .leading) {
      VStack(spacing: 32) {
        if let imageURL = selectedImages.imageURL {
          AsyncImage(url: imageURL) { image in
            image.resizable()
              .aspectRatio(contentMode: .fit)
              .frame(width: 90, height: 90)
          } placeholder: {
            
            Image(.apple90)
              .resizable()
              .aspectRatio(contentMode: .fit)
              .frame(width: 90, height: 90)
          }
        } else if changeSelectedImage,
                  let selectedImage = selectedImages.image {
          Image(uiImage: selectedImage)
            .resizable()
            .clipShape(Circle())
            .aspectRatio(contentMode: .fill)
            .frame(width: 90, height: 90)
        } else if let selectedImage = selectedImages.image{
          Image(uiImage: selectedImage)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: 90)
        }
        
        LazyVGrid(columns: columns, spacing: 14) {
          ForEach($allProfileImageType.indices, id: \.self) { index in
            if selectIconColumns[index].type != .camera,
               selectIconColumns[index].type != .library {
              AsyncImage(url: selectIconColumns[index].profileImageUrl!) { image in
                image.resizable()
                  .frame(width: 50, height: 50, alignment: .center)
                  .onTapGesture {
                    selectedImages = SelectedProfileImageModel(imageURL: selectIconColumns[index].profileImageUrl!, imageKey: selectIconColumns[index].imageKey)
                  }
              } placeholder: {
                Image(ProfileImageType.apple.imageSource)
                  .resizable()
                  .aspectRatio(contentMode: .fit)
                  .frame(width: 50)
              }
            } else {
              CameraLibraryView(type: selectIconColumns[index].type, imageSelectedCompletion: { image in
                changeSelectedImage = !image.isEmpty
                selectedImages = SelectedProfileImageModel(image: image.first!)
              })
            }
          }
        }
      }
      EveryMealButton(selectEnable: $goToAuthButtonEnabled, title: "확인", didTapped: {
        saveButtonTapped(selectedImages)
      })
    }
    .background(Color.white)
    .onAppear {
      if selectIconColumns.isEmpty {
        Task {
          if let result = try await AdminService().getDefaultImages() {
            let profileImageEntities = result.map { $0.toProfileImageEntity() }
            
            ProfileImageType.allCases.forEach { type in
              switch type {
              case .camera, .library:
                allProfileImageType.append(type)
                self.selectIconColumns.append(.init(type: type, imageResource: type.imageSource))
              default:
                allProfileImageType.append(type)
                self.selectIconColumns.append(profileImageEntities.first(where: { $0.type == type })!)
              }
            }
            
          }
        }
     
      }
    }
  }
}

struct CameraLibraryView: View {
  var type: ProfileImageType
  @State var showImagePicker: Bool = false
  @State var showCameraPicker: Bool = false
  @State private var showingAccessAlert = false
  
  @State var images: [UIImage] = []
  var imageSelectedCompletion: (([UIImage]) -> Void)?
  
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
      CameraPicker(image: $images, isActive: $showCameraPicker, selectedCompletion: { selected in
        imageSelectedCompletion?(selected)
      })
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
    return ImagePicker(configuration: configuration, isPresented: $showImagePicker, selectedImages: $images, selectedCompletion: { selectedImage in
      self.imageSelectedCompletion?(selectedImage)
    })
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

