//
//  DrawersDAO.swift
//  iOS-ssumgo
//
//  Created by 정민지 on 11/25/24.
//

import Combine
import Foundation

// MARK: - 보관함 조회 API

final class DrawersDAO {
    func getDrawers(
        page: Int = 1,
        sortBy: String = "latest",
        size: Int = 10
    ) -> AnyPublisher<CommentsResponseDTO, Error> {
        var endpoint = "/drawers/students?page=\(page)&sortBy=\(sortBy)&size=\(size)"
        
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
