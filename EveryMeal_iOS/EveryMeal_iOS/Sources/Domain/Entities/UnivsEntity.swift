//
//  UnivsEntity.swift
//  EveryMeal_iOS
//
//  Created by 김광록 on 1/17/24.
//

struct UnivsEntity: Decodable, Identifiable {
  let idx: Int
  let universityName: String
  let campusName: String
  let universityShortName: String
  
  var id: Int { idx }
}
