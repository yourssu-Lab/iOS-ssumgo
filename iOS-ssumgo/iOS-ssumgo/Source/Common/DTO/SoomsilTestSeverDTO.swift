//
//  SoomsilTestSeverDTO.swift
//  iOS-ssumgo
//
//  Created by 정민지 on 11/22/24.
//

// MARK: - 이메일 인증 요청

enum EmailVerificationResponseDTO {
    case success(EmailVerificationSuccessDTO)
    case failure(EmailVerificationErrorDTO)
}


struct EmailVerificationSuccessDTO: Decodable {
    let sessionToken: String
    let sessionTokenExpiredIn: Int64
}

struct EmailVerificationErrorDTO: Decodable {
    let timestamp: String
    let status: Int
    let error: String
    let message: String
}

// MARK: - 이메일 인증 확인 요청

enum CheckEmailVerificationResponseDTO {
    case success(CheckEmailVerificationSuccessDTO)
    case failure(CheckEmailVerificationErrorDTO)
}

struct CheckEmailVerificationSuccessDTO: Decodable {
    let isVerified: Bool
}

struct CheckEmailVerificationErrorDTO: Decodable {
    let timestamp: String
    let status: Int
    let error: String
    let message: String
}

// MARK: - 회원가입 요청

enum SignUpResponseDTO {
    case success(SignUpSuccessDTO)
    case failure(SignUpErrorDTO)
}

struct SignUpSuccessDTO: Decodable {
    let accessToken: String
    let accessTokenExpiredIn: Int64
    let refreshToken: String
    let refreshTokenExpiredIn: Int64
}

struct SignUpErrorDTO: Decodable {
    let timestamp: String
    let status: Int
    let error: String
    let message: String
}

// MARK: - 로그인 요청

enum LoginResponseDTO {
    case success(LoginSuccessDTO)
    case failure(LoginErrorDTO)
}

struct LoginSuccessDTO: Decodable {
    let accessToken: String
    let accessTokenExpiredIn: Int64
    let refreshToken: String
    let refreshTokenExpiredIn: Int64
}

struct LoginErrorDTO: Decodable {
    let timestamp: String
    let status: Int
    let error: String
    let message: String
}



// MARK: - 회원탈퇴 요청

enum WithdrawResponseDTO {
    case success
    case failure(WithdrawErrorDTO)
}

struct WithdrawErrorDTO: Decodable {
    let timestamp: String
    let status: Int
    let error: String
    let message: String
}
