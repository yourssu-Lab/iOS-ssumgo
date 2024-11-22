//
//  MyPageViewModel.swift
//  iOS-ssumgo
//
//  Created by 정민지 on 11/22/24.
//

import SwiftUI
import Combine

final class MyPageViewModel: ObservableObject {
    @Published var nickname: String = ""
    @Published var department: String = ""
    @Published var studentIdNumber: String = ""
    @Published var profileImageUrl: String = ""
    @Published var rating: String? = nil
    @Published var isLoading: Bool = false
    @Published var errorMessage: String? = nil

    private var cancellables = Set<AnyCancellable>()
    private let myPageDAO = MyPageDAO()
    
    func fetchMyPageData() {
        isLoading = true
        errorMessage = nil
        
        myPageDAO.fetchProfile()
            .sink(receiveCompletion: { [weak self] completion in
                guard let self = self else { return }
                self.isLoading = false
                switch completion {
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                case .finished:
                    break
                }
            }, receiveValue: { [weak self] profile in
                self?.nickname = profile.nickname
                self?.department = profile.department
                self?.studentIdNumber = "\(profile.studentIdNumber)"
                self?.profileImageUrl = profile.profileImageUrls.largeUrl
                if let rating = profile.rating {
                    self?.rating = String(format: "%.1f", rating)
                }
            })
            .store(in: &cancellables)
    }
}
