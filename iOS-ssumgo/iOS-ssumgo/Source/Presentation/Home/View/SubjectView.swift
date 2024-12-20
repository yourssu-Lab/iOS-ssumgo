//
//  SubjectView.swift
//  iOS-ssumgo
//
//  Created by 서준영 on 11/16/24.
//

import SwiftUI

struct SubjectView: View {
    
    var iconName: String
    var subjectName: String
    var subjectId: Int
    
    @State private var showPostWriteView = false
    
    var body: some View {
        Button(action: {
            print("과목ID: \(subjectId)")
            showPostWriteView = true
        }) {
            VStack(spacing: 0) {
                ZStack {
                    RoundedRectangle(cornerRadius: 15)
                        .frame(width: 63, height: 50)
                        .foregroundStyle(Color("s_gray10p"))
                    
                    Image(iconName)
                }
                Text("\(subjectName)")
                    .font(.pretendard(.semiBold, size: 12))
                    .foregroundStyle(.black)
                    .multilineTextAlignment(.center)
                    .lineLimit(2)
                    .padding(.top, 8)
            }
            .padding(.horizontal, 15)
        }
    }
}
