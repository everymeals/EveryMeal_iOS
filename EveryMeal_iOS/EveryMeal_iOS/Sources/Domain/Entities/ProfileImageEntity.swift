//
//  ProfileImageEntity.swift
//  EveryMeal_iOS
//
//  Created by 김하늘 on 2/16/24.
//

import Foundation

struct ProfileImageEntity {
  var type: ProfileImageType
  var profileImageUrl: URL?
  var imageResource: ImageResource?
  var imageKey: String?
}

// 서버에서 카메라, 라이브러리 제외하고 1~6으로 내려주셔서 아래와 같이 Raw value 세팅함
enum ProfileImageType: Int, CaseIterable {
  case camera = 0
  case rice = 1
  case sushi = 2
  case puding = 3
  case library = 7
  case apple = 4
  case egg = 5
  case ramen = 6
  
  var imageSource: ImageResource {
    switch self {
    case .camera: return .iconCameraMono
    case .library: return .iconPictureMono
    default: return .apple90
    }
  }
}
