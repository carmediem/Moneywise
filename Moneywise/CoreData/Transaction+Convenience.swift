//
//  Transaction+Convenience.swift
//  Moneywise
//
//  Created by Carmen Chiu on 7/13/22.
//

import CoreData

extension Transaction {
    
    @discardableResult convenience init(name: String, amount: Double, category: String, date: Date, id: UUID, isReoccuring: Bool = false, merchant: String, note: String, rating: String, type: String, context: NSManagedObjectContext = CoreDataStack.context) {
    self.init(context: context)
    self.name = name
    self.amount = amount
    self.category = category
    self.date = date
    self.id = id
    self.isReoccuring = isReoccuring
    self.merchant = merchant
    self.note = note
    self.rating = rating
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

