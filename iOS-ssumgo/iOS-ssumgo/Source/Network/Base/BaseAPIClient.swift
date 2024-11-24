//
//  BaseAPIClient.swift
//  iOS-ssumgo
//
//  Created by 정민지 on 11/22/24.
//

import SwiftUI
import Combine

final class BaseAPIClient {
    static let shared = BaseAPIClient()
    private init() {}
    
    private let refreshTokenEndpoint = "/auth/refresh"
    
    func performRequest<T: Decodable>(
        endpoint: String,
        method: HTTPMethod = .get,
        headers: [String: String] = [:],
        body: Data? = nil,
        decoder: JSONDecoder = JSONDecoder()
    ) -> AnyPublisher<BaseResponse<T>, Error> {
        guard let url = URL(string: "\(Config.baseURL)\(endpoint)") else {
            return Fail(error: URLError(.badURL))
                .eraseToAnyPublisher()
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        headers.forEach { key, value in
            request.setValue(value, forHTTPHeaderField: key)
        }
        request.httpBody = body
        
        logRequest(request: request)
        
        return URLSession.shared.dataTaskPublisher(for: request)
            .tryMap { output in
                self.logResponse(output: output, for: request)
                
                guard let httpResponse = output.response as? HTTPURLResponse else {
                    throw URLError(.badServerResponse)
                }
                
                if httpResponse.statusCode == 401 {
                    print("401에러")
                    throw APIError.unauthorized
                }
                
                if !(200...299).contains(httpResponse.statusCode) {
                    throw APIError(statusCode: httpResponse.statusCode, data: output.data)
                }
                
                return output.data
            }
            .decode(type: BaseResponse<T>.self, decoder: decoder)
            .catch { error -> AnyPublisher<BaseResponse<T>, Error> in
                if let apiError = error as? APIError, apiError == .unauthorized {
                    return self.refreshToken()
                        .flatMap { _ -> AnyPublisher<BaseResponse<T>, Error> in
                            var retryHeaders = headers
                            if let newAccessToken = Config.accessToken {
                                retryHeaders["Authorization"] = "Bearer \(newAccessToken)"
                            }
                            return self.performRequest(
                                endpoint: endpoint,
                                method: method,
                                headers: retryHeaders,
                                body: body,
                                decoder: decoder
                            )
                            
                        }
                        .eraseToAnyPublisher()
                }
                return Fail(error: error).eraseToAnyPublisher()
            }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}

// MARK: - Refresh Token

extension BaseAPIClient {
    private func refreshToken() -> AnyPublisher<Void, Error> {
        guard let refreshToken = Config.refreshToken else {
            return Fail(error: URLError(.userAuthenticationRequired))
                .eraseToAnyPublisher()
        }
        
        let body: [String: String] = ["refreshToken": refreshToken]
        
        guard let jsonData = try? JSONSerialization.data(withJSONObject: body) else {
            return Fail(error: URLError(.badURL))
                .eraseToAnyPublisher()
        }
        
        return performRequest(
            endpoint: refreshTokenEndpoint,
            method: .post,
            headers: ["Content-Type": "application/json"],
            body: jsonData
        )
        .tryMap { (response: BaseResponse<LoginDTO>) in
            guard let result = response.result else {
                throw URLError(.userAuthenticationRequired)
            }
            Config.accessToken = result.accessToken
            Config.refreshToken = result.refreshToken
        }
        .eraseToAnyPublisher()
    }
}

// MARK: - Logging

extension BaseAPIClient {
    private func logRequest(request: URLRequest) {
        print("➡️ [REQUEST] \(request.httpMethod ?? "") \(request.url?.absoluteString ?? "")")
        if let headers = request.allHTTPHeaderFields {
            print("Headers: \(headers)")
        }
        if let body = request.httpBody {
            print("Body: \(String(data: body, encoding: .utf8) ?? "")")
        }
    }

    private func logResponse(output: URLSession.DataTaskPublisher.Output, for request: URLRequest) {
        if let httpResponse = output.response as? HTTPURLResponse {
            print("⬅️ [RESPONSE] \(request.url?.absoluteString ?? "")")
            print("Status Code: \(httpResponse.statusCode)")
            print("Body: \(String(data: output.data, encoding: .utf8) ?? "")")
        }
    }
}
