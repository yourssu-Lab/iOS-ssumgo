//
//  Untitled.swift
//  iOS-ssumgo
//
//  Created by 서준영 on 11/16/24.
//

import SwiftUI

struct AnswersView: View {
    
    /// 인기 답변
    @State private var currentIndex = 0
    private let bestQuestionTitle = ["컴퓨터그래픽스개론 기말 어떻게 나오나요ㅠㅠ?", "이 과목에서 배우는 프로그래밍 언어는 무엇인가요?", "이 과목의 주요 평가 방법은 무엇인가요?"]
    private let bestQuestioner = ["글로벌미디어학부 23학번 정**", "글로벌미디어학부 20학번 김**", "글로벌미디어학부 22학번 장**"]
    private let bestAnswer = ["안녕하세요, 컴그개 기말 계산문제보다 코드로 많이 나와용 !!", "이번 학기에서는 주로 Swift를 배웁니다!", "평가는 주로 중간고사, 기말고사, 그리고 실습 과제로 이루어집니다."]
    private let timer = Timer.publish(every: 10, on: .main, in: .common).autoconnect()
    
    /// 최근 답변
    @State var recentQuestionTitle: String = "최근 답변-타이틀"
    @State var recentQuestioner: String = "최근 답변-질문자"
    @State var recentAnswer: String = "최근 답변-답변"
    
    var body: some View {
        Text("인기 답변")
            .font(.pretendard(.bold, size: 16))
            .foregroundStyle(.black)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.leading, 27)
        
        Button(action: {
            print("인기 답변 클릭됨")
        }) {
            TabView(selection: $currentIndex) {
                ForEach(bestQuestionTitle.indices, id: \.self) { index in
                    ZStack {
                        RoundedRectangle(cornerRadius: 10)
                            .frame(width: Constants.rectWidth, height: 92.83)
                            .foregroundStyle(Color("s_gray10p"))
                        
                        VStack(spacing: 0) {
                            Text(bestQuestionTitle[index])
                                .font(.pretendard(.semiBold, size: 14))
                                .foregroundStyle(.black)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(.leading, 10)
                                .padding(.top, 10)
                            
                            Text(bestQuestioner[index])
                                .font(.pretendard(.regular, size: 12))
                                .foregroundStyle(Color("s_gray"))
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(.leading, 10)
                                .padding(.top, 7)
                            
                            Divider()
                                .padding(.horizontal, 10)
                                .padding(.vertical, 10)
                            
                            Text("-> \(bestAnswer[index])")
                                .font(.pretendard(.medium, size: 12))
                                .foregroundStyle(.black)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(.leading, 10)
                            
                            Spacer()
                        }
                        .frame(width: Constants.rectWidth, height: 92.83)
                        .padding(.horizontal, 27)
                    }
                    .padding(.top, 16)
                }
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
            .onReceive(timer) { _ in
                withAnimation {
                    currentIndex = (currentIndex + 1) % bestQuestionTitle.count
                }
            }
        }
        
        Text("최근 답변")
            .font(.pretendard(.bold, size: 16))
            .foregroundStyle(.black)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.leading, 27)
            .padding(.top, 23)
        
        Button(action: {
            print("최근 답변 클릭됨")
        }) {
            ZStack {
                RoundedRectangle(cornerRadius: 10)
                    .frame(width: Constants.rectWidth, height: 92.83)
                    .foregroundStyle(Color("s_gray10p"))
                
                VStack(spacing: 0) {
                    Text("\(recentQuestionTitle)")
                        .font(.pretendard(.semiBold, size: 14))
                        .foregroundStyle(.black)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.leading, 10)
                        .padding(.top, 10)
                    
                    Text("\(recentQuestioner)님")
                        .font(.pretendard(.regular, size: 12))
                        .foregroundStyle(Color("s_gray"))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.leading, 10)
                        .padding(.top, 7)
                    
                    Divider()
                        .padding(.horizontal, 10)
                        .padding(.vertical, 10)
                    
                    Text("-> \(recentAnswer)")
                        .font(.pretendard(.medium, size: 12))
                        .foregroundStyle(.black)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.leading, 10)
                    
                    Spacer()
                }
                .frame(width: Constants.rectWidth, height: 92.83)
                .padding(.horizontal, 27)
            }
        }
        .padding(.top, 16)
    }
}
