//
//  MoneywiseApp.swift
//  Moneywise
//
//  Created by Carmen Chiu on 7/11/22.
//

import SwiftUI

@main
struct MoneywiseApp: App {
    
    @StateObject private var dataController = DataController()
    
    let persistenceController = PersistenceController.shared
    
    var body: some Scene {
        WindowGroup {
            TabView {
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
                
                
                    .environment(\.managedObjectContext, dataController.container.viewContext)
                
            }
        }
    }
}
