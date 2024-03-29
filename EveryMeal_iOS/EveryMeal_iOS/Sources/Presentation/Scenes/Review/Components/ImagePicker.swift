//
//  ImagePicker.swift
//  EveryMeal_iOS
//
//  Created by 김하늘 on 2023/09/29.
//

import UIKit
import SwiftUI
import PhotosUI

struct ImagePicker: UIViewControllerRepresentable {
  let configuration: PHPickerConfiguration
  @Binding var isPresented: Bool
  @Binding var selectedImages: [UIImage]
  var selectedCompletion: (([UIImage]) -> Void)?
  
  func makeUIViewController(context: Context) -> PHPickerViewController {
    let controller = PHPickerViewController(configuration: configuration)
    controller.delegate = context.coordinator
    return controller
  }

  func updateUIViewController(_ uiViewController: PHPickerViewController, context: Context) {
    
  }
  
  func makeCoordinator() -> Coordinator {
    Coordinator(self, completion: selectedCompletion)
  }
}

class Coordinator: PHPickerViewControllerDelegate {
  private let parent: ImagePicker
  var selectedCompletion: (([UIImage]) -> Void)?
  
  init(_ parent: ImagePicker, completion: (([UIImage]) -> Void)?) {
    self.parent = parent
    selectedCompletion = completion
  }
  
  func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
    print(results)
    var fetchedImages: [UIImage] = []
    
    for result in results.enumerated() {
      let provider = result.element.itemProvider
      if provider.canLoadObject(ofClass: UIImage.self) {
        provider.loadObject(ofClass: UIImage.self) { [weak self] image, error in
          if let image = image as? UIImage {
            fetchedImages.append(image)
            if result.offset == results.count - 1 {
              self?.parent.selectedImages = fetchedImages
              self?.selectedCompletion?(fetchedImages)
              self?.parent.isPresented = false
            }
          }
        }
      }
    }
  }
}
