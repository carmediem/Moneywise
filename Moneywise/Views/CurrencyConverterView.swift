//
//  CurrencyConverter.swift
//  Moneywise
//
//  Created by Carmen Chiu on 7/15/22.
//

import SwiftUI

struct CurrencyConverter: View {
    
    @State private var itemSelected = 0
    @State private var itemSelected2 = 1
    @State private var amount: String = ""
    private let currencies = ["USD", "EUR", "GBP"]
    
    func convert(_ convert: String) -> String {
        var conversion: Double = 1.0
        let amount = Double(convert) ?? 0.0
        let selectedCurrency = currencies[itemSelected]
        let to = currencies[itemSelected2]
        
        //create a dictionary of array for the converstion rates. Update this later with JSON data for API
        
        let eurRate = ["USD": 1.0, "EUR": 0.99, "GBP": 1.03]
        let usdRate = ["USD": 1.0, "EUR": 0.87, "GBP": 1.25]
        let gbpRate = ["USD": 1.37, "EUR": 1.18, "GBP": 1.03]
        
        switch (selectedCurrency) {
        case "USD":
        conversion = amount * (usdRate[to] ?? 0.0)
        case "EUR":
        conversion = amount * (eurRate[to] ?? 0.0)
        case "GBP":
        conversion = amount * (gbpRate[to] ?? 0.0)
        default:
            print("error in converting")
        }
        //string with a format to 2 decimal places
        return String(format: "%.2f", conversion)
    }
    
    
    //use binding variables for amount and itemselected
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Conver a currency")) {
                    Picker(selection: $itemSelected, label: Text("From")) {
                        //loop through the elements, select the current element and place it in to be selected 
                        ForEach(0 ..< currencies.count) { index in
                            Text(self.currencies[index]).tag(index)
                        }
                    }
                    
                    //will start at the index of 1, which is EUR in the list of countries
                    Picker(selection: $itemSelected2, label: Text("To")) {
                        ForEach(0 ..< currencies.count) { index in
                            Text(self.currencies[index]).tag(index)
                        }
                        
                    }
                    TextField("Enter an amount", text: $amount)
                }
                Section(header: Text("Conversion")) {
                    Text("\(convert(amount)) \(currencies[itemSelected2])")
                    
                         }
                         }
                         }
                         }
                         }
                         struct CurrencyConverter_Previews: PreviewProvider {
                        static var previews: some View {
                            CurrencyConverter()
                        }
                    }
