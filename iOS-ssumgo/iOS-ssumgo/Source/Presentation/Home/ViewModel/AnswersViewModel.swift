//
//  AnswersViewModel.swift
//  iOS-ssumgo
//
//  Created by 서준영 on 11/24/24.
//

import SwiftUI
import Combine

class AnswersViewModel: ObservableObject {
    @Published var comments: [PopularCommentDTO] = [] // 댓글 리스트
    @Published var isLoading: Bool = false
    @Published var errorMessage: String? = nil

    private var cancellables = Set<AnyCancellable>()
    private let popularCommentDAO = PopularCommentDAO()

    func fetchCommentData() {
        // 네트워크 요청 시작 시 isLoading을 true로 설정
        isLoading = true
        errorMessage = nil

        popularCommentDAO.fetchPopularComments()
            .sink(receiveCompletion: { completion in
                // 요청이 완료되면 isLoading을 false로 설정
                self.isLoading = false
                switch completion {
                case .failure(let error):
                    self.errorMessage = error.localizedDescription // 에러 메시지 처리
                case .finished:
                    break
                }
            }, receiveValue: { [weak self] response in
                // 응답받은 데이터를 comments에 할당
                self?.comments = response
            })
            .store(in: &cancellables)
    }
}
