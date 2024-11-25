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
    let postsList: [PostEntity]
}
