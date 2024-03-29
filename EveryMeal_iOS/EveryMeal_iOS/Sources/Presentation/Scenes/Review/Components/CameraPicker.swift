//
//  CameraPicker.swift
//  EveryMeal_iOS
//
//  Created by 김하늘 on 12/27/23.
//

import UIKit
import SwiftUI

struct CameraPicker: UIViewControllerRepresentable {
  typealias UIViewControllerType = UIImagePickerController
  typealias Coordinator = CameraPickerCoordinator
  
  @Binding var image: [UIImage]
  @Binding var isActive: Bool
  var selectedCompletion: (([UIImage]) -> Void)?
  
  func makeUIViewController(context: Context) -> UIImagePickerController {
    let picker = UIImagePickerController()
    picker.sourceType = .camera
    picker.delegate = context.coordinator
    picker.allowsEditing = true
    
    return picker
  }
  
  func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) { }
  
  func makeCoordinator() -> CameraPickerCoordinator {
    return CameraPickerCoordinator(image: $image, isActive: $isActive, completion: self.selectedCompletion)
  }
}

class CameraPickerCoordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
  
  @Binding var image: [UIImage]
  @Binding var isActive: Bool
  var selectedCompletion: (([UIImage]) -> Void)?
  
  init(image: Binding<[UIImage]>, isActive: Binding<Bool>, completion: (([UIImage]) -> Void)?) {
    _image = image
    _isActive = isActive
    selectedCompletion = completion
  }
  
  func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
    if let uiImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
      self.image = [uiImage]
      self.selectedCompletion?([uiImage])
      
      self.isActive = false
    }
  }
  
  func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
    self.isActive = false
  }
}
