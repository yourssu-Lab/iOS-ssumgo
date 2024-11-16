//
//  SubjectView.swift
//  iOS-ssumgo
//
//  Created by 서준영 on 11/16/24.
//

import SwiftUI

struct SubjectView: View {
    @State var iconName: String
    @State var subjectName: String
    
    var body: some View {
        VStack(spacing: 0) {
            ZStack {
                RoundedRectangle(cornerRadius: 15)
                    .frame(width: 63, height: 50)
                    .foregroundStyle(Color("s_gray10p"))
                
                Image(iconName)
            }
            Text("\(subjectName)")
                .font(.system(size: 12))
                .multilineTextAlignment(.center)
                .lineLimit(2)
                .padding(.top, 8)
        }
        .padding(.horizontal, 25)
    }
}
