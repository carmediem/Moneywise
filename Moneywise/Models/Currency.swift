//
//  Currency.swift
//  Moneywise
//
//  Created by Carmen Chiu on 7/16/22.
//

import Foundation

struct CurrencyInfo: Codable {
    let code: String
    let name: String
    var rate: Double
}

struct Currencies: Codable {
    let results: [String:CurrencyInfo]
}
