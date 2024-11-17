//
//  CustomStarButton.swift
//  iOS-ssumgo
//
//  Created by 정민지 on 11/17/24.
//

import SwiftUI

// TODO: - isFilled일때 디자인 필요

struct CustomStarButton: View {
    @State private var isFilled: Bool = false
    var size: CGFloat = 10
    var action: (() -> Void)? = nil

    var body: some View {
        Button(action: {
            isFilled.toggle()
            action?()
        }) {
            Image("ic_star")
                .renderingMode(.template)
                .resizable()
                .scaledToFit()
                .frame(width: size, height: size)
                .foregroundStyle(isFilled ? .red : .sGray3)
        }
    }
}

#Preview {
    CustomStarButton(size: 50)
}
