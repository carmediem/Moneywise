//
//  TransactionRowViewModel.swift
//  Moneywise
//
//  Created by Carmen Chiu on 7/22/22.
//

import SwiftUI

struct TransactionRowView: View {
    
    @EnvironmentObject var viewModel: TransactionListViewModel
    
    var transaction: Transaction
    
    var body: some View {
        HStack {
            Image(transaction.imageName ?? "" )
                .resizable()
                .frame(width: 30, height: 40, alignment: .leading)
                .padding(.leading, 5)
            
            
            VStack (alignment: .leading) {
                Text(transaction.name ?? "Unknown")
                    .bold()
                    .font(.headline)
                    .padding(.trailing, -90)
                Text(transaction.category ?? "Unknown")
                    .font(.system(size: 14))
                let date = transaction.date
                let stringDate = DateFormatter.allNumericUSA.string(from: date ?? Date())
                Text(stringDate)
                    .font(.system(size: 14))
            }  .padding(.leading, 30)
                .padding(.trailing, 80)
         
            
            Text(String(format: "%.2f", transaction.amount))
                .font(.system(size: 18))
               .frame(width: 90, alignment: .trailing)
               .listRowInsets(EdgeInsets())
                .foregroundColor(Category.Categories.ExpenseType(rawValue: transaction.type ?? "all")?.color)
        }
//        .onAppear
//        {
//            print(transaction)
//        }
        .toolbar {
            ToolbarItem {
                NavigationLink {
                    TransactionDetailView()
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
