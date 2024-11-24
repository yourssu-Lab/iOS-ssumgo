//
//  PostWriteDAO.swift
//  iOS-ssumgo
//
//  Created by 서준영 on 11/24/24.
//

import SwiftUI
import Combine

final class PostWriteDAO {
    func performPost(subjectId: Int, title: String, content: String) -> AnyPublisher<BaseResponse<PostWriteDTO>, Error> {
        let body: [String: Any] = [
            "subjectId": subjectId,
            "title": title,
            "content": content
        ]
        
        guard let jsonData = try? JSONSerialization.data(withJSONObject: body) else {
            return Fail(error: URLError(.badURL))
                .eraseToAnyPublisher()
        }
        
        return BaseAPIClient.shared.performRequest(
            endpoint: "/posts",
            method: .post,
            headers: Config.headerWithAccessToken,
            body: jsonData
        )
    }
}
