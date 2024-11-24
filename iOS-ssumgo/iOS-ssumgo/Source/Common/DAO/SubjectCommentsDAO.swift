//
//  SubjectCommentsDAO.swift
//  iOS-ssumgo
//
//  Created by 정민지 on 11/24/24.
//

import SwiftUI
import Combine

final class SubjectCommentsDAO {
    func fetchComments(
        subjectId: Int,
        page: Int = 1,
        sortBy: String = "latest",
        size: Int = 10,
        query: String? = nil
    ) -> AnyPublisher<CommentsResponseDTO, Error> {
        var endpoint = "/posts/subjects/\(subjectId)/comments?page=\(page)&sortBy=\(sortBy)&size=\(size)"
        
        if let query = query, !query.isEmpty {
            endpoint += "&q=\(query)"
        }
        
        return BaseAPIClient.shared.performRequest(
            endpoint: endpoint,
            method: .get,
            headers: Config.headerWithAccessToken
        )
        .tryMap { (response: BaseResponse<CommentsResponseDTO>) in
            guard let result = response.result else {
                throw URLError(.badServerResponse)
            }
            return result
        }
        .eraseToAnyPublisher()
    }
}
