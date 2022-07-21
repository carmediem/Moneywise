//
//  TransactionListViewModel.swift
//  Moneywise
//
//  Created by Carmen Chiu on 7/11/22.
//

import Foundation
import SwiftUI
import CoreData

class TransactionListViewModel: ObservableObject {
    
    @Published var filteredTransactions = [Transaction]()
    
 //     var transactions: [Transaction] = []
    
        init() {
            load()
            print(transactions.count)
        }
    
    static let emptyMessage = "You have not listed any entries for expenses or income. Click the + in the upper right corner to start managing your money "
    
    
    @Published var transactions: [Transaction] = []
    
    func load() {
        let request = NSFetchRequest<Transaction>(entityName: "Transaction")
        request.predicate = NSPredicate(value: true)

        self.transactions = (try? PersistenceController.shared.container.viewContext.fetch(request)) ?? []
    }
    
    //MARK: -- CRUD FOR TRANSACTIONS
    func createTransaction(name: String, amount: Double, category: String, date: Date, isReoccuring: Bool, merchant: String, note: String, type: String) {
        let transaction = Transaction(name: name, amount: amount, category: category, transactionId: UUID(), isReoccuring: isReoccuring, merchant: merchant, note: note, type: type)
        transactions.append(transaction)
        //MARK: -- COME BACK TO THIS. rememeber to save
     //   PersistenceController.shared.container.viewContext
    }
    
    
    func updateTransaction(_ transaction: Transaction) {
        //find the entry
        guard let index = transactions.firstIndex(of: transaction) else { return }
        //make the updates
        
        //MARK: -- COME BACK TO THIS. rememeber to save
    //    CoreDataStack.saveContext()
    }
    
    
    func removeTransaction(transaction: Transaction, with context: NSManagedObjectContext, uuid: String) {
        let transactionsToDeleteRequest: NSFetchRequest<Transaction> = Transaction.fetchRequest()
        let uuidQuery = NSUUID(uuidString: uuid)
        transactionsToDeleteRequest.predicate = NSPredicate(format: "transactionId = %@", uuidQuery! as CVarArg) //set the predicate for the delete request. It is telling it to look for the uuid that is equal to the argument. Need the key to equal to the value. transactionId needs to be a property in my entity
        if let transactionsToDelete = try? context.fetch(transactionsToDeleteRequest).first {
            print(transactionsToDelete.name)
            context.delete(transactionsToDelete)
        } else {
            print("eric rocks")
        }
        do {
            try PersistenceController.shared.container.viewContext.save()
        } catch {
            print(error)
        }
    }
    
    
    
    func deleteTransactions(at offsets: IndexSet) {
        for offset in offsets {
            let transaction = transactions[offset]
            PersistenceController.shared.container.viewContext.delete(transaction)
        }
        try? PersistenceController.shared.container.viewContext.save()
    }
    
    //MARK: -- functions for search bar
    func search(with query: String = "") {
        filteredTransactions = query.isEmpty ? transactions : transactions.filter { $0.name!.contains(query) }
        
    }
    
    //    func prepareForCreateEntry() {
    //        let transaction = Transaction(context: managedObjectContext)
    //        transaction.date = transactionDateText
    //        transaction.name = transactionNameText
    //        transaction.category = transactionCategoryText
    //        transaction.merchant = transactionMerchantText
    //        transaction.amount = transactionAmountValue
    //        transactionReoccuring = transactionReoccuring
    //        transaction.note = transactionNoteText
    //
    //        do {
    //            try managedObjectContext.save()
    //            transactionViewModel.transactions.append(transaction)
    //        } catch {
    //            // handle the Core Data error
    //        }
    //        CoreDataStack.saveContext()
    //
    //        dismiss()
    //
    //        }
    
    func prepareForUpdateTransaction() {
        //get info from core data
    }
    
    
}

