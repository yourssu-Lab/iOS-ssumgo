//
//  SoomsilTestSeverDAO.swift
//  iOS-ssumgo
//
//  Created by 정민지 on 11/22/24.
//

import SwiftUI
import Combine

final class SoomsilTestSeverDAO {
    static let shared = SoomsilTestSeverDAO()
    private init() {}

    // MARK: - 이메일 인증 요청
    
    func requestEmailVerification(email: String) -> AnyPublisher<EmailVerificationResponseDTO, Error> {
        let endpoint = "/v2/auth/verification/email"
        let body: [String: Any] = [
            "email": email,
            "verificationType": "SIGN_UP"
        ]

        guard let jsonData = try? JSONSerialization.data(withJSONObject: body) else {
            return Fail(error: URLError(.badURL))
                .eraseToAnyPublisher()
        }

        return ExternalAPIClient.shared.soomsilTestSeverRequest(
            endpoint: endpoint,
            method: .post,
            headers: ["Content-Type": "application/json"],
            body: jsonData
        )
        .tryMap { data in
            if let successDTO = try? JSONDecoder().decode(EmailVerificationSuccessDTO.self, from: data) {
                return .success(successDTO)
            } else if let errorDTO = try? JSONDecoder().decode(EmailVerificationErrorDTO.self, from: data) {
                return .failure(errorDTO)
            } else {
                throw URLError(.cannotParseResponse)
            }
        }
        .eraseToAnyPublisher()
    }
    
    // MARK: - 이메일 인증 확인 요청
    
    func checkEmailVerification(sessionToken: String) -> AnyPublisher<CheckEmailVerificationResponseDTO, Error> {
        return ExternalAPIClient.shared.soomsilTestSeverRequest(
            endpoint: "/v2/auth/verification/check?session=\(sessionToken)",
            method: .get,
            headers: ["Content-Type": "application/json"],
            body: nil
        )
        .tryMap { data in
            if let successDTO = try? JSONDecoder().decode(CheckEmailVerificationSuccessDTO.self, from: data) {
                return .success(successDTO)
            } else if let errorDTO = try? JSONDecoder().decode(CheckEmailVerificationErrorDTO.self, from: data) {
                return .failure(errorDTO)
            } else {
                throw URLError(.cannotParseResponse)
            }
        }
        .eraseToAnyPublisher()
    }

    // MARK: - 회원가입 요청
    
    func signUp(
        departmentId: Int,
        email: String,
        nickName: String,
        password: String,
        sessionToken: String
    ) -> AnyPublisher<SignUpResponseDTO, Error> {
        let endpoint = "/v2/auth/sign-up"
        let body: [String: Any] = [
            "departmentId": departmentId,
            "email": email,
            "nickName": nickName,
            "password": password,
            "sessionToken": sessionToken
        ]

        guard let jsonData = try? JSONSerialization.data(withJSONObject: body) else {
            return Fail(error: URLError(.badURL))
                .eraseToAnyPublisher()
        }

        return ExternalAPIClient.shared.soomsilTestSeverRequest(
            endpoint: endpoint,
            method: .post,
            headers: ["Content-Type": "application/json"],
            body: jsonData
        )
        .tryMap { data in
            if let successDTO = try? JSONDecoder().decode(SignUpSuccessDTO.self, from: data) {
                return .success(successDTO)
            } else if let errorDTO = try? JSONDecoder().decode(SignUpErrorDTO.self, from: data) {
                return .failure(errorDTO)
            } else {
                throw URLError(.cannotParseResponse)
            }
        }
        .eraseToAnyPublisher()
    }

    // MARK: - 로그인 요청
    
    func signIn(email: String, password: String) -> AnyPublisher<LoginResponseDTO, Error> {
        let endpoint = "/v2/auth/sign-in"
        let body: [String: Any] = [
            "email": email,
            "password": password
        ]

        guard let jsonData = try? JSONSerialization.data(withJSONObject: body) else {
            return Fail(error: URLError(.badURL))
                .eraseToAnyPublisher()
        }

        return ExternalAPIClient.shared.soomsilTestSeverRequest(
            endpoint: endpoint,
            method: .post,
            headers: ["Content-Type": "application/json"],
            body: jsonData
        )
        .tryMap { data in
            if let successDTO = try? JSONDecoder().decode(LoginSuccessDTO.self, from: data) {
                return .success(successDTO)
            } else if let errorDTO = try? JSONDecoder().decode(LoginErrorDTO.self, from: data) {
                return .failure(errorDTO)
            } else {
                throw URLError(.cannotParseResponse)
            }
        }
        .eraseToAnyPublisher()
    }

    // MARK: - 회원탈퇴 요청
    
    func withdraw(accessToken: String) -> AnyPublisher<WithdrawResponseDTO, Error> {
        let endpoint = "/v2/auth/withdraw"

        return ExternalAPIClient.shared.soomsilTestSeverRequest(
            endpoint: endpoint,
            method: .post,
            headers: ["Authorization": "Bearer \(accessToken)"]
        )
        .tryMap { data in
            if data.isEmpty {
                return .success
            } else if let errorDTO = try? JSONDecoder().decode(WithdrawErrorDTO.self, from: data) {
                return .failure(errorDTO)
            } else {
                throw URLError(.cannotParseResponse)
            }
        }
        .eraseToAnyPublisher()
    }
}
