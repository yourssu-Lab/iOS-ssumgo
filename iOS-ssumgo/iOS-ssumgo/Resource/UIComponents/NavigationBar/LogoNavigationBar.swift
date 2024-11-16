//
//  LogoNavigationBar.swift
//  iOS-ssumgo
//
//  Created by 정민지 on 11/17/24.
//

import SwiftUI

/*
 - LogoNavigationBar: 로고와 알림 버튼을 포함한 네비게이션 바 컴포넌트
 - Parameters:
        - logoImage: 네비게이션 바에 표시될 로고 이미지 (Image, 기본값: Image("img_logo_ssumg"))
        - alarm: 알림 버튼 표시 여부 (Bool, 기본값: false)
        - alarmAction: 알림 버튼 클릭 시 실행할 동작 (클로저, 기본값: nil)
 - Example:
     - 아래 Preview 참고
 - Description:
     LogoNavigationBar는 상단에 로고와 선택적으로 알림 버튼을 표시합니다.
     알림 버튼이 활성화되어 있는 경우, `alarmAction` 클로저를 통해 클릭 이벤트를 처리할 수 있습니다.
 */


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
