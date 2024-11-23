//
//  LoginViewModel.swift
//  iOS-ssumgo
//
//  Created by 정민지 on 11/17/24.
//

import SwiftUI
import Combine

final class LoginViewModel: ObservableObject {
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var isLoginEnabled: Bool = false
    @Published var errorMessage: String? = nil
    @Published var isLoginSuccessful: Bool = false
    @Published var isSignUpTapped: Bool = false

    private var cancellables = Set<AnyCancellable>()
    private let emailDomain = "@soongsil.ac.kr"
    private let loginDAO = LoginDAO()

    init() {
        validateInputs()
    }
}

// MARK: - Methods

extension LoginViewModel {
    private func validateInputs() {
        Publishers.CombineLatest($email, $password)
            .map { email, password in
                !email.isEmpty && !password.isEmpty
            }
            .assign(to: &$isLoginEnabled)
    }
    
    private func extractContentWithinBrackets(from message: String?) -> String? {
        guard let message = message else { return nil }
        let regex = try? NSRegularExpression(pattern: "\\[(.*?)\\]", options: [])
        let results = regex?.matches(in: message, options: [], range: NSRange(location: 0, length: message.utf16.count))
        let content = results?.compactMap {
            Range($0.range(at: 1), in: message).map { String(message[$0]) }
        }
        return content?.joined(separator: " ")
    }
}

// MARK: - API

extension LoginViewModel {
    func login() {
        let fullEmail = email + emailDomain
        
        loginDAO.performLogin(email: fullEmail, password: password)
            .sink(receiveCompletion: { [weak self] completion in
                switch completion {
                case .failure(let error):
                    if let apiError = error as? APIError {
                        self?.errorMessage = self?.extractContentWithinBrackets(from: apiError.errorDescription) ?? "로그인에 실패했습니다."
                    } else {
                        self?.errorMessage = "알 수 없는 네트워크 에러가 발생했습니다."
                    }
                case .finished:
                    break
                }
            }, receiveValue: { [weak self] response in
                if let result = response.result {
                    Config.accessToken = result.accessToken
                    Config.refreshToken = result.refreshToken
                    self?.isLoginSuccessful = true
                    self?.errorMessage = nil
                    print("❤️로그인 성공! Access Token: \(result.accessToken)")
                } else {
                    self?.errorMessage = "로그인에 실패했습니다."
                }
            })
            .store(in: &cancellables)
    }
}
