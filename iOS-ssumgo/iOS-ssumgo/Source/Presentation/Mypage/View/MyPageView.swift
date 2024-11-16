//
//  MyPageView.swift
//  iOS-ssumgo
//
//  Created by 정민지 on 11/16/24.
//

import SwiftUI
import YDS_SwiftUI

enum MyPageType {
    case mentee
    case mentor
}

struct MyPageView: View {
    @State var myPageType: MyPageType
    @State var nickname: String = "정다운"
    @State var department: String = "글로벌미디어학부"
    @State var studentIdNumber: String = "23"
    @State var rating: String = "1.4"
    
    var body: some View {
        VStack(spacing: 0) {
            
            ScrollView {
                VStack(spacing: 32) {
                    VStack(spacing: 6) {
                        Image("img_Profile")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 70, height: 70)
                            .padding(2)
                        
                        Text("\(nickname)")
                            .font(.pretendard(.semiBold, size: 16))
                            .tracking(16 * (  -5/100))
                            .foregroundColor(.black)
                        
                        Text("\(department) \(studentIdNumber)학번")
                            .font(.pretendard(.regular, size: 12))
                            .tracking(16 * (  -3/100))
                            .foregroundColor(.gray)
                        
                        if myPageType == .mentor {
                            HStack {
                                Image("ic_star")
                                    .renderingMode(.template)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 10, height: 10)
                                    .foregroundStyle(.black)
                                
                                Text("\(rating)")
                                    .font(.pretendard(.regular, size: 12))
                                    .foregroundColor(.black)
                            }
                        }
                    }
                    

                    VStack {
                        YDSList(
                            hasSubHeader: true,
                            subHeaderText: "보관함",
                            items: [YDSListItem(text: "보관함 바로가기", icon: true)]
                        )
                        YDSList(
                            hasSubHeader: true,
                            subHeaderText: "고객센터",
                            items: [YDSListItem(text: "고객센터 바로가기", icon: true)]
                        )
                        
                        YDSList(
                            hasSubHeader: true,
                            subHeaderText: "가이드",
                            items: [YDSListItem(text: "공지사항", icon: true),
                                    YDSListItem(text: "숭실숨고 안내", icon: true),
                                    YDSListItem(text: "앱버전")]
                        )
                    }
                }
                .edgesIgnoringSafeArea(.bottom)
            }
        }
    }
}

#Preview {
    NavigationView {
        MyPageView(myPageType: .mentee)
    }
}
