//
//  GetMyCommentsDAO.swift
//  iOS-ssumgo
//
//  Created by 정민지 on 11/25/24.
//

import SwiftUI
import Combine

final class GetMyCommentsDAO {
    
    // MARK: - 나의 답변 조회 API
    
    func getMyComments(
        page: Int = 1,
        sortBy: String = "latest",
        size: Int = 10
    ) -> AnyPublisher<CommentsResponseDTO, Error> {
        let endpoint = "/students/comments?page=\(page)&sortBy=\(sortBy)&size=\(size)"
        
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
    
    // MARK: - 나의 답변 조회 API
    
    func fetchMyComments(
        page: Int = 1,
        sortBy: String = "latest",
        size: Int = 10
    ) -> AnyPublisher<CommentsResponseDTO, Error> {
        let endpoint = "/students/comments?page=\(page)&sortBy=\(sortBy)&size=\(size)"
        
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

GetMyCommentsDAO
getMyComments
