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
    @State private var navigateToNextView = false
    
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
                        navigateToNextView = true
                    },
                    isDisabled: !viewModel.isLoginEnabled,
                    kerning: -0.24
                )
                .navigationDestination(isPresented: $navigateToNextView) {
                    CustomTabBarView(tabBarType: .mentor)
                }
            }
            .padding(.horizontal, 36)
            .edgesIgnoringSafeArea(.all)
            Spacer()
        }
    }
}

#Preview {
    LoginView()
}
