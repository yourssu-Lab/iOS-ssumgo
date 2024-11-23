//
//  ExternalAPIClient.swift
//  iOS-ssumgo
//
//  Created by 정민지 on 11/22/24.
//

import SwiftUI
import Combine

final class ExternalAPIClient {
    static let shared = ExternalAPIClient()
    private init() {}

    func soomsilTestSeverRequest(
        endpoint: String,
        method: HTTPMethod = .get,
        headers: [String: String] = [:],
        body: Data? = nil
    ) -> AnyPublisher<Data, Error> {
        guard let url = URL(string: "\(Config.signupAuthURL)\(endpoint)") else {
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

                if !(200...299).contains(httpResponse.statusCode) {
                    throw APIError(statusCode: httpResponse.statusCode, data: output.data)
                }

                return output.data
            }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}

// MARK: - Logging

extension ExternalAPIClient {
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

