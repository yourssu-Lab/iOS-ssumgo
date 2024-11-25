//
//  GetQuestionsBySubjectDAO.swift
//  iOS-ssumgo
//
//  Created by 정민지 on 11/25/24.
//

import Combine
import SwiftUI

// MARK: - 과목별 질문 조회 API, 멘티 질문 조회 API

final class GetQuestionsBySubjectDAO {
    func getQuestionsBySubject(
        subjectId: Int,
        page: Int = 1,
        sortBy: String = "latest",
        size: Int = 10,
        query: String? = nil
    ) -> AnyPublisher<PostsResponseDTO, Error> {
        var endpoint = "/posts/subjects/\(subjectId)?page=\(page)&sortBy=\(sortBy)&size=\(size)"
        
        // 아직 검색어 기능 없음
//        if let query = query, !query.isEmpty {
//            endpoint += "&q=\(query)"
//        }
        
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

