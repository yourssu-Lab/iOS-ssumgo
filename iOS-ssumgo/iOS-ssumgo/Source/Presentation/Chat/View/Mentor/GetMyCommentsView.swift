//
//  GetMyCommentsView.swift
//  iOS-ssumgo
//
//  Created by 정민지 on 11/24/24.
//

import SwiftUI

struct GetMyCommentsView: View {
    @StateObject private var viewModel = GetMyCommentsViewModel()
    
    @State private var isSearching: Bool = false
    @State private var selectedSubject: String = ""
    @State private var selectedSortBy: String = "최신순"
    @State private var searchText: String = ""
    
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
                                        items: [
                                            SubjectManager.shared.subjectName1,
                                            SubjectManager.shared.subjectName2,
                                            SubjectManager.shared.subjectName3
                                        ],
                                        dropdownWidth: 95.06,
                                        action: { selected in
                                            selectedSubject = selected
                                            switch selected {
                                            case SubjectManager.shared.subjectName1:
                                                viewModel.subjectId = SubjectManager.shared.subjectId1
                                            case SubjectManager.shared.subjectName2:
                                                viewModel.subjectId = SubjectManager.shared.subjectId2
                                            case SubjectManager.shared.subjectName3:
                                                viewModel.subjectId = SubjectManager.shared.subjectId3
                                            default:
                                                viewModel.subjectId = nil
                                            }
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
                        
                        if viewModel.myComments.isEmpty {
                            Text("멘토 답변이 없습니다.")
                                .frame(maxWidth: .infinity, alignment: .center)
                                .font(.pretendard(.regular, size: 14))
                                .foregroundColor(.sGray2)
                                .padding(.bottom, 10)
                        } else {
                            ForEach(viewModel.myComments, id: \.commentId) { comment in
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
            viewModel.getMentorComments()
        }
        .onChange(of: searchText) { newSearchText in
            viewModel.query = newSearchText
        }
    }
}

#Preview {
    GetMyCommentsView()
}
