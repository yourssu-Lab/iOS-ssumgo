//
//  ViewQuestionsView.swift
//  iOS-ssumgo
//
//  Created by 정민지 on 11/24/24.
//

import SwiftUI
import YDS_SwiftUI

struct ViewQuestionsView: View {
    @StateObject private var viewModel = ViewQuestionsViewModel()
    @State private var isSearching: Bool = false
    @State private var selectedSubject: String = ""
    @State private var selectedSortBy: String = "최신순"
    @State private var searchText: String = ""
    
    let subjects: [String: Int] = [
        "컴퓨터시스템개론": 1,
        "미디어제작및실습": 2,
        "프로그래밍2및실습": 3
    ]
    
    var body: some View {
        VStack {
            SearchNavigationBar(
                title: "질문 보기",
                searchText: $searchText,
                onSearchIconTap: {
                    withAnimation {
                        isSearching = true
                    }
                },
                onCancelSearch: {
                    withAnimation {
                        isSearching = false
                        searchText = ""
                        viewModel.query = ""
                    }
                }
            )
            
            if viewModel.isLoading {
                ProgressView()
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
            } else {
                ScrollView {
                    VStack(alignment: .leading, spacing: 20) {
                        if !isSearching {
                            HStack {
                                CustomAccordionButton(
                                    title: "과목",
                                    hasBorder: true,
                                    selectedBackgroundColor: .clear,
                                    textColor: .sGray2,
                                    items: Array(subjects.keys),
                                    dropdownWidth: 95.06,
                                    action: { selected in
                                        if let subjectId = subjects[selected] {
                                            viewModel.subjectId = subjectId
                                        } else {
                                            viewModel.subjectId = nil
                                        }
                                        viewModel.fetchMenteeQuestions()
                                    },
                                    selectedItem: $selectedSubject
                                )
                                Spacer()
                            }
                            .zIndex(1)
                        }
                        
                        HStack {
                            Text("멘티 질문")
                                .font(.pretendard(.bold, size: 20))
                                .foregroundStyle(.sMain)
                                .padding(.top, 2)
                                .padding(.bottom, 3)
                            
                            Spacer()
                            
                            CustomTextButton(title: "전체보기", underline: true)
                        }
                        if viewModel.menteeQuestions.isEmpty {
                            Text("멘티 질문이 없습니다.")
                                .frame(maxWidth: .infinity, alignment: .center)
                                .font(.pretendard(.regular, size: 14))
                                .foregroundColor(.sGray2)
                                .padding(.bottom, 10)
                        } else {
                            ForEach(viewModel.menteeQuestions.prefix(2), id: \.postId) { question in
                                ChatPreview(
                                    chatType: .question,
                                    question: question.title,
                                    nickname: question.mentee.menteeName,
                                    department: question.mentee.menteeDepartment,
                                    studentIdNumber: "\(question.mentee.menteeStudentIdNumber)"
                                )
                            }
                        }
                        
                        HStack {
                            Text("나의 답변")
                                .font(.pretendard(.bold, size: 20))
                                .foregroundStyle(.sMain)
                                .padding(.top, 2)
                                .padding(.bottom, 3)
                            
                            Spacer()
                            
                            CustomTextButton(title: "전체보기", underline: true)
                        }
                        if viewModel.myAnswers.isEmpty {
                            Text("나의 답변이 없습니다.")
                                .frame(maxWidth: .infinity, alignment: .center)
                                .font(.pretendard(.regular, size: 14))
                                .foregroundColor(.sGray2)
                                .padding(.bottom, 10)
                        } else {
                            ForEach(viewModel.myAnswers.prefix(2), id: \.commentId) { comment in
                                ChatPreview(
                                    chatType: .answer,
                                    question: comment.post.title,
                                    answer: comment.content,
                                    nickname: comment.mentor.mentorName,
                                    department: comment.mentor.mentorDepartment,
                                    studentIdNumber: "\(comment.mentor.mentorStudentIdNumber)"
                                )
                            }
                        }
                    }
                    .padding(16)
                }
            }
        }
        .onAppear {
            viewModel.fetchMenteeQuestions()
            viewModel.fetchMyAnswers()
        }
        .onChange(of: searchText) { newSearchText in
            viewModel.query = newSearchText
        }
    }
}

#Preview {
    let previewViewModel = ViewQuestionsViewModel()
    
    ViewQuestionsView()
        .environmentObject(previewViewModel)
}
