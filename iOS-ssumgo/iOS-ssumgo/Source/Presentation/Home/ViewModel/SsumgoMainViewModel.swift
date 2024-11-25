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
    @Published var subjects: [SubjectEntity] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String? = nil
    
    private var cancellables = Set<AnyCancellable>()
    private let myPageDAO = MyPageDAO()
    private let subjectsInquiryDAO = SubjectsInquiryDAO()
    private let subjectsRegistrationDAO = SubjectsRegistrationDAO()
    
    private let subjectManager = SubjectManager.shared
    
    // MARK: - 유저 정보 조회, 수강과목 조회 API
    
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
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    print("Error: \(error.localizedDescription)")
                case .finished:
                    break
                }
            }, receiveValue: { subjectList in
                self.subjects = subjectList
                SubjectManager.shared.updateSubjectData(subjectList: subjectList)
            })
            .store(in: &cancellables)
    }
    
    // MARK: - 수강과목 등록 API
    
    func registerAllSubjects() {
        isLoading = true
        errorMessage = nil
        
        let subjectIds = [4, 5, 6]
        let years = 2024
        let semester = 2
        
        let registrationPublishers = subjectIds.map { subjectId in
            subjectsRegistrationDAO.registerSubject(
                subject: SubjectsRegistrationDTO(subjectId: subjectId, years: years, semester: semester)
            )
        }
        
        Publishers.MergeMany(registrationPublishers)
            .collect()
            .sink(receiveCompletion: { [weak self] completion in
                guard let self = self else { return }
                self.isLoading = false
                switch completion {
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                case .finished:
                    break
                }
            }, receiveValue: { [weak self] _ in
                guard let self = self else { return }
                self.fetchMainData()
            })
            .store(in: &cancellables)
    }
}
