//
//  TransactionList.swift
//  Moneywise
//
//  Created by Carmen Chiu on 7/11/22.
//

import SwiftUI

struct TransactionListView: View {
    @Environment(\.isSearching) var isSearching
    @EnvironmentObject var viewModel: TransactionListViewModel
    
  //  @State var viewModel = TransactionListViewModel() .//everytime something gets uploaded to my view, it will create a retain cycle and will load forever
    @State var searchQuery = ""
    @State var filterTransactions = TransactionListView.self

    var transactionList: some View {
        List(viewModel.transactions, id: \.self) { transaction in
            
                ForEach(viewModel.transactions) { transaction in
                    NavigationLink {
                        
                        //Destination
                        TransactionDetailView(transactionViewModel: viewModel, transactionAmountValue: 0.0, transactionTypeText: "", ifIsNew: false)
                    } label: {
                        TransactionRowView(transaction: transaction)
                        
                    }
                    .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                        Button("Delete", role: .destructive) {
                            if let id = transaction.transactionId {
                                viewModel.removeTransaction(transaction: transaction, with: PersistenceController.shared.container.viewContext, uuid: "\(id)")
                            }
                        }
                    }
                    
                }
                
                //     .onDelete(perform: deleteTransaction(for: id))
                
                //       Text(Month)
            
            
        }
        .navigationTitle("List of Transactions")
        //MARK: -- Search Bar
        .searchable(text: $searchQuery, placement: .navigationBarDrawer(displayMode: .always),
                    prompt: "Search your transactions")
        .onSubmit(of: .search) {
            viewModel.search(with: searchQuery)
        }
        .onChange(of: searchQuery) {newQuery in   //query is not binding, just listening for changes
            viewModel.search(with: newQuery)
        }
        .onAppear {  //with EmptyView
            viewModel.search()
        }
    }

    var body: some View {
        NavigationView {
            VStack {
                ScrollView {
                    
                    //MARK: -- Filter by date and category
                    //MARK: -- If there are no transactions
                    if viewModel.transactions.isEmpty {
                        EmptyTransactionTitle()
                            .padding(.top)
                            .toolbar {
                                ToolbarItem {
                                    NavigationLink {
                                        TransactionDetailView(transactionViewModel: viewModel, transactionAmountValue: 0.00, transactionTypeText: "", ifIsNew: true)
                                    } label: {
                                        Image(systemName: "plus")
                                            .symbolRenderingMode(.palette)
                                    }
                                }
                            }
                    } else {
                        //MARK: List of entries
                        transactionList
                        
                        ////                        .overlay {
                        ////                            if viewModel.filteredData.isEmpty {
                        ////                                EmptyView(query: $query)
                        ////                            }
                        ////                        }
                            .frame(height: CGFloat(viewModel.transactions.count) * 100 + 25)
                        //                        .listStyle(.plain)
                            .navigationBarTitleDisplayMode(.inline)
                            .toolbar {
                                ToolbarItem {
                                    NavigationLink {
                                        TransactionDetailView(transactionViewModel: viewModel, transactionAmountValue: 0.00, transactionTypeText: "", ifIsNew: true)
                                    } label: {
                                        Image(systemName: "plus")
                                            .symbolRenderingMode(.palette)
                                    }
                                }
                            }
                    }
                }
            }.navigationTitle("List of Transactions")
        }
        //           .onAppear {
        //        TransactionDetailView(transactionViewModel: transactionModel, transactionTypeText: "", ifIsNew: false)
        //    }
    }
    //MARK: Search for transactions list
    //    var transactions: [Transaction] {
    //        let listOfTransactions = self.transactions.map { $0.lowercase() }
    //        return query == "" ? listOfTransactions : listOfTransactions.filter {Context in environment is not connected to a persistent store coordinator
    //            $0.contains(query.lowercased()) }
    //    }
    //}
    
}
//MARK: Empty TransactionTitle
struct EmptyTransactionTitle: View {
    var body: some View {
        VStack(spacing: 24) {
            Divider()
            ZStack() {
                Rectangle().fill(.ultraThinMaterial)
                Text(TransactionListViewModel.emptyMessage)
                    .padding()
                    .font(.system(.caption, design: .monospaced))
            }.cornerRadius(12)
                .frame(width: UIScreen.main.bounds.width - 40)
            
            //add in picture or animation here to fill up the space
        }
    }
}


//MARK: -- TransactionRowView
struct TransactionRowView: View {
    @EnvironmentObject var viewModel: TransactionListViewModel
    var transaction: Transaction
    var body: some View {
        HStack {
            Image(Category.Categories.DiningOut.rawValue)
                .resizable()
                .frame(width: 30, height: 40, alignment: .leading)
                .padding(.leading, 5)
            
            
            VStack (alignment: .leading) {
                Text(transaction.name ?? "Unknown")
                    .bold()
                    .font(.headline)
                Text(transaction.category ?? "Unknown")
                    .font(.system(size: 14))
                let date = transaction.date
                let stringDate = DateFormatter.allNumericUSA.string(from: date ?? Date())
                Text(stringDate)
                    .font(.system(size: 14))
                    .padding(.horizontal, 30)
            }  .padding(.leading, 15)
            
            Text(String(transaction.amount))
                .font(.system(size: 18))
                .frame(width: 75, alignment: .trailing)
                .listRowInsets(EdgeInsets())
                .foregroundColor(Category.Categories.ExpenseType(rawValue: transaction.type ?? "all")?.color)
        }
        .toolbar {
            ToolbarItem {
                NavigationLink {
                    TransactionDetailView(transactionViewModel: viewModel, transactionAmountValue: 0.00, transactionTypeText: "", ifIsNew: true)
                } label: {
                    Image(systemName: "plus")
                        .symbolRenderingMode(.palette)
                        .foregroundStyle(Color.icon)
                }
            }
        }
        .frame(height: 50)
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
