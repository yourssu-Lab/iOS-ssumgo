//
//  UIFont+.swift
//  iOS-ssumgo
//
//  Created by 정민지 on 11/16/24.
//

import SwiftUI

// MARK: - Pretendard Font Extension

extension Font {
    enum PretendardType: String {
        case black = "Black"
        case extraBold = "ExtraBold"
        case bold = "Bold"
        case semiBold = "SemiBold"
        case medium = "Medium"
        case regular = "Regular"
        case light = "Light"
        case extraLight = "ExtraLight"
        case thin = "Thin"
    }

    enum PretendardWeight: Int {
        case weight900 = 900
        case weight800 = 800
        case weight700 = 700
        case weight600 = 600
        case weight500 = 500
        case weight400 = 400
        case weight300 = 300
        case weight200 = 200
        case weight100 = 100
    }
    
    /*
     - PretendardType에 따른 폰트 생성
     - Parameters:
            - type: 폰트 스타일 (PretendardType)
            - size: 폰트 크기 (CGFloat)
     - Example:
          ```swift
          let font = Font.pretendard(.bold, size: 16)
          ```
    */

    static func pretendard(_ type: PretendardType, size: CGFloat) -> Font {
        return Font.custom("Pretendard-" + type.rawValue, size: size)
    }
    
    /*
     - PretendardWeight(가중치)에 따른 폰트 생성
     - Parameters:
            - weight: 폰트 가중치 (PretendardWeight)
            - size: 폰트 크기 (CGFloat)
     - Example:
         ```swift
         let font = Font.pretendard(.weight700, size: 14)
         ```
    */

    static func pretendard(_ weight: PretendardWeight, size: CGFloat) -> Font {
        switch weight {
        case .weight900:
            return pretendard(.black, size: size)
        case .weight800:
            return pretendard(.extraBold, size: size)
        case .weight700:
            return pretendard(.bold, size: size)
        case .weight600:
            return pretendard(.semiBold, size: size)
        case .weight500:
            return pretendard(.medium, size: size)
        case .weight400:
            return pretendard(.regular, size: size)
        case .weight300:
            return pretendard(.light, size: size)
        case .weight200:
            return pretendard(.extraLight, size: size)
        case .weight100:
            return pretendard(.thin, size: size)
        }
    }
}
