//
//  LogoNavigationBar.swift
//  iOS-ssumgo
//
//  Created by 정민지 on 11/17/24.
//

import SwiftUI

struct LogoNavigationBar: View {
    var logoImage = Image("img_logo_ssumg")
    var alarm: Bool = false
    var alarmAction: (() -> Void)? = nil

    var body: some View {
        VStack(spacing: 0) {
            HStack {
                logoImage
                    .resizable()
                    .scaledToFit()
                    .frame(height: 23)

                Spacer()
                
                if alarm {
                    Button(action: {
                        alarmAction?()
                    }) {
                        Image("ic_bell")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 48, height: 48)
                    }
                }
            }
            .frame(height: 48)
            .padding(.horizontal, 26)
            .padding(.vertical, 8.5)

            Rectangle()
                .fill(Color.gray.opacity(0.3))
                .frame(height: 1)
        }
    }
}

#Preview {
    LogoNavigationBar()
    LogoNavigationBar(alarm: true)
}
