//
//  TransactionList.swift
//  Moneywise
//
//  Created by Carmen Chiu on 7/11/22.
//

import SwiftUI

struct TransactionListView: View {
    
    @State var viewModel = TransactionListViewModel()
    @State private var query = ""
    
    var body: some View {
        NavigationView {
            VStack {
                ScrollView {
                    
                    //MARK: -- Add button/Save button
                    
                    //MARK: -- Filter by data, category, or rating
                    //MARK: List of entries
                    List(viewModel.transactions, id: \.self) { transaction in
//                        ForEach(viewModel.transactions) { transaction in
                            NavigationLink {
                
                                //Destination
                                TransactionDetailView(transactionViewModel: viewModel, transaction: transaction, transactionAmountValue: "0.0", ifIsNew: false)
                            } label: {
                                HStack {
                                    Image(Category.Categories.DiningOut.rawValue)
                                        .resizable()
                                        .frame(width: 25, height: 32, alignment: .leading)
                                        .padding(2)
                                    
                                    VStack {
                                        Text(transaction.name ?? "Unknown")
                                            .bold()
                                            .font(.headline)
                                        Text(transaction.category ?? "Unknown")
                                            .font(.system(size: 14))
                                        let date = transaction.date
                                        let stringDate = DateFormatter.allNumericUSA.string(from: date ?? Date())
                                        Text(stringDate)
                                    }
                                    Text(String(transaction.amount))
                                        .font(.system(size: 14))
                                }
                                .frame(height: 50)
                             

                                
                            }
                   //     }
                        //      .onDelete(perform: viewModel.removeEntry(indexSet:))
                        
                        //MARK: -- Search Bar
                    }
                    .navigationTitle("List of Transactions")
                    .searchable(text: $query,
                                 //this keeps the search bar always on. TBD on whether to keep this
                                placement: .navigationBarDrawer(displayMode: .always),
                                 prompt: "Search your transactions")
                        .onSubmit(of: .search) {
                            viewModel.search(with: query)
                        }
                        .onChange(of: query) {newQuery in   //query is not binding, just listening for changes
                            viewModel.search(with: newQuery)
                        }
                        .onAppear {  //with EmpttyView
                            viewModel.search()
                        }
//                        .overlay {
//                            if viewModel.filteredData.isEmpty {
//                                EmptyView(query: $query)
//                            }
//                        }
                       .frame(height: CGFloat(viewModel.transactions.count) * 100 + 25)
//                        .listStyle(.plain)
                        .navigationBarTitleDisplayMode(.inline)
                        .toolbar {
                            ToolbarItem {
                                NavigationLink {
                                   
                                    TransactionDetailView(transactionViewModel: viewModel, transactionAmountValue: "0.0", ifIsNew: true)
                                } label: {
                                    Image(systemName: "plus")
                                        .symbolRenderingMode(.palette)
                                        .foregroundStyle(Color.icon)
                                }
                            }
                            
                        }
                    
                }
                
            }
            
            
            
            //.frame(height: CGFloat(viewModel.transactions.count) * 80 + 20)
        }
    }
//    }.onAppear {
//    TransactionDetailView(transactionViewModel: TransactionListViewModel(), transactionDateText: , transactionNameText: "Books for July", transactionCategoryText: "Education", transactionMerchantText: "Green Apple Bookstore", transactionAmountValue: "2.99", transactionReoccuring: false, transactionNoteText: "book to read for fun")
//        //modify the detail view to know "is new". if it is new, display this, otheswise display others
//    }
    
    //MARK: Search for transactions list- CAN DELETE IF THE SEARCH BAR WORKS. UPDATED FUNC IN TRANSACTIONLISTVIEWMODEL
//    var transactions: [Transaction] {
//        let listOfTransactions = self.transactions.map { $0.lowercase() }
//        return searchText == "" ? listOfTransactions : listOfTransactions.filter {
//            $0.contains(searchText.lowercased()) }
//
//    }
    
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
