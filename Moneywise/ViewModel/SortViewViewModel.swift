//
//  SortViewViewModel.swift
//  Moneywise
//
//  Created by Carmen Chiu on 7/23/22.
//

import SwiftUI

struct SortView: View {
    
    var body: some View {
        HStack(alignment: .center, spacing: 20) {
            Button {
           //     let sortedCategory = Category.Categories.sorted()

            } label: {
            Text("Category")
            }.buttonStyle(.bordered)
            
            Button {
                //
            } label: {
            Text("Month")
            }.buttonStyle(.bordered)
        
            Button {
                let amountSort = NSSortDescriptor(key: "amount", ascending: true)
            } label: {
            Text("$ Max")
            }.buttonStyle(.bordered)
        
            Button {
      //          let sortedAmountMin = Category.amount.sorted { $0 > $1 }
            } label: {
            Text("$ Min")
            }.buttonStyle(.bordered)
        }.frame(alignment: .leading)
    }
}


struct SortView_Previews: PreviewProvider {
    static var previews: some View {
        SortView()
    }
}
