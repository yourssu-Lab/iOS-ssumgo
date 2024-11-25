//
//  PopularCommentEntity.swift
//  iOS-ssumgo
//
//  Created by 서준영 on 11/23/24.
//

struct PopularCommentEntity: Decodable, Identifiable {
    let commentId: Int
    let post: PostProfile
    let mentor: MentorProfile
    let title: String
    let content: String
    
    var id: Int { commentId }
}

struct PostProfile: Decodable {
    let postId: Int
    let subjectId: Int
    let mentee: MenteeProfile
    let title: String
    let content: String
}

struct MenteeProfile: Decodable {
    let menteeId: Int
    let menteeName: String
    let menteeDepartment: String
    let menteeStudentIdNumber: Int
}

struct MentorProfile: Decodable {
    let mentorId: Int
    let mentorName: String
    let mentorDepartment: String
    let mentorStudentIdNumber: Int
}
