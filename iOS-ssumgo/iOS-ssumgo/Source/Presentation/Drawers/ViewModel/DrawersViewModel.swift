//
//  DrawersViewModel.swift
//  iOS-ssumgo
//
//  Created by 정민지 on 11/25/24.
//

import Combine
import SwiftUI

final class DrawersViewModel: ObservableObject {
    @Published var mentorComments: [CommentEntity] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    @Published var selectedSortBy: String = "latest"

    private var cancellables = Set<AnyCancellable>()
    private let drawersDAO = DrawersDAO()

    func getMentorComments(page: Int = 1) {
        isLoading = true
        drawersDAO.getDrawers(page: page, sortBy: selectedSortBy, size: 10)
            .sink(receiveCompletion: { [weak self] completion in
                self?.isLoading = false
                switch completion {
                case .failure(let error):
                    self?.errorMessage = error.localizedDescription
                    print("Error: \(error.localizedDescription)")
                case .finished:
                    break
                }
            }, receiveValue: { [weak self] response in
                DispatchQueue.main.async {
                    self?.mentorComments = response.commentsList
                }
            })
            .store(in: &cancellables)
    }

    func updateSortBy(selectedSortBy: String) {
        self.selectedSortBy = selectedSortBy
        getMentorComments(page: 1)
    }
}
