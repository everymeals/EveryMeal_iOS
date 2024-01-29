//
//  SignupRequest.swift
//  EveryMeal_iOS
//
//  Created by 김하늘 on 1/29/24.
//

import Foundation

struct SignupRequest: Decodable {
  let nickname: String
  let emailAuthToken: String
  let emailAuthValue: String
  let universityIdx: Int
  let profileImgKey: String
}
