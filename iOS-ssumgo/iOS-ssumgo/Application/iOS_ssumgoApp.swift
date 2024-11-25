//
//  iOS_ssumgoApp.swift
//  iOS-ssumgo
//
//  Created by 정민지 on 11/13/24.
//

import SwiftUI

@main
struct iOS_ssumgoApp: App {
    @StateObject private var navigationManager = NavigationManager()
    
    var body: some Scene {
        WindowGroup {
            NavigationStack(path: $navigationManager.path) {
                SplashView()
                    .environmentObject(navigationManager)
                    .navigationDestination(for: NavigationDestination.self) { destination in
                        switch destination {
                        case .splashView:
                            SplashView()
                                .environmentObject(navigationManager)
                        case .loginView:
                            LoginView()
                                .environmentObject(navigationManager)
                        
                        // MARK: - 회원가입 네비게이션
                            
                        case .signUpView:
                            SignUpView()
                                .environmentObject(navigationManager)
                        case .emailAuthView(let email):
                            EmailAuthView(email: email)
                                .environmentObject(navigationManager)
                        case .signUpFormView(let email):
                            SignUpFormView(email: email)
                                .environmentObject(navigationManager)

                       
                        // MARK: - 홈 네비게이션
                        case .customTabBarView(let tabBarType):
                            CustomTabBarView(tabBarType: tabBarType)
                                .environmentObject(navigationManager)
                        case .notificationView:
                            NotificationView()
                                .environmentObject(navigationManager)
                      
                        // MARK: - 멘토찾기, 질문보기 네비게이션
                            
                        case .postWriteView(let subjectId):
                            PostWriteView(subjectId: subjectId)
                                .environmentObject(navigationManager)
                        case .getMentorCommentsView:
                            GetMentorCommentsView()
                                .environmentObject(navigationManager)
                        case .getMyQuestionsView:
                            GetMyQuestionsView()
                                .environmentObject(navigationManager)
                        case .getMyCommentsView:
                            GetMyCommentsView()
                                .environmentObject(navigationManager)
                        case .getQuestionsBySubjectView:
                            GetMyQuestionsView()
                                .environmentObject(navigationManager)

                        // MARK: - 마이페이지 네비게이션
                            
                        case .termsOfServiceView:
                            TermsOfServiceView()
                                .environmentObject(navigationManager)
                        case .drawersView:
                            DrawersView()
                                .environmentObject(navigationManager)
                            
                        default:
                            Text("Unhandled Destination: \(destination)")
                        }
                    }
            }
        }
    }
}
