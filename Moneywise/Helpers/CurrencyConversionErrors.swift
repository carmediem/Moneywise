//
//  CurrencyConversionErrors.swift
//  Moneywise
//
//  Created by Carmen Chiu on 7/16/22.
//

import Foundation
import UIKit


enum CurrencyConversionError: LocalizedError {
    
    case invalidURL
    case thrownError(Error)
    case noData
    case unableToDecode
    case badResponse
    
    var errorDescription: String {
        switch self {
        case .invalidURL:
            return "The server failed to reach the necessary URL."
        case .thrownError(let error):
            return "Opps, there was an error: \(error.localizedDescription)"
        case .noData:
            return "The server failed to load any data."
        case .unableToDecode:
            return "There was an error when trying to load the data."
        case .badResponse:
            return "Bad response from API"

        }
    }
}

