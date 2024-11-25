//
//  RecentSearchView.swift
//  iOS-ssumgo
//
//  Created by 정민지 on 11/17/24.
//

import SwiftUI

struct RecentSearchView: View {
    @ObservedObject var recentSearchManager: RecentSearchManager
    var onSelectSearch: ((String) -> Void)? = nil
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            HStack {
                Text("최근 검색어")
                    .font(.pretendard(.bold, size: 14))
                    .foregroundColor(.sGray)
                    .padding(.horizontal, 24)
                
                Spacer()
                
                CustomTextButton(
                    title: "전체삭제",
                    action: recentSearchManager.clearSearches,
                    underline: true
                )
                .padding(.trailing, 14)
            }
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 3) {
                    ForEach(recentSearchManager.recentSearches, id: \.self) { search in
                        Button(action: {
                            onSelectSearch?(search)
                        }) {
                            RecentSearchTag(
                                text: search,
                                onRemove: {
                                    withAnimation {
                                        recentSearchManager.removeSearchTerm(search)
                                    }
                                }
                            )
                        }
                    }
                    .padding(.horizontal, 24)
                }
            }
            .padding(.bottom, 12)
        }
    }
}

#Preview {
    let previewManager = RecentSearchManager.shared
    previewManager.recentSearches = ["글로벌미디어학부", "미디어제작및실습", "컴퓨터시스템개론"]
    
    return RecentSearchView(recentSearchManager: previewManager)
}
