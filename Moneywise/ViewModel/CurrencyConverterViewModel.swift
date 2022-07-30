//
//  CurrencyConverterViewModel.swift
//  Moneywise
//
//  Created by Carmen Chiu on 7/15/22.
//

import SwiftUI

class CurrencyData {
//    static let baseURL = URL(string: "http://www.floatrates.com/daily/usd.json")
            @Published  var code: String
            @Published var name: String
            @Published var rate: Double
    
    init(currencyName: String){
        self.code = ""
        self.name = ""
        self.rate = 1.00

        let semaphore = DispatchSemaphore(value: 0)
        //this is happening in a different thread. asking it to wait to run code, name, rate until after the semaphore signal
        CurrencyData.fetchCurrencyConversion(){
            currency in
            switch currency {
            case .success:
                do {
                    let currencyInfos = try currency.get()
                    let currencyInfo = currencyInfos[currencyName]
                    self.code = currencyInfo?.code ?? "USD"
                    self.name = currencyInfo?.name ?? "USD"
                    self.rate = currencyInfo?.rate ?? 0.0
                    print(currency)
                    semaphore.signal()
                    
                } catch {
                    print("Error getting currency")
                }
            case .failure:
                print("No conversion available")
            }
        }
        semaphore.wait()
        
    }
    
    static func fetchCurrencyConversion(completion: @escaping (Result<[String: CurrencyInfo], CurrencyConversionError>) -> Void) {
        //URL
        guard let baseURL: URL = URL(string: "https://www.floatrates.com/daily/") else {
            return completion(.failure(.invalidURL))
        }
        
        let finalURL = baseURL.appendingPathComponent("usd.json")
        
        //Data task
        URLSession.shared.dataTask(with: finalURL) { data, response, error in
             //Error handling
            if let error = error {
                return completion(.failure(.thrownError(error)))
            }
            
            //guard check for data
            guard let data = data else {
                return completion(.failure(.noData))
                
            }
            let dataString = String(data: data, encoding: .utf8)
            //decode
            do {
                let currency = try JSONDecoder().decode([String:CurrencyInfo].self, from: data)
                completion(.success(currency))
            } catch {
                print(error)
                return completion(.failure(.unableToDecode))
            }
        }.resume()
    }
}
