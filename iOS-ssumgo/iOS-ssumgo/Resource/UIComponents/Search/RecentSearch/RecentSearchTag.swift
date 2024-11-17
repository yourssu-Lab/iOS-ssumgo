//
//  RecentSearchTag.swift
//  iOS-ssumgo
//
//  Created by 정민지 on 11/17/24.
//

import SwiftUI

struct RecentSearchTag: View {
    let text: String
    var onRemove: () -> Void
    
    var body: some View {
        HStack(spacing: 3) {
            Text(text)
                .font(.pretendard(.regular, size: 14))
                .foregroundColor(.sGray3)
            
            Button(action: onRemove) {
                Image("ic_x")
                    .resizable()
                    .frame(width: 12, height: 12)
            }
        }
        .padding(.horizontal, 8)
        .padding(.vertical, 4)
        .overlay(
            RoundedRectangle(cornerRadius: 20)
                .stroke(.sGray2, lineWidth: 1)
        )
        .clipShape(RoundedRectangle(cornerRadius: 20))
    }
}
