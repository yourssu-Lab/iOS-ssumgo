//
//  SubjectPostsDAO.swift
//  iOS-ssumgo
//
//  Created by 정민지 on 11/24/24.
//

import Combine
import SwiftUI

final class SubjectPostsDAO {
    // MARK: - 과목별 질문 조회
    func fetchPosts(
        subjectId: Int,
        page: Int = 1,
        sortBy: String = "latest",
        size: Int = 10
    ) -> AnyPublisher<PostsResponseDTO, Error> {
        let endpoint = "/posts/subjects/\(subjectId)?page=\(page)&sortBy=\(sortBy)&size=\(size)"
        
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
