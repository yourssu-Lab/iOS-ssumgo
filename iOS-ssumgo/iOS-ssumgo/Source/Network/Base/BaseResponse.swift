//
//  BaseResponse.swift
//  iOS-ssumgo
//
//  Created by 정민지 on 11/22/24.
//

import SwiftUI

// MARK: - BaseResponse

struct BaseResponse<T: Decodable>: Decodable {
    let timestamp: String
    let status: Int?
    let message: String?
    let result: T?
}

// MARK: - EmptyResult

struct EmptyResult: Decodable {}
