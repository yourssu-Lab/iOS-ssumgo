//
//  PostWriteDTO.swift
//  iOS-ssumgo
//
//  Created by 서준영 on 11/24/24.
//

struct PostWriteDTO: Decodable {
    let postId: Int
    let mentee: PostWriteMenteeDTO
    let subjectId: Int
    let title: String
    let content: String
}

struct PostWriteMenteeDTO: Decodable {
    let menteeId: Int
    let menteeName: String
    let menteeDepartment: String
    let menteeStudentIdNumber: Int
}
