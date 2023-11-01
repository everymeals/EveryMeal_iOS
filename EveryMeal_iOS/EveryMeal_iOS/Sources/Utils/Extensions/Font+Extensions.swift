//
//  Font+Extensions.swift
//  EveryMeal_iOS
//
//  Created by 김광록 on 2023/11/01.
//

import SwiftUI

extension Font {
  enum PretendardWeight {
    case regular
    case medium
    case bold
    case semibold
    
    var value: String {
      switch self {
      case .regular: return "Pretendard-Regular"
      case .medium: return "Pretendard-Medium"
      case .bold: return "Pretendard-Bold"
      case .semibold: return "Pretendard-SemiBold"
      }
    }
  }
  
  static func pretendard(size: CGFloat, weight: PretendardWeight = .regular) -> Font {
    return .custom(weight.value, size: size)
  }
  
}
