//
//  CustomTextButton.swift
//  iOS-ssumgo
//
//  Created by 정민지 on 11/17/24.
//

import SwiftUI

/*
 - CustomTextButton: 커스텀 텍스트 버튼 컴포넌트
 - Parameters:
        - title: 버튼에 표시될 텍스트 (String)
        - action: 버튼 클릭 시 실행할 동작 (클로저, 기본값: {})
        - color: 버튼 텍스트 기본 색상 (Color, 기본값: .sGray)
        - highlightedColor: 버튼 하이라이트 상태의 텍스트 색상 (Color, 기본값: .sMain)
        - font: 버튼 텍스트의 폰트 (Font, 기본값: .pretendard(.regular, size: 14))
        - lineSpacing: 텍스트 행간 (CGFloat, 기본값: 0)
        - kerning: 텍스트 자간 (CGFloat, 기본값: 0)
        - underline: 텍스트 밑줄 여부 (Bool, 기본값: false)
 - Example:
     ```swift
     CustomTextButton(
         title: "텍스트 버튼",
         action: {
             print("텍스트 버튼 클릭")
         },
         color: .gray,
         highlightedColor: .blue,
         font: .pretendard(.bold, size: 16),
         lineSpacing: 2,
         kerning: -0.2,
         underline: true
     )
     ```
 */

struct CustomTextButton: View {
    let title: String
    var action: () -> Void = {}
    var color: Color = .sGray
    var highlightedColor: Color = .sMain
    var font: Font = .pretendard(.regular, size: 14)
    var lineSpacing: CGFloat = 0
    var kerning: CGFloat = 0
    var underline: Bool = false

    @State private var isHighlighted: Bool = false

    init(
        title: String,
        action: @escaping () -> Void = {},
        color: Color = .sGray,
        highlightedColor: Color = .sMain,
        font: Font = .pretendard(.regular, size: 14),
        lineSpacing: CGFloat = 0,
        kerning: CGFloat = 0,
        underline: Bool = false
    ) {
        self.title = title
        self.action = action
        self.color = color
        self.highlightedColor = highlightedColor
        self.font = font
        self.lineSpacing = lineSpacing
        self.kerning = kerning
        self.underline = underline
    }

    var body: some View {
        Button(action: action) {
            Text(title)
                .font(font)
                .foregroundColor(isHighlighted ? highlightedColor : color)
                .underline(
                    underline,
                    color: isHighlighted ? highlightedColor : color
                )
                .lineSpacing(lineSpacing)
                .kerning(kerning)
        }
        .simultaneousGesture(
            DragGesture(minimumDistance: 0)
                .onChanged { _ in isHighlighted = true }
                .onEnded { _ in isHighlighted = false }
        )
    }
}

#Preview {
    CustomTextButton( title: "텍스트 버튼", underline: true)
}
