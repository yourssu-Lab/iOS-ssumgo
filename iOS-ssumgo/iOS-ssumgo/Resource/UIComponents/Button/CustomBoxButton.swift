//
//  CustomBoxButton.swift
//  iOS-ssumgo
//
//  Created by 정민지 on 11/17/24.
//

import SwiftUI

/*
 - CustomBoxButton: 커스텀 버튼 컴포넌트
 - Parameters:
        - title: 버튼에 표시될 텍스트 (String)
        - action: 버튼 클릭 시 실행할 동작 (클로저)
        - isDisabled: 버튼 활성화 여부 (Bool, 기본값: false)
        - backgroundColor: 버튼 배경색 (Color, 기본값: .sMain)
        - foregroundColor: 버튼 텍스트 색상 (Color, 기본값: .white)
        - font: 버튼 텍스트의 폰트 (Font, 기본값: .pretendard(.extraBold, size: 16))
        - cornerRadius: 버튼 모서리 둥글기 값 (CGFloat, 기본값: 10)
        - padding: 버튼 내부 여백 (CGFloat, 기본값: 14)
        - lineSpacing: 버튼 텍스트의 행간 (CGFloat, 기본값: 0)
        - tracking: 버튼 텍스트의 자간 (CGFloat, 기본값: 0)
 - Example:
     ```swift
     CustomBoxButton(
         title: "로그인",
         isDisabled: false,
         backgroundColor: .blue,
         foregroundColor: .white,
         font: .pretendard(.bold, size: 16),
         cornerRadius: 8,
         padding: 12,
         lineSpacing: 2,
         kerning: -0.2
     ) {
         print("로그인 버튼 클릭")
     }
     ```
 */


struct CustomBoxButton: View {
    let title: String
    var action: () -> Void = {}
    var isDisabled: Bool = false
    var backgroundColor: Color = .sMain
    var foregroundColor: Color = .white
    var font: Font = .pretendard(.extraBold, size: 16)
    var cornerRadius: CGFloat = 10
    var padding: CGFloat = 14
    var lineSpacing: CGFloat = 0
    var kerning: CGFloat = 0

    init(
        title: String,
        action: @escaping () -> Void = {},
        isDisabled: Bool = false,
        backgroundColor: Color = .sMain,
        foregroundColor: Color = .white,
        font: Font = .pretendard(.extraBold, size: 16),
        cornerRadius: CGFloat = 10,
        padding: CGFloat = 14,
        lineSpacing: CGFloat = 0,
        kerning: CGFloat = 0
    ) {
        self.title = title
        self.action = action
        self.isDisabled = isDisabled
        self.backgroundColor = backgroundColor
        self.foregroundColor = foregroundColor
        self.font = font
        self.cornerRadius = cornerRadius
        self.padding = padding
        self.lineSpacing = lineSpacing
        self.kerning = kerning
    }

    var body: some View {
        Button(action: action) {
            Text(title)
                .font(font)
                .foregroundColor(isDisabled ? .white : foregroundColor)
                .lineSpacing(lineSpacing)
                .kerning(kerning)
                .padding(padding)
                .frame(maxWidth: .infinity)
                .background(isDisabled ? .sGray2 : backgroundColor)
                .cornerRadius(cornerRadius)
        }
        .disabled(isDisabled)
    }
}

#Preview {
    VStack(spacing: 20) {
        CustomBoxButton(
            title: "활성화된 버튼",
            kerning: (16 * (-0.4 / 100))
        )
        
        CustomBoxButton(
            title: "비활성화된 버튼",
            isDisabled: true,
            kerning: -0.24
        )
    }
}
