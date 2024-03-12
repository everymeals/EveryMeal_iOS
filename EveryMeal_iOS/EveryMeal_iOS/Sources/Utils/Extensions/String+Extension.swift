//
//  String+Extension.swift
//  EveryMeal_iOS
//
//  Created by 김하늘 on 2/25/24.
//

import Foundation

extension String {
  func toDate(_ format: String = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'") -> Date? {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = format
    dateFormatter.timeZone = TimeZone(identifier: "UTC")
    if let date = dateFormatter.date(from: self) {
      return date
    } else {
      return nil
    }
  }
}
