//
//  ChatPreview.swift
//  iOS-ssumgo
//
//  Created by 정민지 on 11/17/24.
//


import SwiftUI

enum ChatType {
    case answer
    case question
}

struct ChatPreview: View {
    var chatType: ChatType
    var question: String
    var answer: String = ""
    var nickname: String
    var department: String
    var studentIdNumber: String
    var starNum: String = "2"
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(question)
                .font(.pretendard(.semiBold, size: 14))
                .foregroundColor(.black)
                .padding(.bottom, -3)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            Text("\(department) \(studentIdNumber)학번 \(nickname)님")
                .font(.pretendard(.regular, size: 12))
                .foregroundColor(.black)
                .opacity(0.6)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            if chatType == .answer {
                Rectangle()
                    .fill(.sGray3.opacity(0.3))
                    .frame(height: 0.5)
                
                Text("-> \(answer)")
                    .font(.pretendard(.regular, size: 12))
                    .foregroundColor(.black)
                    .padding(.bottom, 7)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                HStack(spacing: 3) {
                    CustomStarButton(size: 10)
                    
                    Text("\(starNum)")
                        .font(.pretendard(.regular, size: 10))
                        .foregroundColor(.sGray3)
                    
                    Spacer()
                }
                .frame(maxWidth: .infinity, alignment: .leading)
            }
        }
        .padding(10)
        .frame(maxWidth: .infinity)
        .background(.sGray3.opacity(0.1))
        .cornerRadius(10)
    }
}

#Preview {
    VStack(spacing: 10) {
        ChatPreview(
            chatType: .answer,
            question: "안녕하세요",
            nickname: "wjdalswl",
            department: "soft",
            studentIdNumber: "1"
        )
        ChatPreview(
            chatType: .question,
            question: "안녕하세요",
            nickname: "wjdalswl",
            department: "soft",
            studentIdNumber: "1"
        )
    }
    .padding(26)
}
