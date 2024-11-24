//
//  FindMentorViewModel.swift
//  iOS-ssumgo
//
//  Created by 정민지 on 11/24/24.
//

import Combine
import SwiftUI

final class FindMentorViewModel: ObservableObject {
    @Published var mentorAnswers: [CommentDTO] = []
    @Published var myQuestions: [MenteePostDTO] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    
    @Published var query: String = ""
    @Published var subjectId: Int? = nil
    @Published var sortBy: String = "latest"
    
    private var cancellables = Set<AnyCancellable>()
    
    private let studentsCommentsDAO = StudentsCommentsDAO()
    private let subjectCommentsDAO = SubjectCommentsDAO()
    private let menteePostsDAO = MenteePostsDAO()
    
    init() {
        setupBindings()
    }
    
    private func setupBindings() {
        Publishers.CombineLatest3($subjectId, $query, $sortBy)
            .debounce(for: .milliseconds(300), scheduler: RunLoop.main)
            .sink { [weak self] subjectId, query, sortBy in
                self?.fetchMentorAnswers(subjectId: subjectId, query: query, sortBy: sortBy)
            }
            .store(in: &cancellables)
        
        $sortBy
            .debounce(for: .milliseconds(300), scheduler: RunLoop.main)
            .sink { [weak self] sortBy in
                self?.fetchMyQuestions(sortBy: sortBy)
            }
            .store(in: &cancellables)
    }
    
    func fetchMentorAnswers(subjectId: Int?, query: String?, sortBy: String) {
        isLoading = true
        subjectCommentsDAO.fetchComments(
            subjectId: subjectId ?? 0,
            page: 1,
            sortBy: sortBy,
            size: 10,
            query: query ?? ""
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
            self?.mentorAnswers = response.commentsList
        })
        .store(in: &cancellables)
    }
    
    func fetchMyQuestions(page: Int = 1, sortBy: String) {
        isLoading = true
        menteePostsDAO.fetchMenteePosts(page: page, sortBy: sortBy)
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
}
