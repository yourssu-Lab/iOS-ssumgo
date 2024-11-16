//
//  CustomTabBarView.swift
//  iOS-ssumgo
//
//  Created by 정민지 on 11/16/24.
//


import SwiftUI

enum TabBarType {
    case mentee
    case mentor
}

enum BottomTab: String, CaseIterable {
    case home = "Home"
    case chat = "Chat"
    case mypage = "Mypage"
}

struct CustomTabBarView: View {
    @State private var selectedTab: BottomTab = .home
    @State var tabBarType: TabBarType
    
    var body: some View {
        VStack(spacing: 0) {
            ZStack {
                switch selectedTab {
                case .home:
                    HomeView()
                case .chat:
                    if tabBarType == .mentee {
                        ChatView()
                    } else {
                        ChatView()
                    }
                case .mypage:
                    MyPageView()
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            
            CustomTabBar(
                selectedTab: $selectedTab,
                tabBarType: $tabBarType
            )
        }
        .edgesIgnoringSafeArea(.bottom)
    }
}

struct CustomTabBar: View {
    @Binding var selectedTab: BottomTab
    @Binding var tabBarType: TabBarType
    
    private let tabs: [(BottomTab, String, String, CGFloat)] = [
        (.home, "ic_home", "홈", 20),
        (.chat, "ic_chat_fill", "", 26),
        (.mypage, "ic_person", "마이페이지", 20)
    ]
    
    var body: some View {
        HStack {
            ForEach(tabs, id: \.0) { tab, imageName, label, imageSize in
                TabButton(
                    isSelected: selectedTab == tab,
                    imageName: imageName,
                    label: tab == .chat
                    ? (tabBarType == .mentee ? "멘토 찾기" : "질문보기")
                    : label,
                    imageSize: imageSize
                ) {
                    withAnimation {
                        selectedTab = tab
                    }
                }
                if tab != tabs.last?.0 {
                    Spacer()
                }
            }
        }
        .frame(height: 76)
        .padding(.horizontal, 53)
        .background(.white)
    }
}

struct TabButton: View {
    let isSelected: Bool
    let imageName: String
    let label: String
    let imageSize: CGFloat
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            VStack(spacing: 6) {
                Image(imageName)
                    .renderingMode(.template)
                    .resizable()
                    .scaledToFit()
                    .frame(width: imageSize, height: imageSize)
                    .foregroundStyle(isSelected ? .sMain : .sGray2)
                
                Text(label)
                    .font(.pretendard(.bold, size: 10))
                    .tracking(-0.24)
                    .foregroundStyle(isSelected ? .sMain : .sGray2)
            }
            .frame(width: 43, height: 44)
        }
    }
}

#Preview {
    CustomTabBarView(tabBarType: .mentor)
}
