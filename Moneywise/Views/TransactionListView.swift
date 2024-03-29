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
    
    @Environment(\.managedObjectContext) var managedObjectContext
    
    @State var searchQuery = ""

    @FetchRequest(entity: Transaction.entity(), sortDescriptors: [NSSortDescriptor(key: #keyPath(Transaction.name), ascending: false)])
        //added this in to fix the search which was only searching filteredtransactions. FetchRequest to get fetchedresults for allTransaction
    
    var allTransactions: FetchedResults<Transaction>
    
    var transactionList: some View {
        
        Section(header: SortView(transactionListViewModel: viewModel)) {
            List {
                ForEach(viewModel.filteredTransactions, id: \.self) { filteredTransactions in
                    NavigationLink {
                        TransactionDetailView(transaction: filteredTransactions)
                    } label: {
                        TransactionRowView(transaction: filteredTransactions)
                    }
                    .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                        Button("Delete", role: .destructive) {
                            if let id = filteredTransactions.transactionId {
                                viewModel.removeTransaction(transaction: filteredTransactions, with: PersistenceController.shared.container.viewContext, uuid: "\(id)")
                            }
                        }
                    }
                }
            }
        }
        .listStyle(.plain)

        .navigationTitle("List of Transactions")
        
        //MARK: -- Search Bar
        .searchable(text: $searchQuery, placement: .navigationBarDrawer(displayMode: .always),
                    prompt: "Search your transactions")
        .onSubmit(of: .search) {
            viewModel.search(with: searchQuery)
        }
        .onChange(of: searchQuery) { newQuery in   //query is not binding, just listening for changes. modifier is onChange. Whenever the value changes, we'll get a new query to make the search. listening to the changes to the State variable
            viewModel.search(with: newQuery)
        }
        .onAppear {
            viewModel.search() //gives you the list of transactions
        }
    }
    
    
    var body: some View {
        NavigationView {
            VStack {
                ScrollView {
                    //MARK: -- If there are no transactions
                    if allTransactions.isEmpty {
                        EmptyTransactionTitle()
                            .padding(.top)
                            .toolbar {
                                ToolbarItem {
                                    NavigationLink {
                                        TransactionDetailView()
                                    } label: {
                                        Image(systemName: "plus")
                                            .symbolRenderingMode(.palette)
                                    }
                                }
                            }
                    } else {
                        
                        //MARK: List of entries
                        transactionList
                            .frame(height: CGFloat(viewModel.filteredTransactions.count) * 100 + 25)
                            .navigationBarTitleDisplayMode(.inline)
                            .toolbar {
                                ToolbarItem {
                                    NavigationLink {
                                        TransactionDetailView()
                                    } label: {
                                        Image(systemName: "plus")
                                            .symbolRenderingMode(.palette)
                                    }
                                }
                            }
                    }
                }
                .background(Color.background)
                
            }.navigationTitle("List of Transactions")
            
        }
    }
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



