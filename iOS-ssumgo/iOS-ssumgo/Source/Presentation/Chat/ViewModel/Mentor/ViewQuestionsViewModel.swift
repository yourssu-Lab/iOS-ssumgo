//
//  ViewQuestionsViewModel.swift
//  iOS-ssumgo
//
//  Created by 정민지 on 11/24/24.
//

import Combine
import SwiftUI

final class ViewQuestionsViewModel: ObservableObject {
    @Published var menteeQuestions: [MenteePostDTO] = []
    @Published var myAnswers: [CommentDTO] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    @Published var query: String = ""
    @Published var subjectId: Int? = nil
    @Published var sortBy: String = "latest"
    
    private var cancellables = Set<AnyCancellable>()
    
    private let subjectPostsDAO = SubjectPostsDAO()
    private let studentsCommentsDAO = StudentsCommentsDAO()
    
    func fetchMenteeQuestions() {
        guard let subjectId = subjectId else {
            menteeQuestions = []
            return
        }
        
        isLoading = true
        subjectPostsDAO.fetchPosts(subjectId: subjectId, page: 1, sortBy: sortBy, size: 10)
            .sink(receiveCompletion: { [weak self] completion in
                self?.isLoading = false
                switch completion {
                case .failure(let error):
                    self?.errorMessage = error.localizedDescription
                case .finished:
                    break
                }
            }, receiveValue: { [weak self] response in
                self?.menteeQuestions = response.postsList
            })
            .store(in: &cancellables)
    }
    
    func fetchMyAnswers(page: Int = 1) {
        isLoading = true
        studentsCommentsDAO.fetchStudentComments(page: page, sortBy: sortBy, size: 10)
            .sink(receiveCompletion: { [weak self] completion in
                self?.isLoading = false
                switch completion {
                case .failure(let error):
                    self?.errorMessage = error.localizedDescription
                case .finished:
                    break
                }
            }, receiveValue: { [weak self] response in
                self?.myAnswers = response.commentsList
            })
            .store(in: &cancellables)
    }
    
    func updateSortBy(selectedSortBy: String) {
        sortBy = (selectedSortBy == "생성순") ? "earliest" : "latest"
        fetchMenteeQuestions()
        fetchMyAnswers()
    }
}
