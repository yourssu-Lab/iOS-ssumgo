//
//  SignUpFormViewModel.swift
//  iOS-ssumgo
//
//  Created by 정민지 on 11/23/24.
//

import SwiftUI
import Combine

final class SignUpFormViewModel: ObservableObject {
    @Published var nickName: String = ""
    @Published var password: String = ""
    @Published var isLoading: Bool = false
    @Published var canProceed: Bool = false
    @Published var errorMessage: String? = nil
    
    private var cancellables: Set<AnyCancellable> = []
    private let email: String
    private let sessionToken: String
    private let departmentId: Int = 0
    
    init(email: String) {
        self.email = email
        self.sessionToken = Config.sessionToken ?? ""
        setupValidation()
    }
    
    private func setupValidation() {
        Publishers.CombineLatest($nickName, $password)
            .map { !$0.isEmpty && !$1.isEmpty }
            .receive(on: DispatchQueue.main)
            .assign(to: &$canProceed)
    }
    
    func signUp(onSuccess: @escaping () -> Void) {
        isLoading = true
        SoomsilTestSeverDAO.shared.signUp(
            departmentId: departmentId,
            email: email,
            nickName: nickName,
            password: password,
            sessionToken: sessionToken
        )
        .sink(receiveCompletion: { [weak self] completion in
            guard let self = self else { return }
            self.isLoading = false
            switch completion {
            case .failure(_):
                self.errorMessage = "회원가입 요청에 실패했습니다."
            case .finished:
                break
            }
        }, receiveValue: { [weak self] response in
            guard let self = self else { return }
            switch response {
            case .success:
              
                onSuccess()
            case .failure(let errorDTO):
                self.errorMessage = errorDTO.message
            }
        })
        .store(in: &cancellables)
    }
}
