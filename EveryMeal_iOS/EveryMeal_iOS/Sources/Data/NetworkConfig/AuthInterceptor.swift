//
//  AuthInterceptor.swift
//  EveryMeal_iOS
//
//  Created by 김하늘 on 2/8/24.
//

import Foundation

import Alamofire
import Moya
import KeychainSwift

final class AuthInterceptor: RequestInterceptor {
  
  static let shared = AuthInterceptor()
  let keychain = KeychainSwift()
  
  private init() {}
  
//  func adapt(_ urlRequest: URLRequest, for session: Session, completion: @escaping (Result<URLRequest, Error>) -> Void) {
//    guard urlRequest.url?.absoluteString.hasPrefix(Config.baseURL) == true,
//          let accessToken = UserManager.shared.accessToken,
//          let refreshToken = UserManager.shared.refreshToken
//    else {
//      completion(.success(urlRequest))
//      return
//    }
//    
//    var urlRequest = urlRequest
//    urlRequest.setValue(accessToken, forHTTPHeaderField: "accessToken")
//    urlRequest.setValue(refreshToken, forHTTPHeaderField: "refreshToken")
//    print("adator 적용 \(urlRequest.headers)")
//    completion(.success(urlRequest))
//  }
  
  func retry(_ request: Request, for session: Session, dueTo error: Error, completion: @escaping (RetryResult) -> Void) {
    
    guard let response = request.task?.response as? HTTPURLResponse,
            response.statusCode == 401 else {
      completion(.doNotRetryWithError(error))
      return
    }
    
    // 토큰 갱신 API 호출
    fetchDataWithCookie { [weak self] result in
      switch result {
      case let .success(data):
        do {
          let decodedResult = try JSONDecoder().decode(EveryMealDefaultResponse<String>.self, from: data)
          if let newAccessToken = decodedResult.data {
            self?.keychain.set(newAccessToken, forKey: .accessToken)
            completion(.retry)
          } else {
            completion(.retry)
          }
        } catch {
          completion(.doNotRetry)
        }
      case .failure:
        completion(.doNotRetry)
      }
    }
  }
  
  func fetchDataWithCookie(completion: @escaping (Result<Data, Error>) -> Void) {
    guard let url = URL(string: URLConstant.access.url) else {
      completion(.failure(NSError(domain: "Invalid URL", code: 0, userInfo: nil)))
      return
    }
    guard let refreshToken = keychain.get(.refreshToken) else {
      completion(.failure(EverMealErrorType.fail))
      return
    }
    let headers: HTTPHeaders = ["Cookie": refreshToken]
    
    AF.request(url, headers: headers)
      .validate()
      .responseData { response in
        switch response.result {
        case .success(let data):
          completion(.success(data))
        case .failure(let error):
          completion(.failure(error))
        }
      }
  }
}
