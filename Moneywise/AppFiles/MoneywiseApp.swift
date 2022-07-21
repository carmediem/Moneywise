//
//  MoneywiseApp.swift
//  Moneywise
//
//  Created by Carmen Chiu on 7/11/22.
//

import SwiftUI

@main
struct Moneywise: App {
        
    let persistenceController = PersistenceController.shared
    
    var body: some Scene {
        WindowGroup {
            AppFlow()
                .environment(\.managedObjectContext, persistenceController.container.viewContext) //this applies to everywhere in the app. The app flow is a view i defined that. like Initial view controller. Entry point to the app. Every view is using this environment because its in the appflow
                .environmentObject(TransactionListViewModel()) //create one instance only for the app. Its like a singleton. Reference it when we want to access it. Declare it as a property on the view. Retain cycle.
        }
    }
    
}
