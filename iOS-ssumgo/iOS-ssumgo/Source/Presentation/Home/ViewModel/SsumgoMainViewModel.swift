//
//  SsumgoMainViewModel.swift
//  iOS-ssumgo
//
//  Created by 서준영 on 11/22/24.
//

import SwiftUI
import Combine

final class SsumgoMainViewModel: ObservableObject {
    @Published var nickname: String = "Unknown"
    @Published var department: String = "Department"
    @Published var subjectName1: String = "No Data"
    @Published var subjectName2: String = "No Data"
    @Published var subjectName3: String = "No Data"
    @Published var isLoading: Bool = false
    @Published var errorMessage: String? = nil
    
    private var cancellables = Set<AnyCancellable>()
    private let myPageDAO = MyPageDAO()
    private let subjectsInquiryDAO = SubjectsInquiryDAO()
    
    func fetchMainData() {
        isLoading = true
        errorMessage = nil
        
        myPageDAO.fetchProfile()
            .sink(receiveCompletion: { [weak self] completion in
                guard let self = self else { return }
                self.isLoading = false
                switch completion {
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                case .finished:
                    break
                }
            }, receiveValue: { [weak self] profile in
                self?.nickname = profile.nickname
                self?.department = profile.department
            })
            .store(in: &cancellables)
        
        subjectsInquiryDAO.fetchSubjects()
            .sink(receiveCompletion: { [weak self] completion in
                guard let self = self else { return }
                self.isLoading = false
                switch completion {
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                case .finished:
                    break
                }
            }, receiveValue: { [weak self] subject in
                self?.subjectName1 = subject.subjectList.count > 0 ? subject.subjectList[0].subjectName : "No Data"
                self?.subjectName2 = subject.subjectList.count > 1 ? subject.subjectList[1].subjectName : "No Data"
                self?.subjectName3 = subject.subjectList.count > 2 ? subject.subjectList[2].subjectName : "No Data"
            })
            .store(in: &cancellables)
    }
}
