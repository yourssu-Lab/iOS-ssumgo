//
//  LoginView.swift
//  iOS-ssumgo
//
//  Created by 정민지 on 11/17/24.
//

import SwiftUI
import YDS_SwiftUI

struct LoginView: View {
    @EnvironmentObject var navigationManager: NavigationManager
    @StateObject private var viewModel = LoginViewModel()
    
    var body: some View {
        LogoNavigationBar()
        
        Spacer()
            .frame(height: 63)
        
        VStack(spacing: 12) {
            YDSSuffixTextField(
                placeholder: "이메일을 입력해주세요",
                text: $viewModel.email
            )
            .overlay(
                HStack {
                    Spacer()
                    Text("@soongsil.ac.kr")
                        .font(.pretendard(.medium, size: 16))
                        .kerning(-0.24)
                        .foregroundColor(.sGray2)
                        .padding(.trailing, 16)
                }
            )
            .frame(height: 46)
            
            
            YDSPasswordTextField(
                placeholder: "비밀번호를 입력해주세요",
                text: $viewModel.password
            )
            .padding(.bottom, 41)
            
            CustomBoxButton(
                title: "로그인",
                action: {
                    viewModel.login()
                    if viewModel.isLoginSuccessful {
                        navigationManager.setRoot(.customTabBarView(tabBarType: .mentee))
                    }
                },
                isDisabled: !viewModel.isLoginEnabled,
                kerning: -0.24
            )
            
            CustomTextButton( title: "회원가입",  action: {
                navigationManager.append(.signUpView)
            },underline: true)
            
        }
        .padding(.horizontal, 36)
        .edgesIgnoringSafeArea(.all)
        .onReceive(viewModel.$errorMessage.compactMap { $0 }) { errorMessage in
            YDSToast(errorMessage,  duration: .short)
        }
        .registerYDSToast()
        .navigationBarHidden(true)
    }
}

#Preview {
    @Previewable @StateObject var navigationManager = NavigationManager()
    
    NavigationStack(path: $navigationManager.path) {
        LoginView()
            .environmentObject(navigationManager)
    }
}
