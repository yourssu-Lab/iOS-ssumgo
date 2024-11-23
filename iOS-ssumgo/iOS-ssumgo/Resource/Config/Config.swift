//
//  Config.swift
//  iOS-ssumgo
//
//  Created by 정민지 on 11/22/24.
//

import SwiftUI

struct Config {
    private init() {}
    
    static var signupWebURL: String {
        return "https://soomsil.de/signup"
    }
    
    static var signupAuthURL: String {
        return "https://api.test.auth.yourssu.com"
    }

    static var baseURL: String {
        return "https://api.ssumgo.yourssu.com"
    }
    
    static var headerWithSignupAuthAccessToken: [String: String] {
        guard let accessToken = Config.signupAuthAccessToken, !accessToken.isEmpty else {
            print("⚠️ SignupAuth Access Token이 설정되지 않았습니다.")
            return ["Content-Type": "application/json"]
        }
        return [
            "Content-Type": "application/json",
            "Authorization": "Bearer \(accessToken)"
        ]
    }
    
    static var headerWithAccessToken: [String: String] {
        guard let accessToken = Config.accessToken, !accessToken.isEmpty else {
            print("⚠️ Access Token이 설정되지 않았습니다.")
            return ["Content-Type": "application/json"]
        }
        return [
            "Content-Type": "application/json",
            "Authorization": "Bearer \(accessToken)"
        ]
    }
    
    static var headerWithRefreshToken: [String: String] {
        guard let refreshToken = Config.refreshToken, !refreshToken.isEmpty else {
            print("⚠️ Refresh Token이 설정되지 않았습니다.")
            return ["Content-Type": "application/json"]
        }
        return [
            "Content-Type": "application/json",
            "Authorization": "Bearer \(refreshToken)"
        ]
    }
    
    static var signupAuthAccessToken: String? {
        get {
            UserDefaults.standard.string(forKey: "accessToken")
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "accessToken")
        }
    }
    
    static var sessionToken: String? {
        get {
            UserDefaults.standard.string(forKey: "sessionToken")
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "sessionToken")
        }
    }
    
    static var accessToken: String? {
        get {
            UserDefaults.standard.string(forKey: "accessToken")
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "accessToken")
        }
    }
    
    static var refreshToken: String? {
        get {
            UserDefaults.standard.string(forKey: "refreshToken")
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "refreshToken")
        }
    }
    
    static func isAccessTokenValid() -> Bool {
        if let accessToken = Config.accessToken, !accessToken.isEmpty {
            return true
        }
        return false
    }
    
    static func isRefreshTokenValid() -> Bool {
        if let refreshToken = Config.refreshToken, !refreshToken.isEmpty {
            return true
        }
        return false
    }
}
