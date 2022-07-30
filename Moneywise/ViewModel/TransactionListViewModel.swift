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
    @Published var pie: [Pie] = []
    
    
    var monthFromCurrent = 0
    var selectedMonthNumber = 0
    //how far from t-0 , current time
    
    var selectedTransaction: String = ""
    
    let currentMonthNumber = Calendar.current.component(.month, from: Date())
    
    init() {
        load()
        print(filteredTransactions.count)
    }
    
    static let emptyMessage = "You have not listed any entries for expenses or income. Click the + in the upper right corner to start managing your money "
    
    
    func load() {
        let request = NSFetchRequest<Transaction>(entityName: "Transaction")
        request.sortDescriptors = [NSSortDescriptor(key: #keyPath(Transaction.name), ascending: false)]
        
        do {
            let transactions = try? PersistenceController.shared.container.viewContext.fetch(request)
            print(filteredTransactions.count)
            self.filteredTransactions = transactions ?? []  //start as unfiltered
         //   self.filteredTransactions = transactions ?? []
        } catch {
            print(error)
        }
    }
    
    
    //MARK: -- CRUD FOR TRANSACTIONS
    func createTransaction(name: String, amount: Double, category: String, date: Date, isReoccuring: Bool, merchant: String, note: String, type: String, imageName: String) {
        let context = PersistenceController.shared.container.viewContext
        let transaction = Transaction(name: name, amount: amount, category: category, date: date, transactionId: UUID(), isReoccuring: isReoccuring, merchant: merchant, note: note, type: type, imageName: imageName, context: context)
        
        //  filteredTransactions.append(filteredTransactions)
        
        print(transaction.transactionId)
        do {
            try context.save()//want to make sure we're creating and saving the transaction on the same context.
        } catch {
            print(error)
        }
    }
    
    
    func updateTransaction(_ transaction: Transaction?, name: String, amount: Double, category: String, date: Date, isReoccuring: Bool, merchant: String, type: String, note: String, imageName: String) {
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
        transaction.imageName = imageName
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
            filteredTransactions.removeAll { transaction in
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
        filteredTransactions = filteredTransactions.filter { $0.name!.contains(searchQuery) }
    }
    
    //MARK: -- Sort for the ListOfTransactions
    func sortByCategory() {
        //sort vs sorted. sort requires compared. sorted returns a new array
        filteredTransactions = filteredTransactions.sorted {
            //always basing it on the whole list
            return $0.category ?? "Other" < $1.category ?? "Other"
        }
    }
    
    func sortByMonth() {
        filteredTransactions = filteredTransactions.sorted {
            return $0.date ?? Date() < $1.date ?? Date()
        }
    }
    
    func sortByMax() {
        filteredTransactions = filteredTransactions.sorted {
            return $0.amount  > $1.amount
        }
    }
    
    func sortByMin() {
        filteredTransactions = filteredTransactions.sorted {
            return $0.amount < $1.amount
        }
    }
    
    
    //MARK: -- Filter by month for graph
    func filterByPreviousMonth() {
        monthFromCurrent -= 1
        print("Updated Month = \(monthFromCurrent)")
        filteredTransactions = filteredTransactions.filter { (transaction) -> Bool in
            return transaction.date!.month == currentMonthNumber + monthFromCurrent
        }
        print(filteredTransactions)
        refreshData(transactions: filteredTransactions)
        updateMonth(updatedMonth: currentMonthNumber + monthFromCurrent - 1)
        //using the func updateMonth so the month displayed updates. subtracts 1 from the current month. reading the variable to the currentmonth. which triggers the update on the getDateStringFromCurrentMonthIndex func
        self.pie = loadTransactionData(transactions: self.filteredTransactions)
    }
    
    func filterByNextMonth() {
        monthFromCurrent += 1
        print("Updated Month = \(monthFromCurrent)")
        filteredTransactions = filteredTransactions.filter { (transaction) -> Bool in
            return transaction.date!.month == currentMonthNumber + monthFromCurrent
        }
        refreshData(transactions: filteredTransactions)
        updateMonth(updatedMonth: currentMonthNumber + monthFromCurrent - 1)
        // -1 because we want it to start back at [0
        self.pie = loadTransactionData(transactions: self.filteredTransactions)
        
    }
    
    //MARK: -- LOAD TRANSACTION FOR GRAPH AND CHART
    func loadTransactionData(transactions: [Transaction]) -> [Pie] {
        do {
            var total = 0.00;
            var categories: [String : Double] = [:]
            let ignoredCategories = ["Income", "Savings", "Investment", "SelectOne"]
            transactions.forEach { transaction in
                if(!ignoredCategories.contains(transaction.category ?? "Other")) {
                    total += transaction.amount
                    if (categories[transaction.category ?? "Other"] == nil) {
                        categories[transaction.category ?? "Other"] = transaction.amount
                    } else {
                        categories[transaction.category ?? "Other"]! += transaction.amount
                    }
                }
            }
            
            //Building the pie. Using percentages to build out the pie
            var pies: [Pie] = []
            var id = 0
            let colors = ["Blue", "BrightPink", "Yellow", "Orange", "Red", "Peach", "Pink", "Purple", "Red", "RoyalBlue", "Teal", "Green", "Mustard", "Green2"]
            categories.forEach { category in
                let percent = (category.value / total)
                pies.append(Pie(id: id, percent: CGFloat(percent * 100), name: category.key, color: Color(colors[id] )))
                id += 1
            }
            return pies
        } catch {
            print(error)
        }
    }
    
    func refreshData(transactions: [Transaction]) {
        self.pie = loadTransactionData(transactions: transactions)
    } //this assigns the data

    
}

extension Date {
    var month: Int {
        return Calendar.current.component(.month, from: self)
    }
}
