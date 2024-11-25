//
//  GetMyQuestionsView.swift
//  iOS-ssumgo
//
//  Created by 정민지 on 11/24/24.
//

import SwiftUI
import YDS_SwiftUI

struct GetMyQuestionsView: View {
    @EnvironmentObject var navigationManager: NavigationManager
    @StateObject private var viewModel = GetMyQuestionsViewModel()
    
    @State private var isSearching: Bool = false
    @State private var selectedSubject: String = ""
    @State private var selectedSortBy: String = ""
    @State private var searchText: String = ""
    
    let sortBys: [String] = [
        "최신순",
        "생성순"
    ]
    
    var body: some View {
        VStack {
            SearchNavigationBar(
                title: "멘토 찾기",
                back: true,
                searchText: $searchText,
                onBackTap: {
                    navigationManager.pop()
                },
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
                            Text("나의 질문")
                                .font(.pretendard(.bold, size: 18))
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
        .navigationBarHidden(true)
    }
}

#Preview {
    GetMyQuestionsView()
}

