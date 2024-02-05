//
//  SignupEntity.swift
//  EveryMeal_iOS
//
//  Created by 김하늘 on 2/1/24.
//

import Foundation

struct SignupEntity: Codable, Equatable, Hashable {
  var nickname: String?
  var emailAuthToken: String?
  var emailAuthValue: String?
  var universityIdx: Int?
  var profileImgKey: String?
  var profileImage: Data?
  var profileImageURL: String?
  var email: String?
  var emailSentCount: Int = 0
  
  func toSignupRequest() -> SignupRequest {
    return SignupRequest(
      nickname: self.nickname,
      emailAuthToken: self.emailAuthToken,
      emailAuthValue: self.emailAuthValue,
      universityIdx: self.universityIdx,
      profileImgKey: self.profileImgKey
    )
  }
  
  func toLoginReqeust() -> LoginRequest {
    return LoginRequest(
      emailAuthToken: self.emailAuthToken,
      emailAuthValue: self.emailAuthValue
    )
  }
}
