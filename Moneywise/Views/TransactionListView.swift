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
    
    @State var searchQuery = ""
    //
    //    @FetchRequest(sortDescriptors: [
    //        SortDescriptor(\.Category.Categories)
    //    ])
    //    var transactions: FetchedResults<Transaction>
    
    var transactionList: some View {
        Section(header: SortView()) {
            List {
                ForEach(viewModel.transactions, id: \.self) { transaction in
                    NavigationLink {
                        TransactionDetailView(transaction: transaction)
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
            }
        }
        .listStyle(.plain)
        //        List(viewModel.transactions, id: \.self) { transaction in  // list gives delete option, will also give seperator. for each does not- only lists things out, no extra functionalities
        
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
                    //MARK: -- If there are no transactions
                    if viewModel.transactions.isEmpty {
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
                        //                            .overlay {
                        //                                if viewModel.filteredData.isEmpty {
                        //                                    EmptyView(query: $searchQuery)
                        //                                }
                        //                            }
                            .frame(height: CGFloat(viewModel.transactions.count) * 100 + 25)
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
                }.background(Color.background)
                
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
            //add in picture or animation here to fill up the space
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



