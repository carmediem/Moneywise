//
//  MainPageView.swift
//  Moneywise
//
//  Created by Carmen Chiu on 7/13/22.
//

import SwiftUI

struct MainPageView: View {
    @EnvironmentObject var viewModel: TransactionListViewModel
  //  var authetificationManager = AuthenticationManager()
    
    var body: some View {
   //     if authetificationManager.isAuthenticated {
        NavigationView {
            //MARK: header and tab bar items
            ZStack {
                VStack {
                    Text("Overview")
                        .font(.title2)
                        .bold()
                    Text("Total Expenses")
                        .font(.title2)
                    Spacer()
                }.navigationBarTitleDisplayMode(.inline)
                    .frame(maxWidth: .infinity,
                           maxHeight: .infinity)
                    .background(Color.background)
                
                //MARK: -- Toolbar
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
            }
            //MARK: -- List of most recent transactions- CHANGE TO CATEGORIES IN THIRD SPRINT
            HStack {
                Text("Recent Transactions")
                    .bold()
                NavigationLink {
                    TransactionListView()
                } label: {
                    HStack(spacing: 4) {
                        Text("See All")
                        Image(systemName: "chevron.right")
                    }
                }
            }
        }
        
        //MARK: -- Tab view to navigate across different pages
//        TabView {
//            MainPageView()
//                .tabItem {
//                    Label("Overview", systemImage: "chart.pie")
//                }
//            TransactionListView()
//                .tabItem {
//                    Label("List", systemImage: "list.bullet")
//                }
//            CurrencyConverterView()
//                .tabItem {
//                    Label("Converter", systemImage: "dollarsign.circle")
//                }
//                .environment(\.managedObjectContext, dataController.container.viewContext)
//
        }
    }
//}


struct MainPageView_Previews: PreviewProvider {
    static var previews: some View {
        MainPageView()

    }
}
