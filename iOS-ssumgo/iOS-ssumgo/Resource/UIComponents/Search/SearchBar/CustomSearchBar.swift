//
//  CustomSearchBar.swift
//  iOS-ssumgo
//
//  Created by 정민지 on 11/17/24.
//

import SwiftUI

struct CustomSearchBar: View {
    @Binding var searchText: String
    var onCancel: () -> Void
    var onCommit: () -> Void
    
    var body: some View {
        HStack {
            TextField("검색어를 입력하세요", text: $searchText, onCommit: onCommit)
                .font(.pretendard(.regular, size: 14))
                .padding(.horizontal, 21)
                .padding(.vertical, 15)
                .background(.sGray10P)
                .cornerRadius(30)
            
            Button(action: onCancel) {
                Image(systemName: "xmark.circle.fill")
                    .resizable()
                    .frame(width: 20, height: 20)
                    .foregroundColor(.gray)
            }
        }
        .padding(.horizontal, 24)
        .frame(height: 66)
    }
}

#Preview {
    @Previewable @State var searchText = ""
    
    return CustomSearchBar(
        searchText: $searchText,
        onCancel: {
            searchText = ""
            print("Search canceled")
        },
        onCommit: {
            print("Search committed with text: \(searchText)")
        }
    )
}
