//
//  AllViewQuestionsViewModel.swift
//  iOS-ssumgo
//
//  Created by 정민지 on 11/24/24.
//

import Combine
import SwiftUI

final class AllViewQuestionsViewModel: ObservableObject {
    @Published var myQuestions: [MenteePostDTO] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    @Published var subjectId: Int? = nil
    @Published var query: String = ""
    @Published var sortBy: String = "latest"
    
    private var cancellables = Set<AnyCancellable>()
    private let menteePostsDAO = MenteePostsDAO()
    
    func fetchMyQuestions() {
        isLoading = true
        menteePostsDAO.fetchMenteePosts(
            page: 1,
            sortBy: sortBy
        )
        .sink(receiveCompletion: { [weak self] completion in
            self?.isLoading = false
            switch completion {
            case .failure(let error):
                self?.errorMessage = error.localizedDescription
            case .finished:
                break
            }
        }, receiveValue: { [weak self] response in
            self?.myQuestions = response.postsList
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
        fetchMyQuestions() 
    }
}
