//
//  NorificationView.swift
//  iOS-ssumgo
//
//  Created by 서준영 on 11/17/24.
//

import SwiftUI

struct NotificationView: View {
    @EnvironmentObject var navigationManager: NavigationManager
    
    private let rectWidth: CGFloat = 339
    
    @State var notRead: Bool = true
    var recent7Days: Bool = true
    var recent30Days: Bool = true
    
    var body: some View {
        VStack(spacing: 0) {
            BackNavigationBar(
                rightIcon: false,
                title: "알림",
                onLeftIconTap: {
                    navigationManager.pop()
                }
            )
            Divider()
            
            if notRead == false && recent7Days == false && recent30Days == false {
                VStack(spacing: 0) {
                    NotificationListView(notifications: [])
                        .padding(.top, 282)
                    Spacer()
                }
            } else {
                ScrollView {
                    VStack(spacing: 0) {
                        if notRead == true {
                            HStack {
                                Text("읽지 않음")
                                    .font(.pretendard(.bold, size: 16))
                                    .foregroundStyle(.black)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .padding(.leading, 28)
                                Spacer()
                                CustomTextButton(
                                    title: "모두읽음",
                                    action: {
                                        print("모두읽음 버튼 클릭")
                                        notRead = false
                                    },
                                    color: .sMain,
                                    font: .pretendard(.regular, size: 16),
                                    underline: true
                                )
                                .padding(.trailing, 26)
                            }
                            .padding(.top, 32)
                            
                            
                            NotificationListView(notifications: [
                                ("소프트웨어학부 기말 프로젝트 주제가 뭔가요?", "박**", 21, "소프트웨어학부"),
                                ("전자정보공학부 실험 수업에서 준비해야 할 사항이 있나요?", "최**", 23, "전자정보공학부"),
                                ("컴퓨터학부 기말 프로젝트 제출 기한은 언제인가요?", "박**", 21, "컴퓨터학부")
                            ])
                            .padding(.horizontal, 23)
                            .padding(.top, 16)
                        }
                        
                        if recent7Days == true {
                            Text("최근 7일")
                                .font(.pretendard(.bold, size: 16))
                                .foregroundStyle(.black)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(.leading, 28)
                                .padding(.top, 32)
                            
                            NotificationListView(notifications: [
                                ("소프트웨어학부 기말 프로젝트 주제가 뭔가요?", "박**", 21, "소프트웨어학부"),
                                ("전자정보공학부 실험 수업에서 준비해야 할 사항이 있나요?", "최**", 23, "전자정보공학부")
                            ])
                            .padding(.horizontal, 23)
                            .padding(.top, 16)
                        }
                        
                        if recent30Days == true {
                            Text("최근 30일")
                                .font(.pretendard(.bold, size: 16))
                                .foregroundStyle(.black)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(.leading, 28)
                                .padding(.top, 32)
                            
                            NotificationListView(notifications: [
                                ("소프트웨어학부 기말 프로젝트 주제가 뭔가요?", "박**", 21, "소프트웨어학부"),
                                ("전자정보공학부 실험 수업에서 준비해야 할 사항이 있나요?", "최**", 23, "전자정보공학부"),
                                ("경영학부 중간고사 범위가 어떻게 되나요?", "김**", 21, "경영학부"),
                                ("영어영문학과 발표 과제에서 유의할 점은 무엇인가요?", "이**", 21, "영어영문학과"),
                                ("글로벌미디어학부 기말고사 준비 팁이 있을까요?", "정**", 21, "글로벌미디어학부"),
                                ("사회복지학부의 봉사활동 요건은 어떻게 되나요?", "윤**", 22, "사회복지학부")
                            ])
                            .padding(.horizontal, 23)
                            .padding(.top, 16)
                        }
                    }
                }
            }
        }
        .navigationBarHidden(true)
    }
}

#Preview {
    let navigationManager = NavigationManager()
    
    NotificationView()
        .environmentObject(navigationManager)
}

// MARK: - todolist
/*
 - [x] 알림 없을 때 빈 화면 구현
 - [x] 커스텀 탭바 적용
 - [ ] API 연결
 */
