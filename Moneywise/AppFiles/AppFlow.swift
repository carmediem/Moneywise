//
//  AppFlow.swift
//  Moneywise
//
//  Created by Carmen Chiu on 7/20/22.
//

import Foundation
import SwiftUI

struct AppFlow: View {
    var body: some View {
        TabView {
            ContentView()
                .tabItem {
                    Label("Login", systemImage: "face.smiling")
                }
            
            MainPageView()
                .tabItem {
                    Label("Overview", systemImage: "chart.pie")
                }
            
            TransactionListView()
                .tabItem {
                    Label("List", systemImage: "list.bullet")
                }
            
            CurrencyConverterView()
                .tabItem {
                    Label("Converter", systemImage: "dollarsign.circle")
                }
        }.background(Color.background)
    }
}
