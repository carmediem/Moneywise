//
//  TransactionListViewModel.swift
//  Moneywise
//
//  Created by Carmen Chiu on 7/11/22.
//

import Foundation
import SwiftUI

class TransactionListViewModel: ObservableObject {
    
   @Published var transactions: [Transaction] = [
    Transaction(name: "Groceries", amount: 20, category: "groceries", date: Date(), id: UUID(), isReoccuring: false, merchant: "TraderJoes", note: "none", rating: "neutral", type: "expense"),
    Transaction(name: "Groceries", amount: 20, category: "groceries", date: Date(), id: UUID(), isReoccuring: false, merchant: "TraderJoes", note: "none", rating: "neutral", type: "expense"),
    Transaction(name: "Groceries", amount: 20, category: "groceries", date: Date(), id: UUID(), isReoccuring: false, merchant: "TraderJoes", note: "none", rating: "neutral", type: "expense"),
    Transaction(name: "Groceries", amount: 20, category: "groceries", date: Date(), id: UUID(), isReoccuring: false, merchant: "TraderJoes", note: "none", rating: "neutral", type: "expense"),
    Transaction(name: "Groceries", amount: 20, category: "groceries", date: Date(), id: UUID(), isReoccuring: false, merchant: "TraderJoes", note: "none", rating: "neutral", type: "expense"),
    Transaction(name: "Groceries", amount: 20, category: "groceries", date: Date(), id: UUID(), isReoccuring: false, merchant: "TraderJoes", note: "none", rating: "neutral", type: "expense"),
    Transaction(name: "Groceries", amount: 20, category: "groceries", date: Date(), id: UUID(), isReoccuring: false, merchant: "TraderJoes", note: "none", rating: "neutral", type: "expense"),
    Transaction(name: "Groceries", amount: 20, category: "groceries", date: Date(), id: UUID(), isReoccuring: false, merchant: "TraderJoes", note: "none", rating: "neutral", type: "expense"),
    Transaction(name: "Groceries", amount: 20, category: "groceries", date: Date(), id: UUID(), isReoccuring: false, merchant: "TraderJoes", note: "none", rating: "neutral", type: "expense"),
    Transaction(name: "Groceries", amount: 20, category: "groceries", date: Date(), id: UUID(), isReoccuring: false, merchant: "TraderJoes", note: "none", rating: "neutral", type: "expense")
   ]
    
    //For the search bar 
    @Published var filteredTransactions = [Transaction]()
    
    var color = Color(cgColor: .init(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.5))
    

    
    func createTransaction(_ transaction: Transaction) {
        transactions.append(transaction)
    }
    
    //func to update
    
    
    func removeTransaction(indexSet: IndexSet) {
        transactions.remove(atOffsets: indexSet)
    }

//MARK: -- CRUD FOR TRANSACTIONS
   //Add transaction
  
    
    
    
    //MARK: -- Transaction Colors
    func TransactionColor(type: Category.Categories.ExpenseType) -> Color {
        switch type  {
        case Category.Categories.ExpenseType.income: return .blue
        case Category.Categories.ExpenseType.expense: return .red
        case Category.Categories.ExpenseType.all: return .black
        }
    }
    
    
    
//MARK: -- functions for search bar
    func search(with query: String = "") {
        filteredTransactions = query.isEmpty ? transactions : transactions.filter { $0.name!.contains(query) }
    }
    
//MARK: -- fuction for sort by category
    
   
    
    
    
    
    
    
    
    
    
    
    
    
    
    }

