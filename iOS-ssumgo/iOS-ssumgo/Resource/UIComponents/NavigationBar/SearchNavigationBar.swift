//
//  BackNavigationBar.swift
//  iOS-ssumgo
//
//  Created by 정민지 on 11/17/24.
//

import SwiftUI

/*
 - SearchNavigationBar: 검색 기능과 기본 네비게이션 바를 포함한 커스텀 네비게이션 바 컴포넌트
 - Parameters:
        - title: 네비게이션 바 가운데에 표시될 텍스트 (String)
        - back: 왼쪽 뒤로가기 버튼 표시 여부 (Bool, 기본값: true)
        - recentSearchManager: 최근 검색어를 관리하는 싱글톤 객체 (ObservedObject)
 
 - Description:
     SearchNavigationBar는 검색 활성화 여부에 따라 두 가지 상태를 가집니다:
       1. 검색 모드: 검색 바와 최근 검색어 리스트를 표시합니다.
       2. 기본 네비게이션 바 모드: `BackNavigationBar`를 사용하며, 오른쪽 아이콘(돋보기)을 통해 검색 모드로 전환합니다.
     검색 모드에서는 입력한 검색어를 `RecentSearchManager`에 저장하며, 최근 검색어를 관리하거나 삭제할 수 있습니다.
     오른쪽 아이콘은 검색 모드 활성화를 위한 버튼 역할을 합니다.
 
 - Example:
     - 아래 Preview 참고
 
 - Usage:
     - `title`: 네비게이션 바의 제목을 설정합니다.
     - `recentSearchManager`: `RecentSearchManager`를 사용해 검색어를 관리합니다.
     - 검색 모드:
         - 검색 창 입력 후 엔터(커밋)로 검색어를 저장합니다.
         - `X` 버튼을 클릭하여 검색 모드를 종료하고 입력을 초기화합니다.
     - 기본 모드:
         - `BackNavigationBar`가 사용됩니다. 오른쪽 돋보기 아이콘을 통해 검색 모드로 전환됩니다.
 */

struct SearchNavigationBar: View {
    var title: String
    var back: Bool = false
    @State private var isSearching: Bool = false
    
    @Binding  var searchText: String
    
    var onBackTap: (() -> Void)? = nil
    var onSearchIconTap: (() -> Void)? = nil
    var onCancelSearch: (() -> Void)? = nil
    
    @ObservedObject var recentSearchManager = RecentSearchManager.shared
    
    var body: some View {
        VStack(spacing: 0) {
            if isSearching {
                CustomSearchBar(
                    searchText: $searchText,
                    onCancel: {
                        withAnimation {
                            isSearching = false
                            searchText = ""
                            onCancelSearch?()
                        }
                    },
                    onCommit: {
                        if !searchText.isEmpty {
                            recentSearchManager.addSearchTerm(searchText)
                            searchText = ""
                        }
                    }
                )
                
                Rectangle()
                    .fill(.sGray3.opacity(0.3))
                    .frame(height: 0.5)
                    .padding(.bottom, 19)
                
                if !recentSearchManager.recentSearches.isEmpty {
                    RecentSearchView(
                        recentSearchManager: recentSearchManager,
                        onSelectSearch: { selectedSearch in
                            searchText = selectedSearch
                            
                        }
                    )
                }
            } else {
                BackNavigationBar(
                    back: back,
                    rightIcon: true,
                    rightIconImage: "ic_magnifying_glass",
                    title: "\(title)",
                    onLeftIconTap: {
                        onBackTap?()
                    },
                    onRightIconTap:  {
                        withAnimation {
                            isSearching = true
                        }
                        onSearchIconTap?()
                    }
                )
                
                Rectangle()
                    .fill(.sGray3.opacity(0.3))
                    .frame(height: 0.5)
            }
        }
        .background(.white)
    }
}

#Preview {
    @Previewable @State var searchText: String = ""
    
    SearchNavigationBar(
        title: "질문보기",
        back: true,
        searchText:  $searchText
    )
}
