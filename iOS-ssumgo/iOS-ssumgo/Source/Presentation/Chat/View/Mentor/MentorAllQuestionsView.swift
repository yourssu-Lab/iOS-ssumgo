//
//  MentorAllQuestionsView.swift
//  iOS-ssumgo
//
//  Created by 정민지 on 11/24/24.
//


import SwiftUI
import YDS_SwiftUI

struct MentorAllQuestionsView: View {
    @StateObject private var viewModel = MentorAllQuestionsViewModel()
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
                                        viewModel.fetchMyQuestions()
                                    },
                                    selectedItem: $selectedSubject
                                )
                                Spacer()
                            }
                            .zIndex(2)
                        }
                        
                        HStack(alignment: .top) {
                            Text("멘티 질문")
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
                    
                    if viewModel.myQuestions.isEmpty {
                        Text("나의 질문이 없습니다.")
                            .frame(maxWidth: .infinity, alignment: .center)
                            .font(.pretendard(.regular, size: 14))
                            .foregroundColor(.sGray2)
                            .padding(.bottom, 10)
                    } else {
                        ForEach(viewModel.myQuestions, id: \.postId) { question in
                            ChatPreview(
                                chatType: .question,
                                question: question.title,
                                nickname: question.mentee.menteeName,
                                department: question.mentee.menteeDepartment,
                                studentIdNumber: "\(question.mentee.menteeStudentIdNumber)"
                            )
                        }
                    }
                }
                .padding(16)
            }
        }
        .onAppear {
            viewModel.fetchMyQuestions()
        }
        .onChange(of: searchText) { newSearchText in
            viewModel.query = newSearchText
        }
    }
}

#Preview {
    MentorAllQuestionsView()
}
