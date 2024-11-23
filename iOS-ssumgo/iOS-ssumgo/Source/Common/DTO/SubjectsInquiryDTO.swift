//
//  SubjectsInquiryDTO.swift
//  iOS-ssumgo
//
//  Created by 서준영 on 11/23/24.
//

struct SubjectInquiryDTO: Decodable {
    let subjectId: Int
    let subjectName: String
    let professorName: String
    let completion: String
    let subjectCode: Int
    let department: String
    let time: Int
    let credit: Int
}
