//
//  SignupResponse.swift
//  EveryMeal_iOS
//
//  Created by 김하늘 on 1/29/24.
//

import Foundation

struct SignupResponse: Codable {
  let accessToken: String?
  let nickname: String?
  let profileImg: String?
}
