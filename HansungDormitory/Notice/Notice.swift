//
//  Notice.swift
//  HansungDormitory
//
//  Created by JangSoohee on 8/5/24.
//

import Foundation

struct Notice: Identifiable, Codable, Hashable {
    let id: Int
    let title: String
    let detail: String
    let date: String
    
    var department: String {
        return "행정실"
    }

    enum CodingKeys: String, CodingKey {
        case id, title, detail
        case date = "create_at"
    }
    func formattedDate() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        if let date = dateFormatter.date(from: date) {
            dateFormatter.dateFormat = "yyyy-MM-dd"
            return dateFormatter.string(from: date)
        }
        return date
    }

}
