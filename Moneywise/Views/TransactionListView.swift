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
    
    
    var transactionList: some View {
        Section(header: SortView()) {
            List {
                ForEach(viewModel.transactions, id: \.self) { transaction in
                    //Section header to group the entries by month
                    NavigationLink {
                        TransactionDetailView(transactionViewModel: viewModel, ifIsNew: false)
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
                                        TransactionDetailView(transactionViewModel: viewModel, ifIsNew: true)
                                    } label: {
                                        Image(systemName: "plus")
                                            .symbolRenderingMode(.palette)
                                    }
                                }
                            }
                    } else {
                        //MARK: -- IF THERE ARE TRANSACTION, LIST THEM OUT, ALLOW THE USER TO SORT BY DATE AND LIST OUT BY CATEGORIES
                        //MARK: -- Filter by date and category
                        
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
                                        TransactionDetailView(transactionViewModel: viewModel, ifIsNew: true)
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
        .onAppear {
            TransactionDetailView(transactionViewModel: viewModel, ifIsNew: true)
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



////MARK: Adding Sections
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
