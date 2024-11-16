//
//  LoginViewModel.swift
//  iOS-ssumgo
//
//  Created by 정민지 on 11/17/24.
//

import SwiftUI

class LoginViewModel: ObservableObject {
    @Published var email: String = ""
    @Published var password: String = ""
    
    var isLoginEnabled: Bool {
        return !email.isEmpty && !password.isEmpty
    }
}
