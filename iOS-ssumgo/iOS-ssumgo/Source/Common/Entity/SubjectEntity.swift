//
//  Subject.swift
//  iOS-ssumgo
//
//  Created by 정민지 on 11/25/24.
//

struct SubjectEntity: Decodable {
    let subjectId: Int
    let subjectName: String
    let professorName: String
    let completion: String
    let subjectCode: Int
    let department: String
    let time: Int
    let credit: Int
}
