//
//  PostWriteViewModel.swift
//  iOS-ssumgo
//
//  Created by 서준영 on 11/24/24.
//

import Combine
import SwiftUI

final class PostWriteViewModel: ObservableObject {
    // 사용자 입력
    @Published var subjectId: Int = 0
    @Published var title: String = ""
    @Published var content: String = ""
    
    // 상태 관리
    @Published var isLoading: Bool = false
    @Published var errorMessage: String? = nil
    @Published var postResult: PostWriteDTO? = nil
    
    private var cancellables = Set<AnyCancellable>()
    private let postWriteDAO = PostWriteDAO()
    
    func submitPost() {
        // 로딩 상태 초기화
        isLoading = true
        errorMessage = nil
        postResult = nil
        
        postWriteDAO.performPost(subjectId: subjectId, title: title, content: content)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                guard let self = self else { return }
                self.isLoading = false
                
                switch completion {
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                case .finished:
                    break
                }
            } receiveValue: { [weak self] response in
                guard let self = self else { return }
                self.postResult = response.result
            }
            .store(in: &cancellables)
    }
}
