//
//  CurrencyConverter.swift
//  Moneywise
//
//  Created by Carmen Chiu on 7/15/22.
//

import SwiftUI

struct CurrencyConverterView: View {
    
    // Things to do
    // 1. Remove the "from" currency selector from the UI, always be from USD.
    // 3. move this loading function which grabs the values of the currencies and stuff to happen when the application launches, rather than here on every select / tap. Store in local storage
    @State private var fromCurrency = 146
    @State private var toCurrency = 48
    @State private var amount: String = ""
    private let currencies = ["AED", "AFN", "ALL", "AMD", "ANG", "AOA", "ARS", "AUD", "AWG", "AZN", "BAM", "BBD", "BDT", "BGN", "BHD", "BIF", "BMD", "BND", "BIF","BOB", "BOV", "BRL", "BSD", "BTN", "BWP", "BYN", "BZD", "CAD", "CHE", "CHF", "CHW", "CLF", "CLP", "CNY", "COP", "COU", "CRC", "CUC", "CUP", "CVE", "CZK", "DJF", "DKK", "DOP", "DZD", "EFP", "ERN", "ETB", "EUR", "FJD", "FKP", "GBP", "GEL", "GHS", "GIP", "GMD", "GNF", "GTQ", "GYD", "HKD", "HNL", "HRK", "HTG", "HUF","IDR", "ILS", "INR", "IQD", "IRR", "ISK", "JMD", "JOD", "JPY", "KES", "KGS", "KHR", "KMF", "KPW", "KRW", "KWD", "KYD", "KZT", "LAK", "LBR", "LRD", "LSL", "LYD", "MAD", "MDL", "MGA", "MKD", "MMK", "MNT", "MOP", "MRU", "MUR", "MVR", "MWK", "MXN", "MXV", "MXR", "MZN", "NAD", "NIO", "NOK","NPR", "NZD", "OMR", "PAB", "PEN", "PGK", "PHP", "PKR", "PLN", "PYG", "QAR", "RON", "RSD", "RUB", "RWF", "SAR", "SBD", "SCR", "SDG", "SEK", "SCD", "SHP", "SLL", "SOS", "SRD", "SSP", "STN", "SVC", "SVP", "SZL", "THB", "TJS", "TMT", "TND", "TOP", "TRY", "TTD", "TWD", "TZS", "UAH", "UGX", "USD", "USN", "UYI", "UYU", "UZS", "VED", "VEF", "VND", "VUV", "WST", "XAF", "XCD", "XDR", "XOF", "XPF", "XSU", "XUA", "YER", "ZAR", "ZMW", "ZWL"]
    
    
    func convert(_ convert: String) -> String {
        print("😶")
        let amount = Double(convert) ?? 0.0
        let selectedCurrency = currencies[toCurrency]
        
        let data = CurrencyData(currencyName: selectedCurrency.lowercased())
        
        //string with a format to 2 decimal places
        return String(format: "%.2f", data.rate * amount)
    }

    
    //use binding variables for amount and itemselected
    var body: some View {
        NavigationView {
            VStack {
                Spacer()
                Image("currencyconverter")
                    .resizable()
                    .frame(width: 100, height: 100, alignment: .center)

                Form {
                    Section(header: Text("")) {
                        Picker(selection: $fromCurrency, label: Text("From")) {
                            //loop through the elements, select the current element and place it in to be selected
                            ForEach(0 ..< currencies.count) { index in
                                Text(self.currencies[index]).tag("USD")
//                            ForEach(0 ..< currencies.count) { index in
//                                Text(self.currencies[index]).tag(index)
                            }
                        }
                        
                        //will start at the index of 1, which is EUR in the list of countries
                        Picker(selection: $toCurrency, label: Text("To")) {
                            ForEach(0 ..< currencies.count) { index in
                                Text(self.currencies[index]).tag(index)
                            }
                        }
                    }
                    Section(header: Text("Conversion")) {
                        TextField("Enter an amount", text: $amount)
                        Text("\(convert(amount)) \(currencies[toCurrency])")
                    }
                                            
                }.navigationTitle("Currency Converter")
                
            }

        }
    }
    struct CurrencyConverter_Previews: PreviewProvider {
        static var previews: some View {
            CurrencyConverterView()
        }
    }
}
