//
//  LoginDTO.swift
//  iOS-ssumgo
//
//  Created by 정민지 on 11/22/24.
//

struct LoginDTO: Decodable {
    let studentId: Int
    let accessToken: String
    let refreshToken: String
}


