//
//  SplashView.swift
//  iOS-ssumgo
//
//  Created by 정민지 on 11/17/24.
//

import SwiftUI

struct SplashView: View {
    @StateObject private var viewModel = SplashViewModel()

    var body: some View {
        NavigationStack {
            VStack {
                Spacer()
                
                Image("img_ssumg_logo")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 48)
                
                Spacer()
                
                CustomBoxButton(
                    title: "숭실숨고 시작하기",
                    action: {
                        viewModel.checkAuthentication()
                    },
                    kerning: (16 * (-0.4 / 100))
                )
                .padding(.horizontal, 24)
            }
            .navigationDestination(isPresented: $viewModel.navigateToLogin) {
                NavigationStack {
                    LoginView()
                }
            }
            .navigationDestination(isPresented: $viewModel.navigateToMain) {
                NavigationStack {
                    CustomTabBarView(tabBarType: .mentee)
                }
            }
        }
        .navigationBarHidden(true)
    }        
}

#Preview {
    SplashView()
}
