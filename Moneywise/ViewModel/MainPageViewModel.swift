////
////  MainPageViewModel.swift
////  Moneywise
////
////  Created by Carmen Chiu on 7/25/22.
////
//
//import Foundation
//import CoreData
//
//
//class MainPageViewModel {
//    
//    func loadTransactionData() -> [Pie] {
//        let request = NSFetchRequest<Transaction>(entityName: "Transaction")
//        request.sortDescriptors = [NSSortDescriptor(key: #keyPath(Transaction.name), ascending: false)]
//
//        do {
//            let transactions = try? PersistenceController.shared.container.viewContext.fetch(request)
//            var total = 0.0;
//            var categories: [String : Double] = [:]
//            let ignoredCategories = ["Income", "Savings", "Investment"]
//            transactions?.forEach{transaction in
//                if(!ignoredCategories.contains(transaction.category ?? "Other")){
//                    total += transaction.amount
//                    if (categories[transaction.category ?? "Other"] == nil){
//                        categories[transaction.category ?? "Other"] = transaction.amount
//                    }else{
//                        categories[transaction.category ?? "Other"]! += transaction.amount
//                    }
//                }
//            }
//            var pies: [Pie] = []
//            var id = 0
//            let colors = ["Blue", "BrightPink", "Yellow", "Orange", "Red", "Peach", "Pink", "Purple", "Red", "RoyalBlue", "Teal", "Green", "Mustard", "Green2"]
//            categories.forEach{category in
//                let percent = (category.value / total)
//                pies.append(Pie(id: id, percent: CGFloat(percent*100), name: category.key, color: Color(colors[id] )))
//                id += 1
//            }
//            return pies
//        } catch {
//            print(error)
//        }
//    }
//
//    
//    
//    
//}
