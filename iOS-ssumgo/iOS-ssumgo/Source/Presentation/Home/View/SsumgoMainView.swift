//
//  ssumgoMain.swift
//  iOS-ssumgo
//
//  Created by 서준영 on 11/15/24.
//

import SwiftUI

struct SsumgoMainView: View {
    
    @StateObject private var viewModel = SsumgoMainViewModel()
    @State private var showNotificationView = false
    
    var body: some View {
        VStack(spacing: 0) {
            LogoNavigationBar(
                alarm: true,
                alarmAction: { showNotificationView = true }
            )
            .background(
                NavigationLink(
                    destination: NotificationView()
                        .navigationBarBackButtonHidden(true),
                    isActive: $showNotificationView,
                    label: { EmptyView() }
                )
                .hidden()
            )
            
            Divider()
            
            ScrollView(.vertical, showsIndicators: false) {
                
                Text("반가워요!")
                    .font(.pretendard(.bold, size: 23))
                    .foregroundStyle(.black)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.top, 30)
                    .padding(.leading, 27)
                
                Text("\(viewModel.department) \(viewModel.nickname)님")
                    .font(.pretendard(.bold, size: 23))
                    .foregroundStyle(Color("s_main"))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.top, 10)
                    .padding(.leading, 27)
                
                Text("수강중인 전공과목")
                    .font(.pretendard(.bold, size: 16))
                    .foregroundStyle(.black)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.top, 16)
                    .padding(.leading, 27)
                
                if viewModel.subjects.isEmpty {
                    NoSubjectView(viewModel: SsumgoMainViewModel())
                        .padding(.vertical, 20)
                        .padding(.horizontal, 25)
                } else {
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 0) {
                            if SubjectManager.shared.subjectId1 != 0 {
                                SubjectView(
                                    iconName: "img_programming",
                                    subjectName: SubjectManager.shared.subjectName1,
                                    subjectId: SubjectManager.shared.subjectId1
                                )
                            }
                            if SubjectManager.shared.subjectId2 != 0 {
                                SubjectView(
                                    iconName: "img_media",
                                    subjectName: SubjectManager.shared.subjectName2,
                                    subjectId: SubjectManager.shared.subjectId2
                                )
                            }
                            if SubjectManager.shared.subjectId3 != 0 {
                                SubjectView(
                                    iconName: "img_computer",
                                    subjectName: SubjectManager.shared.subjectName3,
                                    subjectId: SubjectManager.shared.subjectId3
                                )
                            }
                        }
                        .padding(.horizontal, 25)
                    }
                    .padding(.top, 17)
                    .padding(.bottom, 22)
                }
                
                AnswersView()
                BannerView()
                Spacer()
            }
        }
        .navigationBarHidden(true)
        .onAppear {
            viewModel.fetchMainData()
        }
    }
}

struct Constants {
    static let rectWidth: CGFloat = 339
}

#Preview {
    SsumgoMainView()
}

