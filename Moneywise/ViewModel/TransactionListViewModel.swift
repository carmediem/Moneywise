//
//  TransactionListViewModel.swift
//  Moneywise
//
//  Created by Carmen Chiu on 7/11/22.
//

import Foundation
import SwiftUI

class TransactionListViewModel: ObservableObject {
   @Published var transactions: [Transaction] = []
    var color = Color(cgColor: .init(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.5))
    
        
    

//MARK: -- CRUD FOR TRANSACTIONS
   //Add transaction
  
    
    
    
    //MARK: -- Transaction Colors
    func TransactionColor(type: ExpenseType) -> Color {
        switch type  {
        case ExpenseType.income: return .blue
        case ExpenseType.expense: return .red
        case ExpenseType.all: return .black
        }
    }
    
    
    
    
        //MARK: -- Group by category or sort by category

    }

