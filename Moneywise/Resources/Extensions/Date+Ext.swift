//
//  File.swift
//  Moneywise
//
//  Created by Carmen Chiu on 7/13/22.
//

import Foundation


func string(from date: Date) -> String {
        let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "MM/DD/YY"
    return dateFormatter.string(from: date)
}

extension DateFormatter {
    static let allNumericUSA: DateFormatter = {
        print("Initializing DateFormatter")
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/dd/yyyy"
        return formatter
    }()
}

extension String {
    func dateParsed() -> Date {
        guard let parsedDate = DateFormatter.allNumericUSA.date(from: self) else { return Date() }
        return parsedDate
    }
}
