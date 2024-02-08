//
//  Type.swift
//  EveryMeal_iOS
//
//  Created by 김하늘 on 1/5/24.
//

enum EverMealErrorType: Error, Equatable {
  case invalidURL
  case invalidJSONParameter
  case invalidJSONResponse
  case fail
  
  case failWithError(ErrorCode)
}

/*
enum ErrorCode: String {
  case MEL0001 = "Meal Not Found"
  case MEL0002 = "등록된 식당이 아닙니다."
  case MEL0003 = "등록된 학교가 아닙니다."
  case MEL0004 = "동일한 데이터를 갖는 식단 데이터가 이미 존재합니다."
  case COM0001 = "Request의 Data Type이 올바르지 않습니다."
  case USR0001 = "등록된 유저가 아닙니다."
  case USR0002 = "인증 시간이 만료되었습니다."
  case USR0003 = "인증에 실패하였습니다."
  case USR0004 = "이미 등록된 이메일입니다."
  case USR0005 = "이미 등록된 닉네임입니다."
  case USR0006 = "이미 탈퇴한 유저입니다."
  case TKN0001 = "해당 토큰은 유효하지 않습니다."
  case TKN0002 = "토큰이 만료되었습니다."
  case RV0001 = "등록된 리뷰가 아닙니다."
  case RV0002 = "해당 리뷰에 대한 권한이 없습니다."
  case RV0003 = "이미 해당 리뷰에 대한 평가를 하였습니다."
  case RV0004 = "등록된 리뷰 평가가 아닙니다."
  case STR0001 = "등록된 가게가 아닙니다."
  case RPT0001 = "등록된 신고가 아닙니다."
  case RPT0002 = "이미 신고한 리뷰입니다.(RPT0002)"
  case RPT0003 = "자신의 리뷰를 신고할 수 없습니다."
  case RPT0004 = "이미 신고한 리뷰입니다.(RPT0004)"
  case SRV0001 = "서버에 문제가 발생하였습니다."
  case SRV0002 = "요청한 경로가 존재하지 않습니다."
}
*/

enum ErrorCode: String {
  case notDefined
  case MEL0001
  case MEL0002
  case MEL0003
  case MEL0004
  case COM0001
  case USR0001
  case USR0002
  case USR0003
  case USR0004
  case USR0005
  case USR0006
  case TKN0001
  case TKN0002
  case RV0001
  case RV0002
  case RV0003
  case RV0004
  case STR0001
  case RPT0001
  case RPT0002
  case RPT0003
  case RPT0004
  case SRV0001
  case SRV0002
}
