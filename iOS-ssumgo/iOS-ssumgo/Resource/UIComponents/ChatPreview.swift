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
    @State var chatType: ChatType
    @State var question: String = "컴퓨터시스템개론 기말 어떻게 준비해야하나요?"
    @State var answer: String = "컴시개는 족보가 중요해요~~~"
    @State var nickname: String = "정**"
    @State var department: String = "글로벌미디어학부"
    @State var studentIdNumber: String = "23"
    @State var starNum: String = "2"
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("\(question)")
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
        ChatPreview(chatType: .answer)
        ChatPreview(chatType: .question)
    }
    .padding(26)
}
