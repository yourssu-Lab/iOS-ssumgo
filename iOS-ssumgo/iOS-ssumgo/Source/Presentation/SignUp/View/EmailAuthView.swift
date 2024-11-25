//
//  EmailAuthView.swift
//  iOS-ssumgo
//
//  Created by 정민지 on 11/22/24.
//

import SwiftUI
import YDS_SwiftUI

struct EmailAuthView: View {
    @EnvironmentObject var navigationManager: NavigationManager
    @StateObject private var viewModel: EmailAuthViewModel
    
    init(email: String) {
        _viewModel = StateObject(wrappedValue: EmailAuthViewModel(email: email))
    }
    
    var body: some View {
        BackNavigationBar(
            rightIcon: false,
            title: "",
            onLeftIconTap: {
                navigationManager.pop()
            }
        )
        
        Spacer()
        
        VStack(spacing: 0) {
            Image("img_soomsilV2FullLogo")
                .resizable()
                .scaledToFit()
                .frame(height: 30)
                .padding(.bottom, 20)
            
            VStack(spacing: 0) {
                YDSLabel(
                    text: "회원가입",
                    font: .pretendard(.semiBold, size: 18.6)
                )
                .padding(.bottom, 35)
                
                YDSLabel(
                    text: "입력한 메일로\n인증 메일이 발송되었습니다.",
                    font: .pretendard(.semiBold, size: 15),
                    textColor: YDSColor.textSecondary,
                    alignment: .leading
                )
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.bottom, 27)
                
                YDSLabel(
                    text: "메일 내에 있는 인증 버튼을 클릭해주세요.",
                    font: .pretendard(.semiBold, size: 15),
                    textColor: YDSColor.textSecondary,
                    alignment: .leading
                )
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.bottom, 13)
                
                YDSSuffixTextField(
                    placeholder: "이메일을 입력해주세요",
                    text: .constant(viewModel.email),
                    isDisabled: true
                )
                .overlay(
                    HStack {
                        Spacer()
                        Text(viewModel.timerText)
                            .font(.pretendard(.medium, size: 16))
                            .kerning(-0.24)
                            .foregroundColor(.sGray2)
                            .padding(.trailing, 16)
                    }
                )
                .frame(height: 36)
                .padding(.bottom, 20)
                
                CustomBoxButton(
                    title: "다음",
                    action: {
                        viewModel.checkEmailVerification { isVerified in
                            if isVerified {
                                DispatchQueue.main.async {
                                    navigationManager.append(.signUpFormView(email: viewModel.email))
                                }
                            } else {
                                DispatchQueue.main.async {
                                    YDSToast("이메일을 확인해주세요.", duration: .short, haptic: .failed)
                                }
                            }
                        }
                    },
                    backgroundColor: viewModel.canProceed ? YDSColor.buttonPoint : YDSColor.buttonDisabledBG,
                    font: .pretendard(.semiBold, size: 12),
                    cornerRadius: 8
                )
                .disabled(!viewModel.canProceed)
                .padding(.bottom, 10)
                
                HStack(alignment: .center) {
                    YDSPlainButton(
                        text: "인증 메일 재전송",
                        action: {
                            viewModel.resendEmail()
                        }
                    )
                    
                    Text("|")
                        .font(.pretendard(.semiBold, size: 12))
                        .foregroundColor(.gray)
                    
                    YDSPlainButton(
                        text: "학교 메일 열기",
                        action: {
                            
                            if let url = URL(string: "https://adfs.ssu.ac.kr/adfs/ls/?client-request-id=e08886ea-0612-ee9b-fa24-8daee3b8c870&username=&wa=wsignin1.0&wtrealm=urn%3afederation%3aMicrosoftOnline&wctx=estsredirect%3d2%26estsrequest%3drQQIARAA02I21DO0UjGAACNdEKlrkJZmqJucCmIhgSIhLoFXbR0PhNhmv_ul0rvu8Y4TBbMY-Yrz8_PSizNz9BKT9bKLVjHKZ5SUFBRb6evnl5bk5Odn6-WnpWUmp-ol5-fq55cn6u9gZLzAyPiCkXEVk7mZsYWZuYWFmYWZsYGxpYWRpYWekUFKimWqubGuYRLQfpPEZEvdRAPTVF0jy9REC9NkU4skI8NbTPz-jqUlGUYgIr8osyr1ExNnWn5RbnxBfnHJLOYSl-QyH5dIx3RXR6cgAyfvYkfDDMdIn9Rk0yC_LD8vH8_ytKQcC_9Io9D0zIqQ4uLsyNDEbDMX19wKz6yg9MoUgwy_AqeilODgsKpIl0IvAx_vyKTAHO8Ad3fXIkdz78pkc6MkswqjJIP4jKqsMpfQiDQgcxUzUaG4iZkNGBK5-XmnmNnyC1LzMlMusDA-YGF8xcJjwGrFwcElwC_BrsDwg4VxESswwBPWbmMV9G_233Z8K1vIbUOGU6z6oaVJZa4e6c5G-l4pPkFeZUFpqS6VIWH6ThUmue7-_ulm4YnJBoHeyT6u2bbmVoYT2BgnsLHtYuPkYBZgUGJ2DjB8wcb4gY2xg51hFyehyLrAzXiLx4SLLTknMTO3WEirWikzJb4kPzs1T8mqWqkitzg-ORnEKkvMKU0tVrKKVgKarxRbW1t7gJfhB9_7pW2TDz489M5jgwDDAwEGAA2#") {
                                UIApplication.shared.open(url)
                            }
                        }
                    )
                }
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, 18)
            .padding(.horizontal, 20)
            .overlay(
                RoundedRectangle(cornerRadius: 14)
                    .stroke(Color.gray.opacity(0.3), lineWidth: 1)
            )
            .cornerRadius(14)
            
            Spacer()
        }
        .padding(.horizontal, 9)
        .navigationBarHidden(true)
        .onChange(of: viewModel.errorMessage) {
            if let message = viewModel.errorMessage {
                YDSToast(message, duration: .short, haptic: .failed)
                viewModel.errorMessage = nil
            }
        }
        .registerYDSToast()
    }
}


#Preview {
    @Previewable @StateObject var navigationManager = NavigationManager()
    
    NavigationStack(path: $navigationManager.path) {
        EmailAuthView(email: "@soongsil.ac.kr")
            .environmentObject(navigationManager)
    }
}
