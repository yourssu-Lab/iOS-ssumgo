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
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 0) {
//                    SubjectView(iconName: "img_programming", subjectName: "프로그래밍2\n및실습")
//                    SubjectView(iconName: "img_media", subjectName: "미디어\n제작및실습")
//                    SubjectView(iconName: "img_computer", subjectName: "컴퓨터\n시스템개론")
                    
                    SubjectView(iconName: "img_programming", subjectName: viewModel.subjectName1)
                    SubjectView(iconName: "img_media", subjectName: viewModel.subjectName2)
                    SubjectView(iconName: "img_computer", subjectName: viewModel.subjectName3)
                }
                .padding(.horizontal, 25)
            }
            .padding(.top, 17)
            .padding(.bottom, 22)
            
            AnswersView()
            BannerView()
            Spacer()
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

// MARK: - todolist
/*
 - [x] 버튼으로 바꿔주기 : 알림아이콘...
 - [x] 수강중인 전공과목 뷰 옮기기
 - [x] 답변 뷰 옮기기
 - [x] 폰트 적용
 - [x] 학생 정보 API 연결
 - [ ] 인기 답변, 최근 답변 API연결
 - [x] 인기 답변 3개 10초마다 반복 교체
 */
