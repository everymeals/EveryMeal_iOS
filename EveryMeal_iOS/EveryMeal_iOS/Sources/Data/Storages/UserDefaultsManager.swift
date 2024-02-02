//
//  UserDefaults.swift
//  EveryMeal_iOS
//
//  Created by 김광록 on 1/17/24.
//

import UIKit

struct UserDefaultsManager {
  
  enum KeyType: String {
    case isUnivChosen  // 대학 선택한지
    case emailAuthToken
    case emailAuthValue
  }
  
  /// UserDefault에서 키값으로 저장하기
  static func setValue(_ key: KeyType, value: Any?) {
    let userDefaults = UserDefaults.standard
    userDefaults.set(value, forKey: key.rawValue)
    userDefaults.synchronize()
  }

  /// UserDefault에서 String키값으로 불러오기
  static func getString(_ key: KeyType) -> String {
    UserDefaults.standard.string(forKey: key.rawValue) ?? ""
  }

  /// UserDefault에서 Int키값으로 불러오기
  static func getInt(_ key: KeyType) -> Int {
    UserDefaults.standard.integer(forKey: key.rawValue)
  }

  /// UserDefault에서 Bool키값으로 불러오기
  static func getBool(_ key: KeyType) -> Bool {
    UserDefaults.standard.bool(forKey: key.rawValue)
  }

  static func getData(_ key: KeyType) -> Data? {
    UserDefaults.standard.data(forKey: key.rawValue)
  }

  static func getDictionary(_ key: KeyType) -> [String: Any]? {
    UserDefaults.standard.dictionary(forKey: key.rawValue)
  }

  static func getDate(_ key: KeyType) -> Date? {
    UserDefaults.standard.object(forKey: key.rawValue) as? Date
  }

  static func getArrayString(_ key: KeyType) -> [String]? {
    UserDefaults.standard.object(forKey: key.rawValue) as? [String]
  }
  
  static func getArray(_ key: KeyType) -> [Any]? {
    UserDefaults.standard.array(forKey: key.rawValue)
  }

  /// UserDefault에서 키값으로 삭제하기
  static func removeKey(_ key: KeyType) {
    UserDefaults.standard.removeObject(forKey: key.rawValue)
  }

  // 추후 로그아웃과 같은 기능에 넣으면 됨
  static func removeAllDefault() {
    // 지우지말아야할거는 여기다 입력을...
    let leftDomains = [""]
    let userDefaults = UserDefaults.standard
    userDefaults.dictionaryRepresentation().keys.forEach { keys in
      // 도메인정보 빼고 다 삭제함
      if !leftDomains.contains(keys) {
        userDefaults.removeObject(forKey: keys)
      }
    }
    userDefaults.synchronize()
  }


}
