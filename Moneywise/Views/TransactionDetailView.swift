//
//  TransactionDetailView.swift
//  Moneywise
//
//  Created by Carmen Chiu on 7/12/22.
//

import SwiftUI

struct TransactionDetailView: View {
    //MARK: Landing Pad
    
    var transaction = Transaction(name: "Groceries", amount: 20, category: "groceries", date: Date(), id: UUID(), isReoccuring: false, merchant: "TraderJoes", note: "none", rating: "neutral", type: "expense")
    
    //MARK: View Model
    @ObservedObject var transactionViewModel: TransactionListViewModel
    
    var body: some View {
        
    
        
        //MARK: Transaction Row cells
        HStack {
           //icon
        }
        
        VStack {
            Text(transaction.merchant ?? "TBD")
                .font(.caption)
                .bold()
                .lineLimit(1)
            
            Text(transaction.category ?? "TBD")
                .font(.footnote)
                .lineLimit(1)
            
//          Text(String(transaction.date) ?? String(Date())
               
                 
        Spacer()
        Text(transaction.amount, format: .currency(code: "USD"))
            .bold()
        
        
        }
    }
}

struct TransactionDetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
     TransactionDetailView(transactionViewModel: TransactionListViewModel())
    }
}
}
