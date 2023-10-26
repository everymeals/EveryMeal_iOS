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
  @Binding var selectedImages: [Image]
  
  func makeUIViewController(context: Context) -> PHPickerViewController {
    let controller = PHPickerViewController(configuration: configuration)
    controller.delegate = context.coordinator
    return controller
  }

  func updateUIViewController(_ uiViewController: PHPickerViewController, context: Context) {
    
  }
  
  func makeCoordinator() -> Coordinator {
    Coordinator(self)
  }
  
  class Coordinator: PHPickerViewControllerDelegate {
    private let parent: ImagePicker
    
    init(_ parent: ImagePicker) {
      self.parent = parent
    }
    
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
      print(results)
      var fetchedImages: [Image] = []
      
      for result in results.enumerated() {
        let provider = result.element.itemProvider
        if provider.canLoadObject(ofClass: UIImage.self) {
          provider.loadObject(ofClass: UIImage.self) { [weak self] image, error in
            if let image = image as? UIImage {
              fetchedImages.append(Image(uiImage: image))
              if result.offset == results.count - 1 {
                self?.parent.selectedImages = fetchedImages
                self?.parent.isPresented = false
              }
            }
          }
        }
      }
      
    }
  }
}
