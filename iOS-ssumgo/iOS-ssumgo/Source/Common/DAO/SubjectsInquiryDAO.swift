//
//  SubjectsInquiryDAO.swift
//  iOS-ssumgo
//
//  Created by 서준영 on 11/23/24.
//

import SwiftUI
import Combine

final class SubjectsInquiryDAO {
    func fetchSubjects() -> AnyPublisher<SubjectsInquiryDTO, Error> {
        return BaseAPIClient.shared.performRequest(
            endpoint: "/subjects/students",
            method: .get,
            headers: Config.headerWithAccessToken
        )
        .tryMap { (response: BaseResponse<SubjectsInquiryDTO>) in
            guard let result = response.result else {
                throw URLError(.badServerResponse)
            }
            return result
        }
        .eraseToAnyPublisher()
    }
}
