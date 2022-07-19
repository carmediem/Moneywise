//
//  MainPageView.swift
//  Moneywise
//
//  Created by Carmen Chiu on 7/13/22.
//

import SwiftUI

struct MainPageView: View {
   
    
    var body: some View {
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
                
                
                    .toolbar {
                        ToolbarItem {
                            Image(systemName: "plus")
                                .symbolRenderingMode(.palette)
                                .foregroundStyle(Color.icon)
                        }
                        ToolbarItem {
                            Image(systemName: "gear")
                                .symbolRenderingMode(.palette)
                                .foregroundStyle(Color.icon)
                                
                        }
                        
                    }
                //MARK: -- List of most recent transactions
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
        }
    }
    
}

struct MainPageView_Previews: PreviewProvider {
    static var previews: some View {
        MainPageView()
    }
}
