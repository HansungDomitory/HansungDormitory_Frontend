//
//  LeaveRequest.swift
//  HansungDormitory
//
//  Created by JangSoohee on 7/23/24.
//

import Foundation

struct LeaveRequest: Identifiable, Codable {
    let id: Int
    let startDate: String
    let endDate: String
    let daysOut: Int
    let registrationDate: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case startDate = "start_date"
        case endDate = "end_date"
        case daysOut = "duration"
        case registrationDate = "create_at"
    }
}
