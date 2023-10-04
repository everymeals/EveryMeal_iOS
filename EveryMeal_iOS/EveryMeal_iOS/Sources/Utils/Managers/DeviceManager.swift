//
//  DeviceManager.swift
//  EveryMeal_iOS
//
//  Created by 김광록 on 2023/08/10.
//

import UIKit

final class DeviceManager {
  static let shared = DeviceManager()
  private init() {}
  
  var hasPhysicalHomeButton: Bool {
    if let windowScene = UIApplication.shared.connectedScenes.first(where: { $0.activationState == .foregroundActive }) as? UIWindowScene {
      return windowScene.windows.first?.safeAreaInsets.bottom ?? 0 == 0
    }
    return false
  }
  
}
