//
//  PostsResponseDTO.swift
//  iOS-ssumgo
//
//  Created by 정민지 on 11/24/24.
//

struct PostsResponseDTO: Decodable {
    let totalPages: Int
    let totalCount: Int
    let hasNext: Bool
    let postsList: [MenteePostDTO]
}


struct MenteePostDTO: Decodable {
    let postId: Int
    let mentee: Mentee
    let subjectId: Int
    let title: String
    let content: String
}

struct Mentee: Decodable {
    let menteeId: Int
    let menteeName: String
    let menteeDepartment: String
    let menteeStudentIdNumber: Int
}
