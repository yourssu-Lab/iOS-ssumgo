//
//  BackNavigationBar.swift
//  iOS-ssumgo
//
//  Created by 정민지 on 11/17/24.
//

import SwiftUI

/*
 - BackNavigationBar: 커스텀 네비게이션 바 컴포넌트
 - Parameters:
        - back: 왼쪽 아이콘(뒤로가기 버튼) 표시 여부 (Bool, 기본값: true)
        - rightIcon: 오른쪽 아이콘 표시 여부 (Bool, 기본값: true)
        - rightIconImage: 오른쪽 아이콘 이미지 이름 (String?, 기본값: "ic_magnifying_glass")
        - iconSize: 왼쪽 및 오른쪽 아이콘 크기 (CGFloat, 기본값: 28)
        - title: 네비게이션 바 중앙에 표시될 텍스트 (String)
        - onLeftIconTap: 왼쪽 아이콘(뒤로가기 버튼) 탭 시 실행할 동작 (클로저, 기본값: nil)
        - onRightIconTap: 오른쪽 아이콘 탭 시 실행할 동작 (클로저, 기본값: nil)
 - Example:
        - 아래 Preview 참고
 */


struct BackNavigationBar: View {
    var back: Bool = true
    var rightIcon: Bool = true
    var leftIconImage: String?
    var rightIconImage: String? = "ic_magnifying_glass"
    var iconSize: CGFloat = 28
    var title: String
    var onLeftIconTap: (() -> Void)?
    var onRightIconTap: (() -> Void)?
    
    var body: some View {
        HStack {
            if back {
                Button(action: {
                    onLeftIconTap?()
                }) {
                    Image(leftIconImage ?? "ic_left_arrow")
                        .resizable()
                        .frame(width: 8.17, height: 20)
                        .foregroundColor(.black)
                }
                .frame(width: 28, height: 28)

            } else {
                Spacer().frame(width: 28)
            }
            
            Spacer()
            
            Text(title)
                .font(.pretendard(.bold, size: 18))
                .foregroundColor(.black)
            
            Spacer()
            
            if rightIcon, let rightIconImage = rightIconImage {
                Button(action: {
                    onRightIconTap?()
                }) {
                    Image(rightIconImage)
                        .renderingMode(.template)
                        .resizable()
                        .frame(width: iconSize, height: iconSize)
                        .foregroundColor(.sGray3)
                }
                .frame(width: 28, height: 28)
                
            } else {
                Spacer().frame(width: 28)
            }
        }
        .padding(.horizontal, 24)
        .frame(height: 58)
    }
}

#Preview {
    VStack(spacing: 20) {
        BackNavigationBar(
            rightIcon: true,
            rightIconImage: "ic_magnifying_glass",
            title: "양쪽다"
        )
        
        BackNavigationBar(
            back: false,
            rightIcon: true,
            rightIconImage: "ic_x",
            title: "오른쪽만"
        )
        
        BackNavigationBar(
            rightIcon: false,
            title: "왼쪽만"
        )
        
        BackNavigationBar(
            back: false,
            rightIcon: false,
            title: "텍스트만"
        )
    }
}
