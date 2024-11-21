//
//  SplashView.swift
//  iOS-ssumgo
//
//  Created by 정민지 on 11/17/24.
//

import SwiftUI

struct SplashView: View {
    @State private var navigateToNextView = false
    
    var body: some View {
        NavigationStack {
            VStack {
                Spacer()
                
                Image("img_logo_ssumg")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 48)
                
                Spacer()
                
                CustomBoxButton(
                    title: "숭실숨고 시작하기",
                    action: {
                        navigateToNextView = true
                    },
                    kerning: (16 * (-0.4 / 100))
                )
                .padding(.horizontal, 24)
            }
            .navigationDestination(isPresented: $navigateToNextView) {
                SsumgoMainView()
            }
        }
    }
}

#Preview {
    SplashView()
}
