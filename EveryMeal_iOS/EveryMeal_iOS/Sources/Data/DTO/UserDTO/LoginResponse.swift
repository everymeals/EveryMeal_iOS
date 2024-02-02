//
//  LoginResponse.swift
//  EveryMeal_iOS
//
//  Created by 김하늘 on 2/2/24.
//

import Foundation

struct LoginResponse: Codable {
  var accessToken: String?
  var nickname: String?
  var profileImg: String?
  
  var errorCode: String?
  var localDateTime: String?
  var message: String?
}
