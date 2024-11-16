//
//  Untitled.swift
//  iOS-ssumgo
//
//  Created by 서준영 on 11/16/24.
//

import SwiftUI

struct AnswersView: View {
    
    /// 인기 답변
    @State var bestQuestionTitle: String = "컴퓨터그래픽스개론 기말 어떻게 나오나요ㅠㅠ?"
    @State var bestQuestioner: String = "글로벌미디어학부 23학번 정**운"
    @State var bestAnswer: String = "안녕하세요, 컴그개 기말 계산문제보다 코드로 많이 나와용 !!"
    
    /// 최근 답변
    @State var recentQuestionTitle: String = "최근 답변-타이틀"
    @State var recentQuestioner: String = "최근 답변-질문자"
    @State var recentAnswer: String = "최근 답변-답변"
    
    private let rectWidth: CGFloat = 339
    
    var body: some View {
        Text("인기 답변")
            .font(.system(size: 16))
            .bold()
            .foregroundStyle(.black)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.leading, 27)
        
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .frame(width: rectWidth, height: 92.83)
                .foregroundStyle(Color("s_gray10p"))
            
            VStack(spacing: 0) {
                Text("\(bestQuestionTitle)")
                    .font(.system(size: 14))
                    .bold()
                    .foregroundStyle(.black)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.leading, 10)
                    .padding(.top, 10)
                
                Text("\(bestQuestioner)님")
                    .font(.system(size: 12))
                    .foregroundStyle(Color("s_gray"))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.leading, 10)
                    .padding(.top, 7)
                
                Divider()
                    .padding(.horizontal, 10)
                    .padding(.vertical, 10)
                
                Text("→ \(bestAnswer)")
                    .font(.system(size: 12))
                    .foregroundStyle(.black)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.leading, 10)
                
                Spacer()
            }
            .frame(width: rectWidth, height: 92.83)
            .padding(.horizontal, 27)
        }
        .padding(.top, 16)
        
        Text("최근 답변")
            .font(.system(size: 16))
            .bold()
            .foregroundStyle(.black)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.leading, 27)
            .padding(.top, 23)
        
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .frame(width: rectWidth, height: 92.83)
                .foregroundStyle(Color("s_gray10p"))
            
            VStack(spacing: 0) {
                Text("\(recentQuestionTitle)")
                    .font(.system(size: 14))
                    .bold()
                    .foregroundStyle(.black)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.leading, 10)
                    .padding(.top, 10)
                
                Text("\(recentQuestioner)님")
                    .font(.system(size: 12))
                    .foregroundStyle(Color("s_gray"))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.leading, 10)
                    .padding(.top, 7)
                
                Divider()
                    .padding(.horizontal, 10)
                    .padding(.vertical, 10)
                
                Text("→ \(recentAnswer)")
                    .font(.system(size: 12))
                    .foregroundStyle(.black)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.leading, 10)
                
                Spacer()
            }
            .frame(width: rectWidth, height: 92.83)
            .padding(.horizontal, 27)
        }
        .padding(.top, 16)
    }
}
