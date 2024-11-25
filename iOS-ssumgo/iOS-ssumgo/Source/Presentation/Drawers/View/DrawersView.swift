//
//  DrawersView.swift
//  iOS-ssumgo
//
//  Created by 정민지 on 11/25/24.
//

import SwiftUI

struct DrawersView: View {
    var body: some View {
        VStack {
            Image("img_ssumg_logo")
                .resizable()
                .scaledToFit()
        }
        .navigationBarHidden(true)
    }
}

#Preview {
    DrawersView()
}
