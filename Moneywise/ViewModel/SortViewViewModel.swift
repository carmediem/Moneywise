//
//  SortViewViewModel.swift
//  Moneywise
//
//  Created by Carmen Chiu on 7/23/22.
//

import SwiftUI

struct SortView: View {
    
    @ObservedObject var transactionListViewModel: TransactionListViewModel
    //want to be able to update the state object that underlies the sort view. need to access viewmodel
 
    var body: some View {
        HStack(alignment: .center, spacing: 20) {
            Button {
                transactionListViewModel.sortByCategory()
            } label: {
            Text("Category")
            }.buttonStyle(.bordered)
       
            
            Button {
                transactionListViewModel.sortByMonth()
            } label: {
            Text("Month")
            }.buttonStyle(.bordered)
        
            Button {
                transactionListViewModel.sortByMax()
            } label: {
            Text("$ Max")
            }.buttonStyle(.bordered)
        
            Button {
                transactionListViewModel.sortByMin()
            } label: {
            Text("$ Min")
            }.buttonStyle(.bordered)
        }.frame(alignment: .leading)
    }
}

