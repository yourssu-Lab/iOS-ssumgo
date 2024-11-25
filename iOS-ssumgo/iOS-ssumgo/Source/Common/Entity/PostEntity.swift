//
//  PostEntity.swift
//  iOS-ssumgo
//
//  Created by 정민지 on 11/25/24.
//

struct PostEntity: Decodable {
    let postId: Int
    let subjectId: Int
    let mentee: MenteeEntity
    let title: String
    let content: String
}
