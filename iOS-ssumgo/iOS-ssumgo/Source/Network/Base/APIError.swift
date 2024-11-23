//
//  APIError.swift
//  iOS-ssumgo
//
//  Created by 정민지 on 11/22/24.
//

import SwiftUI

// MARK: - APIError

struct APIError: LocalizedError {
    let statusCode: Int
    let data: Data

    var errorDescription: String? {
        let errorResponse = try? JSONDecoder().decode(ErrorResponse.self, from: data)
        return errorResponse?.message ?? "알 수 없는 에러가 발생했습니다."
    }

    static let unauthorized = APIError(statusCode: 401, data: Data())
}

struct ErrorResponse: Decodable {
    let error: String
    let message: String
}
