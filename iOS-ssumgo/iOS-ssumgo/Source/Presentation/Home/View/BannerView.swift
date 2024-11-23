//
//  BannerView.swift
//  iOS-ssumgo
//
//  Created by 서준영 on 11/16/24.
//

import SwiftUI

struct BannerView: View {
    
    @State private var currentIndex = 0
    private let banners = ["Banner1", "Banner2", "Banner3"]
    private let timer = Timer.publish(every: 8, on: .main, in: .common).autoconnect()
    
    var body: some View {
        Button(action: {
            print("배너 클릭됨")
        }) {
            TabView(selection: $currentIndex) {
                ForEach(banners.indices, id: \.self) { index in
                    Image(banners[index])
                        .resizable()
                        .frame(width: Constants.rectWidth, height: 72)
                        .padding(.horizontal, 27)
                }
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
            .onReceive(timer) { _ in
                withAnimation {
                    currentIndex = (currentIndex + 1) % banners.count
                }
            }
            .padding(.top, 24.34)
        }
    }
}

#Preview {
    BannerView()
}
