//
//  PopularCommentDAO.swift
//  iOS-ssumgo
//
//  Created by 서준영 on 11/24/24.
//

import SwiftUI
import Combine

final class PopularCommentDAO {
    func fetchPopularComments() -> AnyPublisher<[PopularCommentEntity], Error> {
        return BaseAPIClient.shared.performRequest(
            endpoint: "/posts/comments/popular",
            method: .get,
            headers: Config.headerWithAccessToken
        )
        .tryMap { (response: BaseResponse<[PopularCommentEntity]>) in
            guard let result = response.result else {
                throw URLError(.badServerResponse)
            }
            return result
        }
        .eraseToAnyPublisher()
    }
}
