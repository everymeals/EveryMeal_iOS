//
//  Log.swift
//  EveryMeal_iOS
//
//  Created by 김광록 on 2/16/24.
//

import Foundation

class Log {
  
  // info
  class func i(_ any: Any, filename: String = #file, funcName: String = #function) {
    #if DEBUG
    print("[ℹ️Info][\(sourceFileName(filePath: filename))] \(funcName) -> \(any)")
    #endif
  }

  // error
  @discardableResult
  class func e(_ any: Any, filename: String = #file, funcName: String = #function) -> String {
    var resultString = ""
    #if DEBUG
    resultString = "[⁉️Error][\(sourceFileName(filePath: filename))] \(funcName) -> \(any)"
    print(resultString)
    #endif
    return resultString
  }
  
  // kwangrok's log
  class func kkr(_ any: Any, filename: String = #file, funcName: String = #function) {
    #if DEBUG
    print("[🐳kkr][\(sourceFileName(filePath: filename))] \(funcName) -> \(any)")
    #endif
  }
  
  // Haneul's log
  class func khn(_ any: Any, filename: String = #file, funcName: String = #function) {
    #if DEBUG
    print("[☁️khn][\(sourceFileName(filePath: filename))] \(funcName) -> \(any)")
    #endif
  }
  
  // MARK: Private

  private class func sourceFileName(filePath: String) -> String {
    let components = filePath.components(separatedBy: "/")
    return components.isEmpty ? "" : components.last!
  }
}
