//
//  MentorAllMyCommentView.swift
//  iOS-ssumgo
//
//  Created by 정민지 on 11/24/24.
//

import SwiftUI

struct MentorAllMyCommentView: View {
    @StateObject private var viewModel = MentorAllMyCommentViewModel()
    @State private var isSearching: Bool = false
    @State private var selectedSubject: String = ""
    @State private var selectedSortBy: String = "최신순"
    @State private var searchText: String = ""
    
    let subjects: [String: Int] = [
        "컴퓨터시스템개론": 1,
        "미디어제작및실습": 2,
        "프로그래밍2및실습": 3
    ]
    
    let sortBys: [String] = [
        "최신순",
        "생성순"
    ]
    
    var body: some View {
        VStack {
            SearchNavigationBar(
                title: "질문 보기",
                back: true,
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
                        VStack {
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
                                            viewModel.fetchMentorAnswers()
                                        },
                                        selectedItem: $selectedSubject
                                    )
                                    Spacer()
                                }
                                .zIndex(2)
                            }
                            
                            HStack(alignment: .top) {
                                Text("나의 답변")
                                    .font(.pretendard(.bold, size: 20))
                                    .foregroundStyle(.sMain)
                                    .padding(.top, 2)
                                    .padding(.bottom, 3)
                                
                                Spacer()
                                
                                CustomAccordionButton(
                                    title: "정렬",
                                    selectedBackgroundColor: .clear,
                                    textColor: .sGray,
                                    items: sortBys,
                                    dropdownWidth: 46,
                                    action: { selected in
                                        viewModel.updateSortBy(selectedSortBy: selected)
                                    },
                                    selectedItem: $selectedSortBy
                                )
                                .frame(width: 92)
                                .padding(.bottom, 1)
                                .offset(x: 30)
                            }
                            .zIndex(1)
                        }
                        
                        if viewModel.mentorAnswers.isEmpty {
                            Text("멘토 답변이 없습니다.")
                                .frame(maxWidth: .infinity, alignment: .center)
                                .font(.pretendard(.regular, size: 14))
                                .foregroundColor(.sGray2)
                                .padding(.bottom, 10)
                        } else {
                            ForEach(viewModel.mentorAnswers, id: \.commentId) { comment in
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
            viewModel.fetchMentorAnswers()
        }
        .onChange(of: searchText) { newSearchText in
            viewModel.query = newSearchText
        }
    }
}

#Preview {
    MentorAllMyCommentView()
}


#Preview {
    MentorAllMyCommentView()
}
