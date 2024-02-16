//
//  Log.swift
//  EveryMeal_iOS
//
//  Created by 김광록 on 2/16/24.
//

import Foundation

/// `Log` 클래스는 앱의 로깅을 담당합니다. 디버그 모드에서 정보, 에러, 개발자별 로그를 출력합니다
///
/// 로그 메서드:
/// - `i`: 정보 로그를 출력합니다
/// - `e`: 에러 로그를 출력하고, 문자열로 반환합니다
/// - `kkr`: kwangrok의 개발자 로그를 출력합니다
/// - `khn`: Haneul의 개발자 로그를 출력합니다
///
/// 각 메서드는 파일명과 함수명을 자동으로 로그에 포함시켜, 로그가 발생한 위치를 쉽게 파악할 수 있게 합니다
class Log {
  
  /// 정보 로그를 출력합니다. 디버그 모드에서만 작동합니다
  /// - Parameters:
  ///   - any: 로그로 출력할 내용
  ///   - filename: 파일명. 기본값은 현재 파일명입니다
  ///   - funcName: 함수명. 기본값은 현재 함수명입니다
  class func i(_ any: Any, filename: String = #file, funcName: String = #function) {
    #if DEBUG
    print("[ℹ️Info][\(sourceFileName(filePath: filename))] \(funcName) -> \(any)")
    #endif
  }

  /// 에러 로그를 출력하고, 출력된 로그 문자열을 반환합니다. 디버그 모드에서만 작동합니다
  /// - Parameters:
  ///   - any: 로그로 출력할 내용
  ///   - filename: 파일명. 기본값은 현재 파일명입니다
  ///   - funcName: 함수명. 기본값은 현재 함수명입니다
  /// - Returns: 출력된 로그 문자열
  @discardableResult
  class func e(_ any: Any, filename: String = #file, funcName: String = #function) -> String {
    var resultString = ""
    #if DEBUG
    resultString = "[⁉️Error][\(sourceFileName(filePath: filename))] \(funcName) -> \(any)"
    print(resultString)
    #endif
    return resultString
  }
  
  /// kwangrok의 개발자 로그를 출력합니다. 디버그 모드에서만 작동합니다
  /// - Parameters:
  ///   - any: 로그로 출력할 내용
  ///   - filename: 파일명. 기본값은 현재 파일명입니다
  ///   - funcName: 함수명. 기본값은 현재 함수명입니다
  class func kkr(_ any: Any, filename: String = #file, funcName: String = #function) {
    #if DEBUG
    print("[🐳kkr][\(sourceFileName(filePath: filename))] \(funcName) -> \(any)")
    #endif
  }
  
  /// Haneul의 개발자 로그를 출력합니다. 디버그 모드에서만 작동합니다
  /// - Parameters:
  ///   - any: 로그로 출력할 내용
  ///   - filename: 파일명. 기본값은 현재 파일명입니다
  ///   - funcName: 함수명. 기본값은 현재 함수명입니다
  class func khn(_ any: Any, filename: String = #file, funcName: String = #function) {
    #if DEBUG
    print("[☁️khn][\(sourceFileName(filePath: filename))] \(funcName) -> \(any)")
    #endif
  }
  
  /// 파일 경로에서 파일명만 추출합니다
  /// - Parameter filePath: 파일 경로
  /// - Returns: 파일명
  private class func sourceFileName(filePath: String) -> String {
    let components = filePath.components(separatedBy: "/")
    return components.isEmpty ? "" : components.last!
  }
}
