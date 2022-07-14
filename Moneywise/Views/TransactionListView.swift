//
//  TransactionList.swift
//  Moneywise
//
//  Created by Carmen Chiu on 7/11/22.
//

import SwiftUI

struct TransactionListView: View {
    
    @ObservedObject var viewModel = TransactionListViewModel()
    
    var body: some View {
        NavigationView {
            ScrollView {
//                VStack {
                    // MARK: Header Title
                    Text("Recent Transactions")
                        .bold()
                        .offset(x: -90, y: -30)
                    
                //MARK: Searchbar
                
                //MARK: Sort by category
                
                
                
                
                    //MARK: List of entries
                    List {
                        ForEach(viewModel.transactions) { transaction in
                            NavigationLink {
                                //Destination
                                TransactionDetailView(transaction: transaction, transactionViewModel: viewModel)
                                
                            } label: {
                                TransactionRowView(transaction: transaction)
                                    .padding()
                                    .frame(maxHeight: 115)
                            }
                        }
                 //add delete from view model
                    }
                    
                }
            }
        }
    }
//}
//MARK: -- TransactionRowView

struct TransactionRowView: View {
    var transaction: Transaction
    var body: some View {
        HStack {
            //icon
            VStack {
                Text(transaction.name ?? "Unknown")
                    .bold()
                .font(.headline)
                Text(transaction.category ?? "Unknown")
                    .font(.system(size: 14))
//                Text(transaction.date ?? "Unknown")
//                    .bold()
            }
//            Text(transaction.amount ?? "Unknown"))
//                .font(.system(size: 14))

        }
    }
}


//MARK: -- Search bar

//MARK: -- Add button/Save button

//MARK: -- Filter by data, category, or rating




//MARK: -- Formatters
let monthDateFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateFormat = "MMMM YYYY"
    return formatter
}()

let currencyFormatter: NumberFormatter = {
    let formatter = NumberFormatter()
    formatter.numberStyle = .currency
    return formatter
}()

struct TransactionListView_Previews: PreviewProvider {
    static var previews: some View {
        TransactionListView()
        TransactionListView()
            .preferredColorScheme(.dark)
    }
}
