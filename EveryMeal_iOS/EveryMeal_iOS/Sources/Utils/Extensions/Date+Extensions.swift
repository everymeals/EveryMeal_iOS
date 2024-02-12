//
//  Date+Extensions.swift
//  EveryMeal_iOS
//
//  Created by 김광록 on 2/12/24.
//

import Foundation

extension Date {
  func toString(format: String = "yyyy-MM-dd") -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.timeZone = .autoupdatingCurrent
    dateFormatter.locale = .current
    dateFormatter.dateFormat = format
    return dateFormatter.string(from: self)
  }
  
  func toKoreanDateString() -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.locale = Locale(identifier: "ko_KR")
    dateFormatter.setLocalizedDateFormatFromTemplate("MMMMdEEEE")
    return dateFormatter.string(from: self)
  }
  
}
