//
//  SortViewViewModel.swift
//  Moneywise
//
//  Created by Carmen Chiu on 7/23/22.
//

import SwiftUI

struct SortView: View {
    
//    @FetchRequest (entity: Transaction.entity(), sortDescriptors: Category.Categories.id, ascending: true)
    
    var body: some View {
        HStack(alignment: .center, spacing: 20) {
            Button {
           //     let sortedCategory = Category.Categories.sorted()

            } label: {
            Text("Category")
            }.buttonStyle(.bordered)
            
            Button {
                //
            } label: {
            Text("Month")
            }.buttonStyle(.bordered)
        
            Button {
                let amountSort = NSSortDescriptor(key: "amount", ascending: true)
            } label: {
            Text("$ Max")
            }.buttonStyle(.bordered)
        
            Button {
      //          let sortedAmountMin = Category.amount.sorted { $0 > $1 }
            } label: {
            Text("$ Min")
            }.buttonStyle(.bordered)
        }.frame(alignment: .leading)
    }
}


struct SortView_Previews: PreviewProvider {
    static var previews: some View {
        SortView()
    }
}



//func group(_ result: FetchedResults<TransactionListView>) -> [[Transaction]] {
//    return Dictionary(grouping: result) { $0.category! .sorted() }
//        .map {$0.value}
//}


//func initializeFetchedResultsController() {
//    let request = NSFetchRequest(entityName: "Transaction")
//    let categorySort = NSSortDescriptor(key: "category.name", ascending: true)
//    let dateSort = NSSortDescriptor(key: "date", ascending: true)
//    request.sortDescriptors = [categorySort, dateSort]
//    let moc = dataController.managedObjectContext
//    //setting the same key as above because they keys need to match in order to break into multiple sections
//    fetchedResultsController = NSFetchedResultsController(fetchRequest: request, managedObjectContext: moc, sectionNameKeyPath: "category.name", cacheName: nil)
//    fetchedResultsController.delegate = self
//    do {
//        try fetchedResultsController.performFetch()
//    } catch {
//        fatalError("Failed to initialize FetchedResultsController: \(error)")
//    }
