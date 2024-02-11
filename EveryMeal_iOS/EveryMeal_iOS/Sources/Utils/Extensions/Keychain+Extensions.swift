//
//  Keychain+Extensions.swift
//  EveryMeal_iOS
//
//  Created by 김하늘 on 2/8/24.
//

import Foundation

import KeychainSwift

enum KeychainKey: String, CaseIterable {
  case accessToken
  case refreshToken
}

extension KeychainSwift {
  @discardableResult
  func set(_ value: String, forKey key: KeychainKey,
           withAccess access: KeychainSwiftAccessOptions? = nil) -> Bool {
    
    if let value = value.data(using: String.Encoding.utf8) {
      return set(value, forKey: key.rawValue, withAccess: access)
    }
    
    return false
  }
  
  func get(_ key: KeychainKey) -> String? {
    if let data = getData(key.rawValue) {
      
      if let currentString = String(data: data, encoding: .utf8) {
        return currentString
      }
      
      lastResultCode = -67853 // errSecInvalidEncoding
    }

    return nil
  }
}
