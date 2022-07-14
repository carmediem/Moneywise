//
//  TransactionDetailView.swift
//  Moneywise
//
//  Created by Carmen Chiu on 7/12/22.
//

import SwiftUI

struct TransactionDetailView: View {
    //MARK: View Model
    @ObservedObject var transactionViewModel: TransactionListViewModel
    
   var transaction = Transaction()
    @State var transactionDateText: Date
    @State var transactionNameText: String = ""
    @State var transactionCategoryText: String = ""
    @State var transactionMerchantText: String = ""
    @State var transactionAmountValue: String
    @State var transactionReoccuring: Bool = false
    @State var transactionNoteText: String = ""
    
    
    //    Transaction(name: "Groceries", amount: 20, category: "groceries", date: Date(), id: UUID(), isReoccuring: false, merchant: "TraderJoes", note: "none", rating: "neutral", type: "expense")
    //

    var body: some View {
        VStack {
            
            HStack {
                let date = transaction.date
                let stringDate = DateFormatter.allNumericUSA.string(from: date ?? Date())
                Text(stringDate)
                //  TextField(Date, text: $transactionDateText)
            }
            
            HStack {
                Text(transaction.name ?? "TBD")
                TextField("", text: $transactionNameText)
            }
            
            HStack {
                Text(transaction.category ?? "TBD")
                TextField("", text: $transactionCategoryText)
            }
            
            HStack {
                Text(transaction.category ?? "TBD")
                    .font(.footnote)
                    .lineLimit(1)
                TextField("", text: $transactionCategoryText)
            }
            
            HStack {
                Text(transaction.merchant ?? "TBD")
                    .font(.caption)
                    .bold()
                    .lineLimit(1)
                TextField("", text: $transactionMerchantText)
            }
            
            
            HStack {
                Text(transaction.amount, format: .currency(code: "USD"))
                    .bold()
                TextField("Enter $ amount", text: $transactionAmountValue)
            }
            
//            HStack {
//                Text(transaction.isReoccuring = false ?? "TBD")
//                TextField("", text: $transactionReoccuring)
//            }
            
            HStack {
                Text(transaction.note ?? "TBD")
                TextField("", text: $transactionNoteText)
            }
            
            
            
            .navigationTitle("Transaction Details")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink {
                        //Destination
                    } label: {
                        Image(systemName: "save")
                    }
                }
            }
        }
    }
}





struct TransactionDetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            TransactionDetailView(transactionViewModel: TransactionListViewModel(), transactionDateText: Date(), transactionAmountValue: "")
            //   TransactionDetailView(transactionViewModel: TransactionListViewModel())
        }
    }
}
