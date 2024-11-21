//
//  PostWriteView.swift
//  iOS-ssumgo
//
//  Created by 서준영 on 11/21/24.
//

import SwiftUI
import Combine

// 키보드 상태 추적 객체
class KeyboardGuardian: ObservableObject {
    @Published var isKeyboardVisible: Bool = false
    
    private var cancellableSet: Set<AnyCancellable> = []
    
    init() {
        NotificationCenter.default.publisher(for: UIResponder.keyboardWillShowNotification)
            .sink { [weak self] _ in
                self?.isKeyboardVisible = true
            }
            .store(in: &cancellableSet)
        
        NotificationCenter.default.publisher(for: UIResponder.keyboardWillHideNotification)
            .sink { [weak self] _ in
                self?.isKeyboardVisible = false
            }
            .store(in: &cancellableSet)
    }
}

struct PostWriteView: View {
    @State private var questionTitle: String = ""
    @State private var questionContents: String = ""
    
    @FocusState private var isKeyboardActive: Bool // 키보드 상태 추적
    @StateObject private var keyboardGuardian = KeyboardGuardian() // 키보드 상태 객체
    
    var body: some View {
        VStack(spacing: 0) {
            // FIXME: 백버튼이 아닌 X 로 왼쪽 아이콘 설정해야함
            BackNavigationBar(
                back: true,
                rightIcon: false,
                title: "질문등록"
            )
            Divider()
            
            ScrollView {
                VStack(spacing: 0) {
                    Text("제목")
                        .font(.pretendard(.semiBold, size: 16))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.top, 43)
                        .padding(.leading, 28)
                    
                    TextField("", text: $questionTitle)
                        .focused($isKeyboardActive) // 포커스 상태와 연결
                        .padding(.vertical, 8) // 텍스트 필드 안쪽 여백
                        .overlay(
                            Rectangle()
                                .frame(width: 341, height: 1)
                                .foregroundStyle(.sMain),
                            alignment: .bottom
                        )
                        .padding(.top, 4)
                        .padding(.horizontal, 28)
                    
                    Text("내용")
                        .font(.pretendard(.semiBold, size: 16))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.top, 43)
                        .padding(.leading, 28)
                    
                    TextEditor(text: $questionContents)
                        .focused($isKeyboardActive) // 포커스 상태와 연결
                        .frame(width: 341, height: 410)
                        .padding(.top, 4)
                        .padding(.horizontal, 28)
                        .foregroundColor(.black)
                        .font(.body)
                    
                    Spacer()
                    
                    CustomBoxButton(
                        title: "작성하기",
                        isDisabled: questionTitle.isEmpty,
                        kerning: -0.24
                    )
                    .padding(.horizontal, 27)
                    .padding(.top, 27)
                    
                }
            }
            
            if keyboardGuardian.isKeyboardVisible {
                HStack {
                    Spacer()
                    Button(action: {
                        isKeyboardActive = false // 키보드 포커스 해제
                    }) {
                        Image(systemName: "keyboard.chevron.compact.down.fill")
                            .resizable()
                            .foregroundStyle(.sGray)
                            .frame(width: 25, height: 25)
                            .padding(10)
                    }
                    .frame(width: 30, height: 30)
                    .padding(10)
                    .transition(.move(edge: .bottom).combined(with: .opacity))
                }
            }
        }
        .onTapGesture {
            isKeyboardActive = false // 배경 탭으로 키보드 닫기
        }
    }
}

#Preview {
    PostWriteView()
}
