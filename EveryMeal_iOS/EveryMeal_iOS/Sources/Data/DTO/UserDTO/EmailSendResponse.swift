//
//  EmailSendResponse.swift
//  EveryMeal_iOS
//
//  Created by 김하늘 on 1/7/24.
//

import Foundation

struct EmailSendResponse: Codable, Equatable {
  let localDateTime, message: String?
  let data: TokenModel?
  let errorCode: String?
  
  static func == (lhs: EmailSendResponse, rhs: EmailSendResponse) -> Bool {
    lhs.localDateTime == rhs.localDateTime
  }
}

struct TokenModel: Codable {
  let emailAuthToken: String?
}
