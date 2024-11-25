//
//  NoSubjectView.swift
//  iOS-ssumgo
//
//  Created by 정민지 on 11/25/24.
//

import SwiftUI
import YDS_SwiftUI

struct NoSubjectView: View {
    @ObservedObject var viewModel: SsumgoMainViewModel
    
    var body: some View {
        VStack(spacing: 0) {
            VStack(spacing: 0) {
                YDSLabel(
                    text: "수강중인 과목이 없습니다.",
                    font: .pretendard(.semiBold, size: 15),
                    textColor: YDSColor.textSecondary
                )
                .padding(.bottom, 20)
                
                YDSLabel(
                    text: "* 현재 지원하는 과목은 아래와 같습니다. \n - 프로그래밍2및실습, 미디어제작및실습, 컴퓨터시스템개론 \n\n버튼을 누르면 수강과목으로 자동 조회, 등록됩니다.",
                    font: .pretendard(.light, size: 12),
                    textColor: YDSColor.textSecondary,
                    alignment: .leading
                )
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.bottom, 20)
                
                if viewModel.isLoading {
                    ProgressView()
                        .frame(maxWidth: .infinity, alignment: .center)
                } else {
                    CustomBoxButton(
                        title: "수강과목 조회하기",
                        action: {
                            viewModel.registerAllSubjects()
                        },
                        font: .pretendard(.semiBold, size: 12),
                        cornerRadius: 8,
                        kerning: (16 * (-0.4 / 100))
                    )
                    .frame(maxWidth: .infinity, alignment: .leading)
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
        }
        .padding(.horizontal, 9)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

#Preview {
    NoSubjectView(viewModel: SsumgoMainViewModel())
}
