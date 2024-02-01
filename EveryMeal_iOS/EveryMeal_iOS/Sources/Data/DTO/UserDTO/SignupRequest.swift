//
//  SignupRequest.swift
//  EveryMeal_iOS
//
//  Created by 김하늘 on 1/29/24.
//

import Foundation

struct SignupRequest: Codable, Equatable, Hashable {
  var nickname: String?
  var emailAuthToken: String?
  var emailAuthValue: String?
  var universityIdx: Int?
  var profileImgKey: String?
}
