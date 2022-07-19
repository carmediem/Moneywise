//
//  TransactionListViewModel.swift
//  Moneywise
//
//  Created by Carmen Chiu on 7/11/22.
//

import Foundation
import SwiftUI

class TransactionListViewModel: ObservableObject {
    
    @Published var filteredTransactions = [Transaction]()
    
    
    static let emptyMessage = "You have not listed any entries for expenses or income. Click the + in the upper right corner to start managing your money "

        
    @Published var transactions: [Transaction] = [
        Transaction(name: "Groceries", amount: 20, category: "Dining Out", date: Date(), id: UUID(), isReoccuring: false, merchant: "TraderJoes", note: "none", type: "expense"),
        Transaction(name: "Dinner at Roam Burger", amount: 18, category: "diningOut", date: Date(), id: UUID(), isReoccuring: false, merchant: "Roam Burger", note: "none", type: "expense"),
        Transaction(name: "Concert at the park", amount: 25, category: "entertainment", date: Date(), id: UUID(), isReoccuring: false, merchant: "Ticket Master", note: "none", type: "expense"),
        Transaction(name: "Monthly HSA contribution", amount: 50, category: "healthcare", date: Date(), id: UUID(), isReoccuring: false, merchant: "Optum Bank", note: "none", type: "expense"),
        Transaction(name: "Payday", amount: 1500, category: "income", date: Date(), id: UUID(), isReoccuring: false, merchant: "Employer", note: "none", type: "income"),
        Transaction(name: "Groceries", amount: 20, category: "Dining Out", date: Date(), id: UUID(), isReoccuring: false, merchant: "TraderJoes", note: "none", type: "expense"),
        Transaction(name: "Dinner at Roam Burger", amount: 18, category: "diningOut", date: Date(), id: UUID(), isReoccuring: false, merchant: "Roam Burger", note: "none", type: "expense"),
        Transaction(name: "Concert at the park", amount: 25, category: "entertainment", date: Date(), id: UUID(), isReoccuring: false, merchant: "Ticket Master", note: "none", type: "expense"),
        Transaction(name: "Monthly HSA contribution", amount: 50, category: "healthcare", date: Date(), id: UUID(), isReoccuring: false, merchant: "Optum Bank", note: "none", type: "expense"),
        Transaction(name: "Payday", amount: 1500, category: "income", date: Date(), id: UUID(), isReoccuring: false, merchant: "Employer", note: "none", type: "income"),
    ]
    


    
    //MARK: -- CRUD FOR TRANSACTIONS
    func createTransaction(_ transaction: Transaction) {
        transactions.append(transaction)
        saveToPersistentStore()

    }
    
    //func to update
    
    
    func removeTransaction(indexSet: IndexSet) {
        transactions.remove(atOffsets: indexSet)
     //   CoreDataStack.context.remove(
        #warning("use saveContext to CoreDataStack or to persistent store?")
     //   CoreDataStack.saveContext()
        saveToPersistentStore()
    }
    
    
    
    
    //MARK: -- functions for search bar
    func search(with query: String = "") {
        filteredTransactions = query.isEmpty ? transactions : transactions.filter { $0.name!.contains(query) }
    }
    
    //MARK: -- Save to Persistent Store
    private func saveToPersistentStore() {
      do {
        try CoreDataStack.context.save()
      } catch {
        print("Error saving Managed Object Context, item not saved")
      }
    }
}

