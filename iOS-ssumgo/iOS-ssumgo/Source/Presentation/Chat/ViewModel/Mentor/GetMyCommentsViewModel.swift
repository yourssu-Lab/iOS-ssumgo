//
//  GetMyCommentsViewModel.swift
//  iOS-ssumgo
//
//  Created by 정민지 on 11/24/24.
//

import Combine
import SwiftUI

final class GetMyCommentsViewModel: ObservableObject {
    @Published var myComments: [CommentEntity] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    @Published var query: String = ""
    @Published var subjectId: Int? = nil
    @Published var sortBy: String = "latest"
    
    private var cancellables = Set<AnyCancellable>()
    
    private let getMyCommentsDAO = GetMyCommentsDAO()
    
    func getMentorComments() {
        isLoading = true
        getMyCommentsDAO.getMyComments(page: 1, sortBy: sortBy, size: 10)
            .sink(receiveCompletion: { [weak self] completion in
                self?.isLoading = false
                switch completion {
                case .failure(let error):
                    self?.errorMessage = error.localizedDescription
                case .finished:
                    break
                }
            }, receiveValue: { [weak self] response in
                self?.myComments = response.commentsList
            })
            .store(in: &cancellables)
    }
    
    func updateSortBy(selectedSortBy: String) {
        switch selectedSortBy {
        case "최신순":
            sortBy = "latest"
        case "생성순":
            sortBy = "earliest"
        default:
            sortBy = "latest"
        }
        getMentorComments()
    }
}
