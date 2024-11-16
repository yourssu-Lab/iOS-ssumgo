//
//  RecentSearchManager.swift
//  iOS-ssumgo
//
//  Created by 정민지 on 11/17/24.
//

import Foundation

/*
 - RecentSearchManager: 최근 검색어를 관리하는 싱글톤 클래스
   RecentSearchManager는 사용자의 최근 검색어를 저장, 관리, 삭제하는 기능을 제공합니다.
   앱 종료 후에도 검색어를 유지하기 위해 UserDefaults를 활용합니다.

 - 주요 기능:
   - 검색어 추가: 중복 검색어를 방지하며, 최대 5개의 검색어만 유지합니다.
   - 검색어 삭제: 특정 검색어를 삭제하거나 모든 검색어를 초기화할 수 있습니다.
   - 앱 종료 후에도 검색어를 유지하도록 UserDefaults에 저장 및 로드합니다.

 - 클래스 상세:
   - `ObservableObject`를 채택하여, `@Published` 속성으로 뷰와 데이터 바인딩이 가능합니다.
   - 싱글톤 패턴으로 구현되어 앱 전역에서 동일한 인스턴스를 공유합니다.

 - Example:
    ```swift
        // 싱글톤 인스턴스를 통해 RecentSearchManager 사용
        let searchManager = RecentSearchManager.shared

        // 검색어 추가
        searchManager.addSearchTerm("SwiftUI")

        // 특정 검색어 삭제
        searchManager.removeSearchTerm("SwiftUI")

        // 모든 검색어 초기화
        searchManager.clearSearches()

        // 최근 검색어 확인
        print(searchManager.recentSearches)
    ```
*/

final class RecentSearchManager: ObservableObject {
    static let shared = RecentSearchManager()
    
    @Published var recentSearches: [String] = [] {
        didSet {
            saveSearches()
        }
    }
    
    private init() {
        loadSearches()
    }
    
    private func saveSearches() {
        UserDefaults.standard.set(recentSearches, forKey: "RecentSearches")
    }
    
    private func loadSearches() {
        recentSearches = UserDefaults.standard.stringArray(forKey: "RecentSearches") ?? []
    }
    
    func addSearchTerm(_ term: String) {
        if !recentSearches.contains(term) {
            recentSearches.insert(term, at: 0)
            if recentSearches.count > 5 {
                recentSearches.removeLast()
            }
        }
    }
    
    func removeSearchTerm(_ term: String) {
        recentSearches.removeAll { $0 == term }
    }
    
    func clearSearches() {
        recentSearches.removeAll()
    }
}
