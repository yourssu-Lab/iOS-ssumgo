//
//  BannerView.swift
//  iOS-ssumgo
//
//  Created by 서준영 on 11/16/24.
//

import SwiftUI

struct BannerView: View {
    
    /// 배너
    @State var bannerTile: String = "글미가 글미가 아니라고??!"
    @State var bannerContent: String = "저희는 이제 <디자인 소프트웨어학부> 입니다."
    @State var pageNum: Int = 1
    @State var pageTotalNum: Int = 3
    
    private let rectWidth: CGFloat = 339
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 14)
                .frame(width: rectWidth, height: 64)
                .foregroundStyle(Color("banner_green"))
            
            VStack(spacing: 0) {
                Text("\(bannerTile)")
                    .font(.pretendard(.medium, size: 13))
                    .foregroundStyle(.black)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.leading, 13)
                    .padding(.top, 12)
                
                Text("\(bannerContent)")
                    .font(.pretendard(.bold, size: 15))
                    .foregroundStyle(.black)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.leading, 13)
                    .padding(.top, 4)
                
                Spacer()
            }
            .frame(width: rectWidth, height: 64)
            .padding(.horizontal, 27)
            
            HStack(spacing: 0) {
                Text("\(pageNum)/\(pageTotalNum)")
                    .font(.pretendard(.medium, size: 11))
                    .frame(maxWidth: .infinity, alignment: .trailing)
                    .padding(.trailing, 12)
                    .padding(.top, 45)
            }
            .frame(width: rectWidth, height: 64)
        }
        .padding(.top, 24.34)
        
    }
}
