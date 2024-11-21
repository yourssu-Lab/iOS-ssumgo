//
//  UnreadNotificationView.swift
//  iOS-ssumgo
//
//  Created by 서준영 on 11/17/24.
//

import SwiftUI

struct NotificationListView: View {
    @State var notifications: [(question: String, nickname: String, studentIdNumber: Int, department: String)]
    
    var body: some View {
        // FIXME: 읽지 않음, 최근 7일, 최근 30일 모두 알림이 없을 때 화면 이 나오도록 고치기
        if notifications.isEmpty {
            Text("알림이 없습니다")
                .font(.pretendard(.semiBold, size: 22))
                .foregroundStyle(Color("s_gray2"))
        } else {
            VStack(alignment: .leading, spacing: 10) {
                ForEach(notifications.indices, id: \.self) { index in
                    VStack(alignment: .leading, spacing: 10) {
                        Text("\(notifications[index].question)")
                            .font(.pretendard(.semiBold, size: 14))
                            .foregroundColor(.black)
                            .padding(.bottom, -3)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        Text("\(notifications[index].department) \(notifications[index].studentIdNumber)학번 \(notifications[index].nickname)님의 답변 도착!")
                            .font(.pretendard(.regular, size: 12))
                            .foregroundColor(.black)
                            .opacity(0.6)
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    
                    // 각 질문 사이에 구분선 추가 (마지막 요소에는 추가하지 않음)
                    if index < notifications.count - 1 {
                        Rectangle()
                            .fill(Color.sGray3.opacity(0.3))
                            .frame(height: 0.5)
                    }
                }
            }
            .padding(10)
            .frame(maxWidth: .infinity)
            .background(Color.gray.opacity(0.1))
            .cornerRadius(10)
        }
    }
}

#Preview {
//    NotificationListView(notifications: [
//        ("소프트웨어학부 기말 프로젝트 주제가 뭔가요?", "박**", 21, "소프트웨어학부"),
//        ("전자정보공학부 실험 수업에서 준비해야 할 사항이 있나요?", "최**", 23, "전자정보공학부"),
//        ("경영학부 중간고사 범위가 어떻게 되나요?", "김**", 21, "경영학부")
//
//    ])
//    .padding(23)
    NotificationListView(notifications: [])
}

