//
//  SubjectsInquiryDAO.swift
//  iOS-ssumgo
//
//  Created by 서준영 on 11/23/24.
//

import SwiftUI
import Combine

final class SubjectsInquiryDAO {
    func fetchSubjects() -> AnyPublisher<[SubjectInquiryDTO], Error> {
        return BaseAPIClient.shared.performRequest(
            endpoint: "/subjects/students",
            method: .get,
            headers: Config.headerWithAccessToken
        )
        .tryMap { (response: BaseResponse<[SubjectInquiryDTO]>) in
            guard let result = response.result else {
                throw URLError(.badServerResponse)
            }
            return result // [SubjectDTO]를 직접 반환
        }
        .eraseToAnyPublisher()
    }
}
