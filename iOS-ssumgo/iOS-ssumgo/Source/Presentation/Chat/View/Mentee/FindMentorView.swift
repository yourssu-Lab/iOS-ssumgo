//
//  FindMentorView.swift
//  iOS-ssumgo
//
//  Created by 정민지 on 11/24/24.
//

import SwiftUI
import YDS_SwiftUI

struct FindMentorView: View {
    @StateObject private var viewModel = FindMentorViewModel()
    @State private var isSearching: Bool = false
    @State private var selectedSubject: String = ""
    @State private var searchText: String = ""
    
    let subjects: [String: Int] = [
        "컴퓨터시스템개론": 1,
        "미디어제작및실습": 2,
        "프로그래밍2및실습": 3
    ]
    
    var body: some View {
        VStack {
            SearchNavigationBar(
                title: "멘토 찾기",
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
                            HStack(alignment: .top) {
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
                                    },
                                    selectedItem: $selectedSubject
                                )
                                Spacer()
                            }
                            .zIndex(1)
                        }
                        
                        HStack {
                            Text("멘토 답변")
                                .font(.pretendard(.bold, size: 18))
                                .padding(.bottom, 3)
                            
                            Spacer()
                            
                            CustomTextButton(title: "전체보기", underline: true)
                        }
                        if viewModel.mentorAnswers.isEmpty {
                            Text("멘토 답변이 없습니다.")
                                .frame(maxWidth: .infinity, alignment: .center)
                                .font(.pretendard(.regular, size: 14))
                                .foregroundColor(.sGray2)
                                .padding(.bottom, 10)
                        } else {
                            ForEach(viewModel.mentorAnswers.prefix(2), id: \.commentId) { comment in
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
                        
                        HStack {
                            Text("나의 질문")
                                .font(.pretendard(.bold, size: 18))
                                .padding(.top, 2)
                                .padding(.bottom, 3)
                            
                            Spacer()
                            
                            CustomTextButton(title: "전체보기", underline: true)
                        }
                        if viewModel.myQuestions.isEmpty {
                            Text("나의 질문이 없습니다.")
                                .frame(maxWidth: .infinity, alignment: .center)
                                .font(.pretendard(.regular, size: 14))
                                .foregroundColor(.sGray2)
                                .padding(.bottom, 10)
                        } else {
                            ForEach(viewModel.myQuestions.prefix(2), id: \.postId) { question in
                                ChatPreview(
                                    chatType: .question,
                                    question: question.title,
                                    nickname: question.mentee.menteeName,
                                    department: question.mentee.menteeDepartment,
                                    studentIdNumber: "\(question.mentee.menteeStudentIdNumber)"
                                )
                            }
                        }
                        
                        Spacer()
                    }
                    .padding(16)
                }
            }
        }
        .onAppear {
            viewModel.fetchMentorAnswers(subjectId: nil, query: "", sortBy: "latest")
            viewModel.fetchMyQuestions( sortBy: "latest")
        }
        .onChange(of: searchText) { newSearchText in
            viewModel.query = newSearchText
        }
    }
}

#Preview {
    FindMentorView()
}

