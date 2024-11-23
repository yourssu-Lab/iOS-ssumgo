//
//  LoginView.swift
//  iOS-ssumgo
//
//  Created by 정민지 on 11/17/24.
//

import SwiftUI
import YDS_SwiftUI

struct LoginView: View {
    @StateObject private var viewModel = LoginViewModel()
    
    var body: some View {
        NavigationStack {
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
                    },
                    isDisabled: !viewModel.isLoginEnabled,
                    kerning: -0.24
                )
                .navigationDestination(isPresented: $viewModel.isLoginSuccessful) {
                    CustomTabBarView(tabBarType: .mentor)
                }
                
                CustomTextButton( title: "회원가입",  action: {
                    viewModel.isSignUpTapped = true
                },underline: true)
                .navigationDestination(isPresented: $viewModel.isSignUpTapped ) {
                    SignUpView()
                }
            }
            .padding(.horizontal, 36)
            .edgesIgnoringSafeArea(.all)
            .onReceive(viewModel.$errorMessage.compactMap { $0 }) { errorMessage in
                YDSToast(errorMessage,  duration: .short)
            }
            .registerYDSToast()
            Spacer()
        }
        .navigationBarHidden(true)
    }
}

#Preview {
    LoginView()
}
