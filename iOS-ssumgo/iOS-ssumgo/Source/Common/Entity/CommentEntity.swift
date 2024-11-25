//
//  CommentEntity.swift
//  iOS-ssumgo
//
//  Created by 정민지 on 11/25/24.
//

struct CommentEntity: Decodable {
    let commentId: Int
    let post: PostEntity
    let mentor: MentorEntity
    let title: String
    let content: String
}
