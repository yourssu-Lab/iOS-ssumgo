//
//  ssumgoMain.swift
//  iOS-ssumgo
//
//  Created by 서준영 on 11/15/24.
//

import SwiftUI

struct SsumgoMainView: View {
    
    /// 인사 글
    @State var major: String = "글로벌미디어학부"
    @State var name: String = "정다운"
    
    private let rectWidth: CGFloat = 339
    
    var body: some View {
        VStack(spacing: 0) {
            HStack(spacing: 0) {

                Image("img_logo_ssumgo")
                    .padding(.horizontal, 36)
                
                Spacer()
                
                Button(action: {
                    // FIXME: 화면 전환
                    print("알림버튼 눌림")
                }) {
                    Image("ic_bell")
                }
                .padding(.trailing, 37)

            }
            
            Divider()
            
            Text("반가워요!")
                .font(.pretendard(.bold, size: 23))
                .foregroundStyle(.black)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.top, 30)
                .padding(.leading, 27)
            
            Text("\(major) \(name)님")
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
                    SubjectView(iconName: "img_programming", subjectName: "프로그래밍2\n및실습")
                    SubjectView(iconName: "img_media", subjectName: "미디어\n제작및실습")
                    SubjectView(iconName: "img_computer", subjectName: "컴퓨터\n시스템개론")
                }
                .padding(.horizontal, 25)
            }
            .padding(.top, 17)
            .padding(.bottom, 22)
            
            AnswersView()
            
            BannerView()
            
            Spacer()
        }
    }
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
 - [ ] API 연결
 - [ ] 인기 답변 3개 10초마다 반복 교체
 */
