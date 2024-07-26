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
    let detail: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case startDate = "start_date"
        case endDate = "end_date"
        case daysOut = "duration"
        case registrationDate = "create_at"
        case detail
    }
    
    func formattedRegistrationDate() -> String {
            let dateFormatter = DateFormatter()
            dateFormatter.locale = Locale(identifier: "en_US_POSIX")
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
            if let date = dateFormatter.date(from: registrationDate) {
                dateFormatter.dateFormat = "yyyy-MM-dd"
                return dateFormatter.string(from: date)
            }
            return registrationDate
        }
}

