//
//  ViewQuestionsView.swift
//  iOS-ssumgo
//
//  Created by 정민지 on 11/24/24.
//

import SwiftUI
import YDS_SwiftUI

struct ViewQuestionsView: View {
    @EnvironmentObject var navigationManager: NavigationManager
    @StateObject private var viewModel = ViewQuestionsViewModel()
    
    @State private var isSearching: Bool = false
    @State private var selectedSubject: String = ""
    @State private var selectedSubjectId: Int? = nil
    @State private var selectedSortBy: String = "최신순"
    @State private var searchText: String = ""
    
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
                                            selectedSubjectId = SubjectManager.shared.subjectId1
                                        case SubjectManager.shared.subjectName2:
                                            viewModel.subjectId = SubjectManager.shared.subjectId2
                                            selectedSubjectId = SubjectManager.shared.subjectId2
                                        case SubjectManager.shared.subjectName3:
                                            viewModel.subjectId = SubjectManager.shared.subjectId3
                                            selectedSubjectId = SubjectManager.shared.subjectId3
                                        default:
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
                            Text("멘티 질문")
                                .font(.pretendard(.bold, size: 20))
                                .foregroundStyle(.sMain)
                                .padding(.top, 2)
                                .padding(.bottom, 3)
                            
                            Spacer()
                            
                            CustomTextButton(
                                title: "전체보기",
                                action: {
                                    navigationManager.append(.getQuestionsBySubjectView)
                                },
                                underline: true)
                        }
                        if $viewModel.menteeQuestions.isEmpty {
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
                            
                            CustomTextButton(
                                title: "전체보기",
                                action: {
                                    navigationManager.append(
                                        .getMyCommentsView
                                    )
                                },
                                underline: true)
                        }
                        if viewModel.myComments.isEmpty {
                            Text("나의 답변이 없습니다.")
                                .frame(maxWidth: .infinity, alignment: .center)
                                .font(.pretendard(.regular, size: 14))
                                .foregroundColor(.sGray2)
                                .padding(.bottom, 10)
                        } else {
                            ForEach(viewModel.myComments.prefix(2), id: \.commentId) { comment in
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
            
            CustomCircleButton(
                isActive: true,
                iconImage: "ic_send",
                iconSize: 23,
                action: {
                    guard let subjectId = selectedSubjectId else {
                        DispatchQueue.main.async {
                            YDSToast("과목 필터를 선택해주세요.", duration: .short, haptic: .failed)
                        }
                        return
                    }
                    navigationManager.append(.postWriteView(subjectId: subjectId))
                }
            )
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomTrailing)
            .padding([.bottom, .trailing], 20)
        }
        .onAppear {
            viewModel.fetchMenteeQuestions()
            viewModel.fetchMyAnswers()
        }
        .onChange(of: searchText) { newSearchText in
            viewModel.query = newSearchText
        }
        .registerYDSToast()
    }
}

#Preview {
    let previewViewModel = ViewQuestionsViewModel()
    
    ViewQuestionsView()
        .environmentObject(previewViewModel)
}
