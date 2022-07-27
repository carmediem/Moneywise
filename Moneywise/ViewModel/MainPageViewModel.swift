////
////  MainPageViewModel.swift
////  Moneywise
////
////  Created by Carmen Chiu on 7/27/22.
////
//
//import SwiftUI
//import CoreData
//
//class MainPageViewModel: ObservableObject {
//
// 
//@Published var filteredTransactions = [Transaction]()
//    
//    var transactions: [Transaction] = []
//    
//
//    func loadTransactionData() -> [Pie] {
//        let request = NSFetchRequest<Transaction>(entityName: "Transaction")
//        request.sortDescriptors = [NSSortDescriptor(key: #keyPath(Transaction.name), ascending: true)]
//    
//        do {
//            let transactions = try
//            PersistenceController.shared.container.viewContext.fetch(request)
//            
////            self.transactions = transactions
////            filterByMonth(index: Calendar.current.component(.month, from: Date()))
////
//            
//            var total = 0.00;
//            var categories: [String : Double] = [:]
//            let ignoredCategories = ["Income", "Savings", "Investment", "SelectOne"]
//            transactions.forEach{transaction in
//                if(!ignoredCategories.contains(transaction.category ?? "Other")){
//                    total += transaction.amount
//                    if (categories[transaction.category ?? "Other"] == nil) {
//                        categories[transaction.category ?? "Other"] = transaction.amount
//                    } else {
//                        categories[transaction.category ?? "Other"]! += transaction.amount
//                    }
//                }
//            }
//            var pies: [Pie] = []
//            var id = 0
//            let colors = ["Blue", "BrightPink", "Yellow", "Orange", "Red", "Peach", "Pink", "Purple", "Red", "RoyalBlue", "Teal", "Green", "Mustard", "Green2"]
//            categories.forEach { category in
//                let percent = (category.value / total)
//                pies.append(Pie(id: id, percent: CGFloat(percent*100), name: category.key, color: Color(colors[id] )))
//                id += 1
//            }
//            return pies
//        } catch {
//            print(error)
//        }
//    }
//    var data = loadTransactionData()
//    
//    
////    func filterByMonth(index: Int) {
////        filteredTransactions = transaction.filter {
////            let monthIndex = Calendar.current.component(.month, from: $0.date ?? Date())
////            return index == monthIndex
////        }
////
////}
////}
//}
