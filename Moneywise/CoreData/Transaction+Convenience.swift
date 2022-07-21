//
//  Transaction+Convenience.swift
//  Moneywise
//
//  Created by Carmen Chiu on 7/13/22.
//

import CoreData

extension Transaction {
    
    @discardableResult convenience init(name: String, amount: Double, category: String, date: Date = Date(), transactionId: UUID, isReoccuring: Bool = false, merchant: String, note: String, type: String, context: NSManagedObjectContext = PersistenceController.shared.container.viewContext) {
    self.init(context: context)
    self.name = name
    self.amount = amount
    self.category = category
    self.date = date
    self.transactionId = transactionId
    self.isReoccuring = isReoccuring
    self.merchant = merchant
    self.note = note
    self.type = type
    }
}
    enum TransactionType: String {
        case debit = "debit"
        case credit = "credit"
    }

enum ExpenseFilterTime: String {
    case all
    case week
    case month
}


