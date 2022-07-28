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
        
    var monthFromCurrent = 0
    var selectedMonthNumber = 0
    
    var selectedTransaction: String = ""
        
    let currentMonthNumber = Calendar.current.component(.month, from: Date())
    
    init() {
        load()
        print(transactions.count)
    }

    static let emptyMessage = "You have not listed any entries for expenses or income. Click the + in the upper right corner to start managing your money "
    
    
   var transactions: [Transaction] = []
    
    func load() {
        let request = NSFetchRequest<Transaction>(entityName: "Transaction")
        request.sortDescriptors = [NSSortDescriptor(key: #keyPath(Transaction.name), ascending: false)]
        
        do {
         let transactions = try? PersistenceController.shared.container.viewContext.fetch(request)
            print(transactions?.count)
            self.transactions = transactions ?? []  //start as unfiltered
         self.filteredTransactions = transactions ?? []
        } catch {
            print(error)
        }
    }
    
    
    //MARK: -- CRUD FOR TRANSACTIONS
    func createTransaction(name: String, amount: Double, category: String, date: Date, isReoccuring: Bool, merchant: String, note: String, type: String, imageName: String) {
        let context = PersistenceController.shared.container.viewContext
        let transaction = Transaction(name: name, amount: amount, category: category, date: date, transactionId: UUID(), isReoccuring: isReoccuring, merchant: merchant, note: note, type: type, imageName: imageName, context: context)
        transactions.append(transaction)
        print(transaction.transactionId)
        do {
            try context.save()//want to make sure we're creating and saving the transaction on the same context.
        } catch {
            print(error)
        }
    }
    
    
    func updateTransaction(_ transaction: Transaction?, name: String, amount: Double, category: String, date: Date, isReoccuring: Bool, merchant: String, type:
        String, note: String) {
        guard let transaction = transaction else {
            return
        }
        let context = PersistenceController.shared.container.viewContext
        transaction.name = name
        transaction.amount = amount
        transaction.category = category
        transaction.date = date
        transaction.merchant = merchant
        transaction.type = type
        transaction.note = note
        do {
            try context.save()//want to make sure we're creating and saving the transaction on the same context.
        } catch {
            print(error)
        }

    }
    
    func removeTransaction(transaction: Transaction, with context: NSManagedObjectContext, uuid: String) {
        let transactionsToDeleteRequest: NSFetchRequest<Transaction> = Transaction.fetchRequest()
        let uuidQuery = NSUUID(uuidString: uuid)
        transactionsToDeleteRequest.predicate = NSPredicate(format: "transactionId = %@", uuidQuery! as CVarArg) //set the predicate for the delete request. It is telling it to look for the uuid that is equal to the argument. Need the key to equal to the value. transactionId needs to be a property in my entity
        if let transactionsToDelete = try? context.fetch(transactionsToDeleteRequest).first {
            print(transactionsToDelete.name)
            transactions.removeAll { transaction in
                transaction.transactionId == transactionsToDelete.transactionId  //update from published and delete from core data
            }
            context.delete(transactionsToDelete)
        } else {
            print("😀")
        }
        do {
            try PersistenceController.shared.container.viewContext.save()
        } catch {
            print(error)
        }
    }
    

    //MARK: -- function for search bar
    func search(with searchQuery: String = "") {
        guard !searchQuery.isEmpty else {
          load()
          return
        }
        filteredTransactions = transactions.filter { $0.name!.contains(searchQuery) }
    }

//MARK: -- Sort by category
    func sortByCategory() {
        //sort vs sorted. sort requires compared. sorted returns a new array
        filteredTransactions = transactions.sorted {
            //always basing it on the whole list
            return $0.category ?? "Other" < $1.category ?? "Other"
            }
        }
    

    func sortByMonth() {
        filteredTransactions = transactions.sorted {
            return $0.date ?? Date() < $1.date ?? Date()
        }
    }


    func sortByMax() {
        filteredTransactions = transactions.sorted {
            return $0.amount  > $1.amount
        }
    }
    
    func sortByMin() {
        filteredTransactions = transactions.sorted {
            return $0.amount < $1.amount
        }
    }
    
    
    //MARK: -- Filter by month for graph
    func filterByPreviousMonth() {
        monthFromCurrent -= 1
        print("Updated Month = \(monthFromCurrent)")
        filteredTransactions = transactions.filter { (transaction) -> Bool in
            return transaction.date!.month == currentMonthNumber + monthFromCurrent
        }
        print(filteredTransactions)
        refreshData(transactions: filteredTransactions)
    }

    func filterByNextMonth() {
        monthFromCurrent += 1
        print("Updated Month = \(monthFromCurrent)")
        filteredTransactions = transactions.filter { (transaction) -> Bool in
            return transaction.date!.month == currentMonthNumber + monthFromCurrent
        }
        refreshData(transactions: filteredTransactions)
    }
}

extension Date {
    var month: Int {
        return Calendar.current.component(.month, from: self)
    }
}
