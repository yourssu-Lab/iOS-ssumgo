//
//  EmailAuthViewModel.swift
//  iOS-ssumgo
//
//  Created by 정민지 on 11/22/24.
//

import SwiftUI
import Combine

final class EmailAuthViewModel: ObservableObject {
    @Published var email: String
    @Published var timerText: String = "08:00"
    @Published var isResending: Bool = false
    @Published var isLoading: Bool = false
    @Published var canProceed: Bool = false
    @Published var errorMessage: String?
    private var timer: AnyCancellable?
    
    private var cancellables: Set<AnyCancellable> = []
    
    init(email: String) {
        self.email = email
        startTimer()
        requestEmailVerification()
    }
    
    func requestEmailVerification() {
        isLoading = true
        SoomsilTestSeverDAO.shared.requestEmailVerification(email: email)
            .sink(receiveCompletion: { [weak self] completion in
                guard let self = self else { return }
                self.isLoading = false
                switch completion {
                case .failure(let error):
                    if let apiError = error as? APIError {
                        print("API 호출 실패: 상태 코드 \(String(describing: apiError.errorDescription))")
                        DispatchQueue.main.async {
                            self.errorMessage = apiError.errorDescription
                        }
                    } else {
                        print("알 수 없는 에러: \(error.localizedDescription)")
                        DispatchQueue.main.async {
                            self.errorMessage = "이메일 인증 요청에 실패했습니다."
                        }
                    }
                case .finished:
                    break
                }
            }, receiveValue: { [weak self] response in
                guard let self = self else { return }
                
                switch response {
                case .success(let successDTO):
                    Config.sessionToken = successDTO.sessionToken
                    self.canProceed = true
                case .failure(let errorDTO):
                    print("이메일 인증 실패: \(errorDTO.message)")
                    DispatchQueue.main.async {
                        if errorDTO.error == "Validate-003" {
                            self.errorMessage = "이미 사용중인 메일입니다."
                        } else {
                            self.errorMessage = "이메일 인증요청에 실패했습니다."
                        }
                    }
                }
            })
            .store(in: &cancellables)
    }
    
    func checkEmailVerification(completion: @escaping (Bool) -> Void) {
           isLoading = true
           SoomsilTestSeverDAO.shared.checkEmailVerification(sessionToken: Config.sessionToken ?? "")
               .sink(receiveCompletion: { [weak self] result in
                   guard let self = self else { return }
                   self.isLoading = false

                   switch result {
                   case .failure(let error):
                       print("이메일 인증 확인 실패: \(error.localizedDescription)")
                       self.errorMessage = "이메일 인증 확인에 실패했습니다."
                       completion(false)
                   case .finished:
                       break
                   }
               }, receiveValue: { response in
                   switch response {
                   case .success(let successDTO):
                       print("이메일 인증 확인 성공: \(successDTO.isVerified)")
                       completion(successDTO.isVerified)
                   case .failure(let errorDTO):
                       print("이메일 인증 확인 실패: \(errorDTO.message)")
                       self.errorMessage = errorDTO.message
                       completion(false)
                   }
               })
               .store(in: &cancellables)
       }
    
    func resendEmail() {
        isResending = true
        requestEmailVerification()
        restartTimer()
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.isResending = false
        }
    }
    
    private func startTimer() {
        var seconds = 8 * 60
        timer = Timer.publish(every: 1, on: .main, in: .common)
            .autoconnect()
            .sink { [weak self] _ in
                guard let self = self else { return }
                if seconds > 0 {
                    seconds -= 1
                    self.timerText = String(format: "%02d:%02d", seconds / 60, seconds % 60)
                } else {
                    self.timer?.cancel()
                    self.canProceed = false
                }
            }
    }
    
    private func restartTimer() {
        timer?.cancel()
        startTimer()
    }
}
