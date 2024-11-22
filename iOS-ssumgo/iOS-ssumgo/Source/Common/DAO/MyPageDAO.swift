//
//  MyPageDAO.swift
//  iOS-ssumgo
//
//  Created by 정민지 on 11/22/24.
//

import SwiftUI
import Combine

final class MyPageDAO {
    func fetchProfile() -> AnyPublisher<ProfileDTO, Error> {
        return BaseAPIClient.shared.performRequest(
            endpoint: "/students",
            method: .get,
            headers: Config.headerWithAccessToken
        )
        .tryMap { (response: BaseResponse<ProfileDTO>) in
            guard let result = response.result else {
                throw URLError(.badServerResponse)
            }
            return result
        }
        .eraseToAnyPublisher()
    }
}
