//
//  SubjectsRegistrationDAO.swift
//  iOS-ssumgo
//
//  Created by 정민지 on 11/25/24.
//

import SwiftUI
import Combine

// MARK:  수강 과목 등록 API

final class SubjectsRegistrationDAO {
    func registerSubject(subject: SubjectsRegistrationDTO) -> AnyPublisher<[SubjectEntity], Error> {
        let endpoint = "/subjects/students"
        let headers: [String: String] = Config.headerWithAccessToken
        let body: [String: Any] = [
            "subjectId": subject.subjectId,
            "years": subject.years,
            "semester": subject.semester
        ]
        
        guard let jsonData = try? JSONSerialization.data(withJSONObject: body, options: []) else {
            return Fail(error: URLError(.badURL)).eraseToAnyPublisher()
        }
        
        return BaseAPIClient.shared.performRequest(
            endpoint: endpoint,
            method: .post,
            headers: headers,
            body: jsonData
        )
        .tryMap { (response: BaseResponse<[SubjectEntity]>) in
            guard let result = response.result else {
                throw URLError(.badServerResponse)
            }
            return result
        }
        .eraseToAnyPublisher()
    }
}
