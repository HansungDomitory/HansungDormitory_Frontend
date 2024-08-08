//
//  ScoreRecord.swift
//  HansungDormitory
//
//  Created by JangSoohee on 7/30/24.
//

import Foundation

struct ScoreRecord: Decodable {
    let id: Int
    let student: Student
    let isMerit: Bool
    let score: Int
    let detail: String
    let createAt: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case student
        case isMerit = "is_merit"
        case score
        case detail
        case createAt = "create_at"
    }
    
    var meritScore: Int {
        return isMerit ? score : 0
    }
    
    var demeritScore: Int {
        return !isMerit ? score : 0
    }
    
    func formattedCreateAt() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        if let date = dateFormatter.date(from: createAt) {
            dateFormatter.dateFormat = "yyyy-MM-dd"
            return dateFormatter.string(from: date)
        }
        return createAt
    }
    
    struct Student: Decodable {
        let id: String
        let name: String
        let password: String
        let meritScore: Int
        let demeritScore: Int
        let room: String
        let createAt: String
        
        enum CodingKeys: String, CodingKey {
            case id
            case name
            case password
            case meritScore = "merit_score"
            case demeritScore = "demerit_score"
            case room
            case createAt = "create_at"
        }
    }
}
