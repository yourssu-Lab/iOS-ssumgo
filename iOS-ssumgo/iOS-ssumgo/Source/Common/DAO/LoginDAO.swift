//
//  LoginDAO.swift
//  iOS-ssumgo
//
//  Created by 정민지 on 11/22/24.
//

import SwiftUI
import Combine

final class LoginDAO {
    func performLogin(email: String, password: String) -> AnyPublisher<BaseResponse<LoginDTO>, Error> {
        let body: [String: String] = [
            "email": email,
            "password": password
        ]
        
        guard let jsonData = try? JSONSerialization.data(withJSONObject: body) else {
            return Fail(error: URLError(.badURL))
                .eraseToAnyPublisher()
        }
        
        return BaseAPIClient.shared.performRequest(
            endpoint: "/auth/login",
            method: .post,
            headers: ["Content-Type": "application/json"],
            body: jsonData
        )
    }
}
