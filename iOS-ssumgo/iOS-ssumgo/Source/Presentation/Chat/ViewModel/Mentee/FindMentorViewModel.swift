//
//  FindMentorViewModel.swift
//  iOS-ssumgo
//
//  Created by 정민지 on 11/24/24.
//

import Combine
import SwiftUI

final class FindMentorViewModel: ObservableObject {
    @Published var mentorComments: [CommentEntity] = []
    @Published var myQuestions: [PostEntity] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    
    @Published var query: String = ""
    @Published var subjectId: Int? = nil
    @Published var sortBy: String = "latest"
    
    private var cancellables = Set<AnyCancellable>()
    
    private let getMentorCommentsDAO = GetMentorCommentsDAO()
    private let getMyQuestionsDAO = GetMyQuestionsDAO()
    
    init() {
        setupBindings()
    }
    
    private func setupBindings() {
        Publishers.CombineLatest3($subjectId, $query, $sortBy)
            .debounce(for: .milliseconds(300), scheduler: RunLoop.main)
            .sink { [weak self] subjectId, query, sortBy in
                self?.getMentorComments(subjectId: subjectId, query: query, sortBy: sortBy)
            }
            .store(in: &cancellables)
        
        $sortBy
            .debounce(for: .milliseconds(300), scheduler: RunLoop.main)
            .sink { [weak self] sortBy in
                self?.getMyQuestions(sortBy: sortBy)
            }
            .store(in: &cancellables)
    }
    
    // MARK: - 멘토 답변 조회 API
    
    func getMentorComments(subjectId: Int?, query: String?, sortBy: String) {
        isLoading = true
        getMentorCommentsDAO.getMentorComments(
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
            DispatchQueue.main.async {
                self?.mentorComments.removeAll()
                self?.mentorComments = response.commentsList
                print("Updated mentorComments:", self?.mentorComments ?? [])
            }
        })
        .store(in: &cancellables)
    }
    
    // MARK: - 나의 질문 조회 API
    
    func getMyQuestions(page: Int = 1, sortBy: String) {
        isLoading = true
        getMyQuestionsDAO.getMyQuestions(page: page, sortBy: sortBy)
            .sink(receiveCompletion: { [weak self] completion in
                self?.isLoading = false
                switch completion {
                case .failure(let error):
                    self?.errorMessage = error.localizedDescription
                case .finished:
                    break
                }
            }, receiveValue: { [weak self] response in
                DispatchQueue.main.async {
                    self?.myQuestions.removeAll()
                    self?.myQuestions = response.postsList
                    print("Updated mentorComments:", self?.myQuestions ?? [])
                }
            })
            .store(in: &cancellables)
    }
}
