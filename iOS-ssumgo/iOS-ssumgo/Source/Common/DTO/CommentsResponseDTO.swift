//
//  CommentsResponseDTO.swift
//  iOS-ssumgo
//
//  Created by 정민지 on 11/24/24.
//

import SwiftUI

struct CommentsResponseDTO: Decodable {
    let totalPages: Int
    let totalCount: Int
    let hasNext: Bool
    let commentsList: [CommentDTO]
}

struct CommentDTO: Decodable {
    let commentId: Int
    let post: PostDTO
    let mentor: MentorDTO
    let title: String
    let content: String
}

struct PostDTO: Decodable {
    let postId: Int
    let subjectId: Int
    let mentee: MenteeDTO
    let title: String
    let content: String
}

struct MenteeDTO: Decodable {
    let menteeId: Int
    let menteeName: String
    let menteeDepartment: String
    let menteeStudentIdNumber: Int
}

struct MentorDTO: Decodable {
    let mentorId: Int
    let mentorName: String
    let mentorDepartment: String
    let mentorStudentIdNumber: Int
}
