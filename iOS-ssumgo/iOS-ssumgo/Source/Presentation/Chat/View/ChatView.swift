//
//  ChatView.swift
//  iOS-ssumgo
//
//  Created by 정민지 on 11/16/24.
//

import SwiftUI
import YDS_SwiftUI

enum ViewType {
    case mentee
    case mentor
}

struct ChatView: View {
    @State var viewType: ViewType
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                if viewType == .mentee {
                    SearchNavigationBar(title: "멘토 찾기")
                    
                    ScrollView {
                        MenteeView()
                    }
                } else {
                    SearchNavigationBar(title: "질문 보기")
                    ScrollView {
                        MentorView()
                    }
                }
            }
        }
    }
}

struct MenteeView: View {
    var body: some View {
        GeometryReader { geometry in
            VStack(alignment: .leading, spacing: 20) {
                HStack(alignment: .top) {
                    CustomAccordionButton(
                        title: "과목",
                        hasBorder: true,
                        selectedBackgroundColor: .clear,
                        textColor: .sGray2,
                        items: ["컴퓨터시스템개론", "미디어제작및실습", "프로그래밍2및실습"],
                        dropdownWidth: 95.06,
                        action: { _ in print("과목 버튼 클릭") }
                    )
                    
                    
                    Spacer()
                }
                .zIndex(1)

                
                
                HStack {
                    Text("멘토 답변")
                        .font(.pretendard(.bold, size: 18))
                        .padding(.bottom, 3)
                    
                    Spacer()
                    
                    CustomTextButton( title: "전체보기", underline: true)
                }
                
                ForEach(0..<2) { index in
                    VStack(alignment: .leading, spacing: 13) {
                        ChatPreview(chatType: .answer)
                    }
                }
                
                HStack {
                    Text("나의 질문")
                        .font(.pretendard(.bold, size: 18))
                        .padding(.top, 2)
                        .padding(.bottom, 3)
                    
                    Spacer()
                    
                    CustomTextButton( title: "전체보기", underline: true)
                }
                
                ForEach(0..<2) { index in
                    VStack(alignment: .leading, spacing: 13) {
                        ChatPreview(chatType: .answer)
                    }
                    
                }
                
                Spacer()
            }
            
            .padding(16)
        }
    }
}

struct MentorView: View {
    var body: some View {
        @State var filters: [(String, Bool)] = [
            ("영역", false),
            ("학과", true),
            ("학년", true),
            ("교수", false),
            ("과목", false)
        ]
        
        
        VStack(alignment: .leading, spacing: 16) {
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 8) {
                    ForEach(filters.indices, id: \.self) { index in
                        CustomAccordionButton(
                            title: filters[index].0,
                            isSelected: filters[index].1,
                            selectedBackgroundColor: .sMain,
                            defaultBackgroundColor: .sGray10P,
                            textColor: filters[index].1 ? .white : .sGray3,
                            items: ["최신순", "인기순", "생성순"],
                            dropdownWidth:46,
                            action: { _ in print("영역 버튼 클릭") }
                        )
                        .padding(.bottom, 1)
                        Spacer()
                    }
                }
            }
            .padding(.horizontal, 17.5)
            
            HStack {
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 1) {
                        ForEach(filters.indices, id: \.self) { index in
                            YDSPlainButton(
                                text: "글로벌미디어학부",
                                rightIcon: Image("ic_x"),
                                action: {
                                    print("삭제 버튼 클릭")
                                }
                            )
                        }
                    }
                }
                CustomTextButton(
                    title: "초기화",
                    color: .black,
                    underline: true
                )
                .padding(.leading, 17.5)
            }
            .padding(.horizontal, 17.5)
            .background(.sGray10P)
            
            
            VStack(alignment: .leading, spacing: 16) {
                HStack {
                    Text("멘티 질문")
                        .font(.pretendard(.bold, size: 20))
                        .foregroundStyle(.sMain)
                        .padding(.top, 2)
                        .padding(.bottom, 3)
                    
                    Spacer()
                    
                    CustomTextButton(
                        title: "전체보기",
                        color: .black,
                        underline: true
                    )
                }
                
                ForEach(0..<2) { index in
                    VStack(alignment: .leading, spacing: 16) {
                        ChatPreview(chatType: .question)
                    }
                }
            }
            .padding(.horizontal, 17.5)
        }
        .padding(.vertical, 18)
    }
}

#Preview {
    ChatView(viewType: .mentee)
}
