//
//  Data+Extensions.swift
//  EveryMeal_iOS
//
//  Created by 김하늘 on 1/29/24.
//

import Foundation

extension Data {
  var prettyJSON: String? {
    guard
      let object = try? JSONSerialization.jsonObject(with: self, options: []),
      let data = try? JSONSerialization.data(withJSONObject: object, options: [.prettyPrinted]),
      let prettyPrintedString = String(data: data, encoding: .utf8)
    else {
      return nil
    }

    return prettyPrintedString
  }
}
