//
//  MainPageViewModel.swift
//  Moneywise
//
//  Created by Carmen Chiu on 7/21/22.
//

import SwiftUI

struct MainPageViewModel: View {
     var transactions: FetchedResults<Transaction>
    
    @State private var currentMonth = 0
    @State private var month = Calendar.current.date(byAdding: .month, value: 0, to: Date())
    
//    var filteredTransactions: [Transaction] {
//        return transactions.filter { Calendar.current.isDateInMonth($0.timestamp, currentMonth) }
//    }
    
    var body: some View {
        Section {
//            HStack() {
//                Button {
//                    let currentMonth = currentMonth - 1
//                } label: {
//                    Label("Previous Month", systemImage: "chevron.left")
//                        .labelStyle(.iconOnly)
//                }
//                .buttonStyle(PlainButtonStyle())
//                .foregroundColor(.blue)
//                .onChange(of: currentMonth) { newValue in
//                    month = Calendar.current.date(byAdding: .month, value: newValue, to: Date())
//                }
//                Spacer()
//                Text(month!, formatter: monthDateFormatter)
//                Spacer()
//                Button {
//                    let currentMonth = currentMonth + 1
//                } label: {
//                    Label("Next Month", systemImage: "chevron.right")
//                        .labelStyle(.iconOnly)
//                }
//                .buttonStyle(PlainButtonStyle())
//                .foregroundColor(.blue)
//            }
            //.padding(.horizontal)
            
        }
    }
}

let monthDateFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateFormat = "MMMM YYYY"
    return formatter
}()


//
//
//struct MainPageViewModel_Previews: PreviewProvider {
//    static var previews: some View {
//        MainPageViewModel()
//    }
//}
