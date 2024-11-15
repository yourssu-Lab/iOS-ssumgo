//
//  ssumgoMain.swift
//  iOS-ssumgo
//
//  Created by 서준영 on 11/15/24.
//

import SwiftUI

struct ssumgoMain: View {
    
    /// 인사 글
    @State var major: String = "글로벌미디어학부"
    @State var name: String = "정다운"
    
    /// 수강중인 과목
    // FIXME: 파일 분리해서 처리하기
    @State var subjects: String = "프로그래밍2\n및실습"
    
    /// 인기 답변
    // FIXME: 파일 분리해서 처리하기
    @State var questionTitle: String = "컴퓨터그래픽스개론 기말 어떻게 나오나요ㅠㅠ?"
    @State var questioner: String = "글로벌미디어학부 23학번 정**운"
    @State var answer: String = "안녕하세요, 컴그개 기말 계산문제보다 코드로 많이 나와용 !!"
    
    /// 배너
    @State var bannerTile: String = "글미가 글미가 아니라고??!"
    @State var bannerContent: String = "저희는 이제 <디자인 소프트웨어학부> 입니다."
    @State var pageNum: Int = 1
    @State var pageTotalNum: Int = 3
    
    private let rectWidth: CGFloat = 339
    
    var body: some View {
        VStack(spacing: 0) {
            HStack(spacing: 0) {

                Image("img_logo_ssumgo")
                    .padding(.horizontal, 36)
                
                Spacer()
                Image("ic_bell")
                    .padding(.trailing, 37)
            }
            Divider()
            
            Text("반가워요!")
                .fixedSize()
                .font(.system(size: 23))
                .bold()
                .foregroundStyle(.black)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.top, 30)
                .padding(.leading, 27)
            
            Text("\(major) \(name)님")
                .font(.system(size: 23))
                .bold()
                .foregroundStyle(Color("s_main"))
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.top, 10)
                .padding(.leading, 27)

            Text("수강중인 전공과목")
                .frame(height: 16)
                .font(.system(size: 16))
                .bold()
                .foregroundStyle(.black)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.top, 16)
                .padding(.leading, 27)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 0) {
                    VStack(spacing: 0) {
                        ZStack {
                            RoundedRectangle(cornerRadius: 15)
                                .frame(width: 63, height: 50)
                                .foregroundStyle(Color("s_gray10p"))
                            
                            Image("img_programming")
                        }
                        Text("\(subjects)")
                            .font(.system(size: 12))
                            .multilineTextAlignment(.center)
                            .lineLimit(2)
                            .padding(.top, 8)
                    }
                    .padding(.horizontal, 25)
                    
                    VStack(spacing: 0) {
                        ZStack {
                            RoundedRectangle(cornerRadius: 15)
                                .frame(width: 63, height: 50)
                                .foregroundStyle(Color("s_gray10p"))
                            
                            Image("img_media")
                        }
                        
                        Text("미디어\n제작및실습")
                            .font(.system(size: 12))
                            .multilineTextAlignment(.center)
                            .lineLimit(2)
                            .padding(.top, 8)
                    }
                    .padding(.horizontal, 25)
                    
                    VStack(spacing: 0) {
                        ZStack {
                            RoundedRectangle(cornerRadius: 15)
                                .frame(width: 63, height: 50)
                                .foregroundStyle(Color("s_gray10p"))
                            
                            Image("img_computer")
                        }
                        
                        Text("컴퓨터\n시스템개론")
                            .font(.system(size: 12))
                            .multilineTextAlignment(.center)
                            .lineLimit(2)
                            .padding(.top, 8)
                    }
                    .padding(.horizontal, 25)
                }
                .padding(.horizontal, 25)
            }
            .padding(.top, 17)
            .padding(.bottom, 22)
            
            Text("인기 답변")
                .font(.system(size: 16))
                .bold()
                .foregroundStyle(.black)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.leading, 27)
            
            ZStack {
                RoundedRectangle(cornerRadius: 10)
                    .frame(width: rectWidth, height: 92.83)
                    .foregroundStyle(Color("s_gray10p"))
                
                VStack(spacing: 0) {
                    Text("\(questionTitle)")
                        .font(.system(size: 14))
                        .bold()
                        .foregroundStyle(.black)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.leading, 10)
                        .padding(.top, 10)
                    
                    Text("\(questioner)님")
                        .font(.system(size: 12))
                        .foregroundStyle(Color("s_gray"))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.leading, 10)
                        .padding(.top, 7)
                    
                    Divider()
                        .padding(.horizontal, 10)
                        .padding(.vertical, 10)
                    
                    Text("→ \(answer)")
                        .font(.system(size: 12))
                        .foregroundStyle(.black)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.leading, 10)
                    
                    Spacer()
                }
                .frame(width: rectWidth, height: 92.83)
                .padding(.horizontal, 27)
            }
            .padding(.top, 16)
            
            Text("최근 답변")
                .font(.system(size: 16))
                .bold()
                .foregroundStyle(.black)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.leading, 27)
                .padding(.top, 23)
            
            ZStack {
                RoundedRectangle(cornerRadius: 10)
                    .frame(width: rectWidth, height: 92.83)
                    .foregroundStyle(Color("s_gray10p"))
                
                VStack(spacing: 0) {
                    Text("\(questionTitle)")
                        .font(.system(size: 14))
                        .bold()
                        .foregroundStyle(.black)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.leading, 10)
                        .padding(.top, 10)
                    
                    Text("\(questioner)님")
                        .font(.system(size: 12))
                        .foregroundStyle(Color("s_gray"))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.leading, 10)
                        .padding(.top, 7)
                    
                    Divider()
                        .padding(.horizontal, 10)
                        .padding(.vertical, 10)
                    
                    Text("→ \(answer)")
                        .font(.system(size: 12))
                        .foregroundStyle(.black)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.leading, 10)
                    
                    Spacer()
                }
                .frame(width: rectWidth, height: 92.83)
                .padding(.horizontal, 27)
            }
            .padding(.top, 16)
            
            ZStack {
                RoundedRectangle(cornerRadius: 14)
                    .frame(width: rectWidth, height: 64)
                    .foregroundStyle(Color("banner_green"))
                
                VStack(spacing: 0) {
                    Text("\(bannerTile)")
                        .font(.system(size: 13))
                        .foregroundStyle(.black)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.leading, 13)
                        .padding(.top, 12)
                    
                    Text("\(bannerContent)")
                        .font(.system(size: 15))
                        .foregroundStyle(.black)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.leading, 13)
                        .padding(.top, 4)
                    
                    Spacer()
                }
                .frame(width: rectWidth, height: 64)
                .padding(.horizontal, 27)
                
                HStack(spacing: 0) {
                    Text("\(pageNum)/\(pageTotalNum)")
                        .font(.system(size: 11))
                        .frame(maxWidth: .infinity, alignment: .trailing)
                        .padding(.trailing, 12)
                        .padding(.top, 45)
                }
                .frame(width: rectWidth, height: 64)
            }
            .padding(.top, 24.34)
            
            Spacer()
        }
    }
}

#Preview {
    ssumgoMain()
}

// MARK: - todolist
/*
 - [ ] 버튼으로 바꿔주기 : 알림아이콘...
 - [ ] 수강중인 전공과목 뷰 옮기기
 - [ ] 인기 답변 뷰 옮기기
 - [ ] 인기 답변 3개 10초마다 반복 교체
 - [ ] 탭바 생성
 - [ ] API 연결
 - [ ] 폰트 적용
 */
