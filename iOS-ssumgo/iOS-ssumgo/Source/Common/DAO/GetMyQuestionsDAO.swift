//
//  GetMyQuestionsDAO.swift
//  iOS-ssumgo
//
//  Created by 정민지 on 11/24/24.
//

import SwiftUI
import Combine

// MARK: - 나의 질문 조회 API

final class GetMyQuestionsDAO {
    func fetchMenteePosts(
        page: Int = 1,
        sortBy: String = "latest",
        size: Int = 10
    ) -> AnyPublisher<PostsResponseDTO, Error> {
        let endpoint = "/students/posts?page=\(page)&sortBy=\(sortBy)&size=\(size)"
        
        return BaseAPIClient.shared.performRequest(
            endpoint: endpoint,
            method: .get,
            headers: Config.headerWithAccessToken
        )
        .tryMap { (response: BaseResponse<PostsResponseDTO>) in
            guard let result = response.result else {
                throw URLError(.badServerResponse)
            }
            return result
        }
        .eraseToAnyPublisher()
    }
}


final class GetMyQuestionsDAO {
    func getMyQuestions(
        page: Int = 1,
        sortBy: String = "latest",
        size: Int = 10
    ) -> AnyPublisher<PostsResponseDTO, Error> {
        let endpoint = "/students/posts?page=\(page)&sortBy=\(sortBy)&size=\(size)"
        
        return BaseAPIClient.shared.performRequest(
            endpoint: endpoint,
            method: .get,
            headers: Config.headerWithAccessToken
        )
        .tryMap { (response: BaseResponse<PostsResponseDTO>) in
            guard let result = response.result else {
                throw URLError(.badServerResponse)
            }
            return result
        }
        .eraseToAnyPublisher()
    }
}
