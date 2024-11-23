//
//  Untitled.swift
//  iOS-ssumgo
//
//  Created by 서준영 on 11/16/24.
//

import SwiftUI
import Combine

struct AnswersView: View {
    
    /// 인기 답변
    @StateObject private var viewModel = AnswersViewModel()
    @State private var currentIndex = 0

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
            if viewModel.isLoading {
                ProgressView("Loading...")
            } else if let errorMessage = viewModel.errorMessage {
                Text("Error: \(errorMessage)")
            } else if viewModel.comments.isEmpty {
                Text("No comments available")
            } else {
                TabView(selection: $currentIndex) {
                    ForEach(viewModel.comments.indices, id: \.self) { index in
                        ZStack {
                            RoundedRectangle(cornerRadius: 10)
                                .frame(width: Constants.rectWidth, height: 92.83)
                                .foregroundStyle(Color("s_gray10p"))
                            
                            VStack(spacing: 0) {
                                Text(viewModel.comments[index].post.title)
                                    .font(.pretendard(.semiBold, size: 14))
                                    .foregroundStyle(.black)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .padding(.leading, 10)
                                    .padding(.top, 10)
                                
                                Text(viewModel.comments[index].mentor.mentorName)
                                    .font(.pretendard(.regular, size: 12))
                                    .foregroundStyle(Color("s_gray"))
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .padding(.leading, 10)
                                    .padding(.top, 7)
                                
                                Divider()
                                    .padding(.horizontal, 10)
                                    .padding(.vertical, 10)
                                
                                Text("-> \(viewModel.comments[index].title)")
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
                .onAppear {
                    currentIndex = 0
                }
                .onReceive(timer) { _ in
                    withAnimation {
                        currentIndex = (currentIndex + 1) % viewModel.comments.count
                    }
                }
            }
        }
        .onAppear {
            viewModel.fetchCommentData()
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

#Preview {
    AnswersView()
}
