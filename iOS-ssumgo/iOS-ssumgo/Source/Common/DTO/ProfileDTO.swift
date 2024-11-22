//
//  ProfileDTO.swift
//  iOS-ssumgo
//
//  Created by 정민지 on 11/22/24.
//

struct ProfileDTO: Decodable {
    let studentId: Int
    let yourssuId: String
    let nickname: String
    let department: String
    let studentIdNumber: Int
    let profileImageUrls: ProfileImageUrlsDTO
    let rating: Double?
}

struct ProfileImageUrlsDTO: Decodable {
    let smallUrl: String
    let midUrl: String
    let largeUrl: String
}
