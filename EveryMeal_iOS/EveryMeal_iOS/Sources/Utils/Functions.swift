//
//  Functions.swift
//  EveryMeal_iOS
//
//  Created by 김하늘 on 10/12/23.
//

import Photos
import UIKit

class Functions {
  // 앱 설정 페이지
  public static func openAppSettings() {
    guard let settingURL = URL(string: UIApplication.openSettingsURLString), UIApplication.shared.canOpenURL(settingURL) else { return }
    UIApplication.shared.open(settingURL, options: [:])
  }
  
  public static func getAppVersion() -> String {
    let appVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? ""
    return appVersion
  }
}
