//
//  SplashViewModel.swift
//  iOS-ssumgo
//
//  Created by 정민지 on 11/22/24.
//

import SwiftUI
import Combine

final class SplashViewModel: ObservableObject {
    @Published var navigateToLogin: Bool = false
    @Published var navigateToMain: Bool = false

    func checkAuthentication() {
        if Config.isAccessTokenValid() && Config.isRefreshTokenValid() {
            navigateToMain = true
        } else {
            navigateToLogin = true
        }
    }
}
