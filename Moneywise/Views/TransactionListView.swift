//
//  TransactionList.swift
//  Moneywise
//
//  Created by Carmen Chiu on 7/11/22.
//

import SwiftUI

struct TransactionListView: View {
    
    @State var viewModel = TransactionListViewModel()
    
    var body: some View {
        NavigationView {
                VStack {
                    //MARK: -- Search bar
                    
                    //MARK: -- Add button/Save button
                    
                    //MARK: -- Filter by data, category, or rating
                    //MARK: List of entries
                    List {
                        ForEach(viewModel.transactions) { transaction in
                            NavigationLink {
                                //Destination
                               // TransactionDetailView(transaction: transaction, transactionViewModel: viewModel)
                                TransactionDetailView(transactionViewModel: TransactionListViewModel(), transactionDateText: Date(), transactionNameText:"Lunch on Monday", transactionCategoryText: "Food", transactionMerchantText: "DeliBoard", transactionAmountValue: "$12", transactionReoccuring: false, transactionNoteText: "Sandwich and soda")
                            } label: {
                                HStack {
                                    Image(Category.Categories.DiningOut.rawValue)
                                    
                                    VStack {
                                        Text(transaction.name ?? "Unknown")
                                            .bold()
                                            .font(.headline)
                                        Text(transaction.category ?? "Unknown")
                                            .font(.system(size: 14))
                                        //                Text(String(transaction.date))
                                        //                    .bold()
                                    }
                                    Text(String(transaction.amount))
                                        .font(.system(size: 14))
                                }
                            
                                
//                                TransactionRowView(transaction: transaction)
//                                    .padding()
//                                    .frame(maxHeight: 115)
                            }
                        }
                        //      .onDelete(perform: viewModel.removeEntry(indexSet:))
                    }.navigationTitle("List of Transactions")
                        .navigationBarTitleDisplayMode(.inline)
                        .toolbar {
                            ToolbarItem {
                                NavigationLink {
                                    
                                    //MARK:: COME BACKTO THIS
                                    
                                 //   TransactionDetailView()
                                } label: {
                                    Image(systemName: "plus")
                                        .symbolRenderingMode(.palette)
                                        .foregroundStyle(Color.icon)
                                }
                            }
                            
                        }

            }
            
        }
    }
}


//MARK: -- TransactionRowView

struct TransactionRowView: View {
    var transaction: Transaction
    var body: some View {
        HStack {
            Image(Category.Categories.DiningOut.rawValue)
            
            VStack {
                Text(transaction.name ?? "Unknown")
                    .bold()
                    .font(.headline)
                Text(transaction.category ?? "Unknown")
                    .font(.system(size: 14))
                //                Text(String(transaction.date))
                //                    .bold()
            }
            Text(String(transaction.amount))
                .font(.system(size: 14))
        }
    }
}






//MARK: -- Formatters


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
