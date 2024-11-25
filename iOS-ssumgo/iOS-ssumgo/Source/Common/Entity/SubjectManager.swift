//
//  SubjectManager.swift
//  iOS-ssumgo
//
//  Created by 정민지 on 11/25/24.
//

import Foundation

final class SubjectManager {
    static let shared = SubjectManager()
    
    @Published var subjectName1: String = "프로그래밍2및실습"
    @Published var subjectName2: String = "미디어제작및실습"
    @Published var subjectName3: String = "컴퓨터시스템개론"
    
    @Published var subjectId1: Int = 0
    @Published var subjectId2: Int = 0
    @Published var subjectId3: Int = 0
    
    private init() {}
    
    /*
     해당 수강과목과 제목이 일치하는 response의 subjectId를 받아오기 위해 사용합니다.
     */
    func updateSubjectData(subjectList: [SubjectEntity]) {
        subjectId1 = subjectList.first(where: { $0.subjectName == subjectName1 })?.subjectId ?? 0
        subjectId2 = subjectList.first(where: { $0.subjectName == subjectName2 })?.subjectId ?? 0
        subjectId3 = subjectList.first(where: { $0.subjectName == subjectName3 })?.subjectId ?? 0
    }
    
    /*
     수강과목이 다 있는지 확인이 필요할때 사용합니다
     - 세개의 과목이 모두 id가 0이 아닐때 true를 반환합니다.
     */
    func areAllSubjectsValid() -> Bool {
        return subjectId1 != 0 && subjectId2 != 0 && subjectId3 != 0
    }
}
