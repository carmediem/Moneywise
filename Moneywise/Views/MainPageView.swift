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
            ScrollView {
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
                
                //MARK: -- Toolbar item to add new entry
                    .toolbar {
                        ToolbarItem {
                            NavigationLink {
                                TransactionDetailView(transactionViewModel: viewModel, transactionAmountValue: 0.00, ifIsNew: true)
                            } label: {
                            Image(systemName: "plus")
                                .symbolRenderingMode(.palette)
                                .foregroundStyle(Color.icon)
                            }
                        }
                    }
            }
                
            //MARK: -- GRAPH OF CATEGORIES

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
        }.background(Color.background)

        }
    }
    }



struct MainPageView_Previews: PreviewProvider {
    static var previews: some View {
        MainPageView()

    }
}
