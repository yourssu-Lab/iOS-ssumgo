//
//  NavigationManager.swift
//  iOS-ssumgo
//
//  Created by 정민지 on 11/25/24.
//

import Foundation
import SwiftUI
import Combine

enum NavigationDestination: Hashable {
    case splashView
    case loginView
    
    // MARK: - 회원가입 네비게이션
    
    case signUpView
    case emailAuthView(email: String)
    case signUpFormView(email: String)
    
    // MARK: - 홈 네비게이션
    
    case customTabBarView(tabBarType: TabBarType)
    case homeView
    case notificationView
    
    // MARK: - 멘토찾기, 질문보기 네비게이션
    
    case chatView(viewType: ChatViewType)
    case postWriteView(subjectId: Int)
    case getMentorCommentsView
    case getMyQuestionsView
    case getMyCommentsView
    case getQuestionsBySubjectView

    // MARK: - 마이페이지 네비게이션
    
    case MyPageView
    case drawersView
    case termsOfServiceView
}

final class NavigationManager: ObservableObject {
    @Published var path: [NavigationDestination] = [] {
           didSet {
               print("Updated Path: \(path)")
           }
       }
    @Published var tabPaths: [BottomTab: [NavigationDestination]] = [:] {
        didSet {
            print("Updated Tab Paths: \(tabPaths)")
        }
    }

    func setRoot(_ root: NavigationDestination) {
        DispatchQueue.main.async {
            self.path = [root]
        }
    }

    func append(_ destination: NavigationDestination) {
        DispatchQueue.main.async {
            self.path.append(destination)
        }
    }

    func resetNavigation() {
        path = []
    }

    func pop() {
        guard !path.isEmpty else { return }
        path.removeLast()
    }
}

extension NavigationManager{
    func updatePath(for tab: BottomTab, path: [NavigationDestination]) {
        tabPaths[tab] = path
    }

    func append(to tab: BottomTab, destination: NavigationDestination) {
        var currentPath = tabPaths[tab] ?? []
        currentPath.append(destination)
        tabPaths[tab] = currentPath
    }

    func resetPath(for tab: BottomTab) {
        tabPaths[tab] = []
    }

    func pop(for tab: BottomTab) {
        var currentPath = tabPaths[tab] ?? []
        if !currentPath.isEmpty {
            currentPath.removeLast()
            tabPaths[tab] = currentPath
        }
    }

    func getPath(for tab: BottomTab) -> [NavigationDestination] {
        return tabPaths[tab] ?? []
    }
}
