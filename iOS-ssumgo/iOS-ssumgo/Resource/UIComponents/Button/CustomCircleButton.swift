//
//  CustomCircleButton.swift
//  iOS-ssumgo
//
//  Created by 정민지 on 11/24/24.
//

import SwiftUI

struct CustomCircleButton: View {
    let isActive: Bool
    let size: CGFloat
    let iconImage: String
    let iconSize: CGFloat
    let action: () -> Void
    
    init(
        isActive: Bool,
        size: CGFloat = 50,
        iconImage: String = "ic_comment",
        iconSize: CGFloat = 30,
        action: @escaping () -> Void
    ) {
        self.isActive = isActive
        self.size = size
        self.iconImage = iconImage
        self.iconSize = iconSize
        self.action = action
    }
    
    var body: some View {
        Button(action: action) {
            ZStack {
                Circle()
                    .fill(isActive ? .sMain : .sGrayButton)
                    .frame(width: size, height: size)
                
                Image(iconImage)
                    .resizable()
                    .scaledToFit()
                    .frame(width: iconSize, height: iconSize)
                    .foregroundColor(.white)
            }
        }
        .buttonStyle(PlainButtonStyle())
    }
}


#Preview {
    CustomCircleButton(isActive: true) {
        print("Button tapped")
    }
    CustomCircleButton(isActive: false) {
        print("Button tapped")
    }
    CustomCircleButton(
        isActive: true,
        iconImage: "ic_send",
        iconSize: 23
    ) {
        print("Button tapped")
    }
    CustomCircleButton(
        isActive: false,
        iconImage: "ic_send",
        iconSize: 23
    ) {
        print("Button tapped")
    }
}
