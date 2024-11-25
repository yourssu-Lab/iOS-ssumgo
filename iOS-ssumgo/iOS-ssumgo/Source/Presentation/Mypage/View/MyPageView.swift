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
    @EnvironmentObject var navigationManager: NavigationManager
    @StateObject private var viewModel = MyPageViewModel()
    @State var myPageType: MyPageType
    @State var appVersion: String = "1.0.0"
    
    var body: some View {
        ScrollView {
            VStack(spacing: 32) {
                if viewModel.isLoading {
                    ProgressView("로딩 중...")
                } else {
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
                                    .cornerRadius(35)
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
                }
                
                VStack {
                    YDSList(
                        hasSubHeader: true,
                        subHeaderText: "보관함",
                        items: [YDSListItem(text: "보관함 바로가기", icon: true)]
                    )
                    .overlay(
                        VStack {
                            Spacer()
                            HStack {
                                Spacer()
                                Text("")
                                    .padding(20)
                            }
                            .frame(height: 48)
                            .contentShape(Rectangle())
                            .onTapGesture {
                                navigationManager.append(.drawersView)
                            }
                        }
                    )
                    
                    YDSList(
                        hasSubHeader: true,
                        subHeaderText: "고객센터",
                        items: [YDSListItem(text: "고객센터 바로가기", icon: true)]
                    )
                    
                    YDSList(
                        hasSubHeader: true,
                        subHeaderText: "가이드",
                        items: [
                            YDSListItem(text: "이용약관", icon: true),
                            YDSListItem(text: "숭실숨고 안내", icon: true),
                            YDSListItem(text: "앱버전")
                        ]
                    )
                    .overlay(
                        VStack {
                            Spacer()
                            HStack {
                                Spacer()
                                Text("")
                                    .padding(20)
                                
                            }
                            .frame(height: 48)
                            .contentShape(Rectangle())
                            .onTapGesture {
                                navigationManager.append(.termsOfServiceView)
                            }
                            
                            HStack {
                                Spacer()
                                Text("")
                                    .padding(20)
                            }
                            .frame(height: 48)
                            .contentShape(Rectangle())
                            
                            HStack {
                                Spacer()
                                Text("\(appVersion)")
                                    .font(.pretendard(.regular, size: 12))
                                    .foregroundColor(.black)
                                    .padding(20)
                            }
                            .frame(height: 48)
                            .contentShape(Rectangle())
                        }
                    )
                    
                }
                HStack(alignment: .center) {
                    YDSPlainButton(
                        text: "로그아웃",
                        action: {
                            viewModel.logout()
                            navigationManager.setRoot(.splashView)
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
                .edgesIgnoringSafeArea(.bottom)
            }
        }
        .onAppear {
            viewModel.fetchMyPageData()
        }
        .navigationBarHidden(true)
    }
}

#Preview {
    @Previewable @StateObject var navigationManager = NavigationManager()
    
    NavigationStack(path: $navigationManager.path) {
        MyPageView(myPageType: .mentee)
            .environmentObject(navigationManager)
    }
}
