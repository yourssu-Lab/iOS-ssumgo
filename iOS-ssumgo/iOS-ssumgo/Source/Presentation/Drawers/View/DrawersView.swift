//
//  DrawersView.swift
//  iOS-ssumgo
//
//  Created by 정민지 on 11/25/24.
//

import SwiftUI

struct DrawersView: View {
    @EnvironmentObject var navigationManager: NavigationManager
    @StateObject private var viewModel = DrawersViewModel()
    @State private var selectedSortBy: String = "latest"
    @State private var selectedSubject: String = ""

    let sortBys: [String] = [
        "최신순",
        "생성순"
    ]
    
    var body: some View {
        VStack {
            BackNavigationBar(
                rightIcon: false,
                title: "보관함",
                onLeftIconTap: {
                    navigationManager.pop()
                }
            )

            if viewModel.isLoading {
                ProgressView()
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
            } else {
                ScrollView {
                    VStack(alignment: .leading, spacing: 20) {
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
                                },
                                selectedItem: $selectedSubject
                            )

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
                        .padding(.bottom, 8)

                        if $viewModel.mentorComments.isEmpty {
                            Text("보관함이 비었습니다.")
                                .frame(maxWidth: .infinity, alignment: .center)
                                .font(.pretendard(.regular, size: 14))
                                .foregroundColor(.sGray2)
                                .padding(.bottom, 10)
                        } else {
                            ForEach(viewModel.mentorComments, id: \.commentId) { comment in
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
        .navigationBarHidden(true)
    }
}

#Preview {
    DrawersView()
}
