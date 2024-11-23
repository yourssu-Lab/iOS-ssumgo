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
    @StateObject private var viewModel = MyPageViewModel()
    @State var myPageType: MyPageType
    @State var appVersion: String = "1.0.0"
    
    @Environment(\.dismiss) private var dismiss
    @State private var shouldNavigateToSplash = false
    
    var body: some View {
        VStack(spacing: 0) {
            if viewModel.isLoading {
                ProgressView("로딩 중...")
            } else {
                ScrollView {
                    VStack(spacing: 32) {
                        VStack(spacing: 6) {
                            if viewModel.profileImageUrl.isEmpty {
                                Image("img_Profile")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 70, height: 70)
                                    .cornerRadius(35)
                                    .padding(2)
                            } else {
                                AsyncImage(url: URL(string: viewModel.profileImageUrl)) { image in
                                    image.resizable()
                                        .scaledToFit()
                                        .frame(width: 70, height: 70)
                                        .padding(2)
                                } placeholder: {
                                    ProgressView()
                                }
                            }
                            
                            Text(viewModel.nickname)
                                .font(.pretendard(.semiBold, size: 16))
                                .tracking(16 * (  -5/100))
                                .foregroundColor(.black)
                            
                            Text("\(viewModel.department) \(viewModel.studentIdNumber)학번")
                                .font(.pretendard(.regular, size: 12))
                                .tracking(16 * (  -3/100))
                                .foregroundColor(.gray)
                            
                            if myPageType == .mentor, let rating = viewModel.rating {
                                HStack {
                                    Image("ic_star")
                                        .renderingMode(.template)
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 10, height: 10)
                                        .foregroundStyle(.black)
                                    
                                    Text(rating)
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
                                        YDSListItem(text: "앱버전")
                                       ]
                            )
                            .background(.red)
                            .overlay(
                                VStack {
                                    Spacer()
                                    HStack {
                                        Spacer()
                                        Text("\(appVersion)")
                                            .font(.pretendard(.regular, size: 12))
                                            .foregroundColor(.black)
                                            .padding(.trailing, 30)
                                            .padding(.bottom, 16)
                                    }
                                }
                        )
                        }
                        HStack(alignment: .center) {
                            YDSPlainButton(
                                text: "로그아웃",
                                action: {
                                    viewModel.logout()
                                    shouldNavigateToSplash = true
                                }
                            )
                            
                            Text("|")
                                .font(.pretendard(.semiBold, size: 12))
                                .foregroundColor(.gray)
                            
                            YDSPlainButton(
                                text: "탈퇴하기",
                                action: {
                                    print("탈퇴하기")
                                    
                                }
                            )
                        }
 
                    }
                    .edgesIgnoringSafeArea(.bottom)
                }
            }
        }
        .onAppear {
            viewModel.fetchMyPageData()
        }
        .navigationDestination(isPresented: $shouldNavigateToSplash) {
            SplashView()
        }
    }
}

#Preview {
    NavigationView {
        MyPageView(myPageType: .mentee)
    }
}
