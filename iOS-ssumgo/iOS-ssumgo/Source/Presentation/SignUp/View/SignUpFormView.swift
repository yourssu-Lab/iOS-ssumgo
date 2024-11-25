//
//  SignUpFormView.swift
//  iOS-ssumgo
//
//  Created by 정민지 on 11/23/24.
//

import SwiftUI
import Combine
import YDS_SwiftUI

struct SignUpFormView: View {
    @EnvironmentObject var navigationManager: NavigationManager
    @StateObject private var viewModel: SignUpFormViewModel
    
    init(email: String) {
        _viewModel = StateObject(wrappedValue: SignUpFormViewModel(email: email))
    }
    
    var body: some View {
        VStack(spacing: 0) {
            Image("img_soomsilV2FullLogo")
                .resizable()
                .scaledToFit()
                .frame(height: 30)
                .padding(.bottom, 20)
            
            VStack(spacing: 0) {
                YDSLabel(
                    text: "회원 가입",
                    font: .pretendard(.semiBold, size: 18.6)
                )
                .padding(.bottom, 35)
                
                YDSLabel(
                    text: "사용할 닉네임을 입력해 주세요.",
                    font: .pretendard(.semiBold, size: 15),
                    textColor: YDSColor.textSecondary,
                    alignment: .leading
                )
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.bottom, 10)
                
                YDSSuffixTextField(
                    placeholder: "닉네임을 입력해주세요",
                    text: $viewModel.nickName
                )
                .frame(height: 36)
                .padding(.bottom, 20)
                
                YDSLabel(
                    text: "사용할 비밀번호를 입력해 주세요.",
                    font: .pretendard(.semiBold, size: 15),
                    textColor: YDSColor.textSecondary,
                    alignment: .leading
                )
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.bottom, 10)
                
                YDSPasswordTextField(
                    placeholder: "비밀번호를 입력해주세요",
                    text: $viewModel.password
                )
                .padding(.bottom, 27)
                
                CustomBoxButton(
                    title: "완료",
                    action: {
                        viewModel.signUp {
                            navigationManager.setRoot(.loginView)
                        }
                    },
                    backgroundColor: viewModel.canProceed ? YDSColor.buttonPoint : YDSColor.buttonDisabledBG,
                    font: .pretendard(.semiBold, size: 12),
                    cornerRadius: 8
                )
                .disabled(!viewModel.canProceed)
                .padding(.bottom, 10)
                
                YDSLabel(
                    text: "* 현재 지원하는 학과는 글로벌 미디어학과 밖에 없습니다.\n* 수강과목으로 프로그래밍2및실습,미디어제작및실습, 컴퓨터시스템개론이 자동 등록됩니다.",
                    font: .pretendard(.light, size: 12),
                    textColor: YDSColor.textSecondary,
                    alignment: .leading
                )
                .frame(maxWidth: .infinity, alignment: .leading)
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, 18)
            .padding(.horizontal, 20)
            .overlay(
                RoundedRectangle(cornerRadius: 14)
                    .stroke(Color.gray.opacity(0.3), lineWidth: 1)
            )
            .cornerRadius(14)
        }
        .padding(.horizontal, 9)
        .navigationBarHidden(true)
        .onChange(of: viewModel.errorMessage) {
            if let message = viewModel.errorMessage {
                YDSToast(message, duration: .short, haptic: .failed)
                viewModel.errorMessage = nil
            }
        }
    }
}


#Preview {
    @Previewable @StateObject var navigationManager = NavigationManager()
    
    NavigationStack(path: $navigationManager.path) {
        SignUpFormView(email: "@soongsil.ac.kr")
            .environmentObject(navigationManager)
    }
}
