//
//  CommentsResponseDTO.swift
//  iOS-ssumgo
//
//  Created by 정민지 on 11/25/24.
//

import SwiftUI

struct CommentsResponseDTO: Decodable {
    let totalPages: Int
    let totalCount: Int
    let hasNext: Bool
    let commentsList: [CommentEntity]
}
