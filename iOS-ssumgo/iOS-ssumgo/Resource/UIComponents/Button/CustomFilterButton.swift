//
//  CustomFilterButton.swift
//  iOS-ssumgo
//
//  Created by 정민지 on 11/17/24.
//

import SwiftUI

struct CustomFilterButton: View {
    let title: String
    var isSelected: Bool = true
    var hasBorder: Bool = false
    var selectedBackgroundColor: Color = .sMain
    var defaultBackgroundColor: Color = .clear
    var textColor: Color = .white
    var action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack(spacing: 4) {
                Text(title)
                    .font(.pretendard(.regular, size: 14))
                    .foregroundColor(textColor)
                
                Image(systemName: "chevron.down")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 10, height: 10)
                    .foregroundColor(textColor)
            }
            .padding(.horizontal, 12)
            .padding(.vertical, 6)
            .background(isSelected ? selectedBackgroundColor : defaultBackgroundColor)
            .overlay(
                hasBorder ? RoundedRectangle(cornerRadius: 15)
                    .stroke(textColor, lineWidth: 1)
                : nil
            )
            .cornerRadius(16)
        }
    }
}

#Preview {
    VStack(spacing: 10) {
        CustomFilterButton(
            title: "과목",
            hasBorder: true,
            selectedBackgroundColor: .clear,
            textColor: .sGray2,
            action: { print("과목 버튼 클릭") }
        )
        
        CustomFilterButton(
            title: "인기순",
            selectedBackgroundColor: .clear,
            textColor: .sGray,
            action: { print("영역 버튼 클릭") }
        )
        
        CustomFilterButton(
            title: "영역",
            isSelected: false,
            defaultBackgroundColor: .sGray10P,
            textColor: .sGray3,
            action: { print("영역 버튼 클릭") }
        )
        
        CustomFilterButton(
            title: "학과",
            isSelected: true,
            selectedBackgroundColor: .sMain,
            textColor: .white,
            action: { print("학과 버튼 클릭") }
        )
    }
    .padding()
}
