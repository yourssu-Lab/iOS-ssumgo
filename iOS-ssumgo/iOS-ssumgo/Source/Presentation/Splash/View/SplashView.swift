//
//  SplashView.swift
//  iOS-ssumgo
//
//  Created by 정민지 on 11/17/24.
//

import SwiftUI

struct SplashView: View {
    @EnvironmentObject var navigationManager: NavigationManager
    @StateObject private var viewModel = SplashViewModel()
    
    var body: some View {
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
                    DispatchQueue.main.async {
                        viewModel.checkAuthentication()
                        if viewModel.navigateToMain {
                            navigationManager.setRoot(.customTabBarView(tabBarType: .mentee))
                        } else {
                            navigationManager.setRoot(.loginView)
                        }
                    }
                },
                kerning: (16 * (-0.4 / 100))
            )
            .padding(.horizontal, 24)
        }
        .navigationBarHidden(true)
    }
}

#Preview {
    @Previewable @StateObject var navigationManager = NavigationManager()
    
    NavigationStack(path: $navigationManager.path) {
        SplashView()
            .environmentObject(navigationManager)
    }
}
