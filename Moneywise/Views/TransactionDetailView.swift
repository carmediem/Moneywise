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
    
    @Environment(\.managedObjectContext) var managedObjectContext
    
    @Environment(\.dismiss) var dismiss: DismissAction
    
    @State private var date = Date()
    
    //This is what my form for a new transaction should look like
    //  var transaction: Transaction
    @State var transactionDateText: Date = Date()
    @State var transactionNameText: String = ""
    @State var transactionCategoryText: String = ""
    @State var transactionMerchantText: String = ""
    @State var transactionAmountValue: Double = 0.00
    @State var transactionReoccuring: Bool = false
    @State var transactionNoteText: String = ""
    @State var transactionTypeText: String
    @State private var selection = ""
    private let Categories = ["Dining Out", "Education", "Entertainment", "Fitness", "Gift", "Grocery", "Healthcare", "Housing", "Other", "Shopping", "Transportation", "Utilites", "Vacation", "Income", "Investment", "Savings"]
    
    
    private let transactionType = ["Select One", "Income", "Expense"]
 
    private let reOccuringPurchase = ["Select One", "Yes", "No"]
    
    var ifIsNew: Bool
    
    var body: some View {
        VStack {
            Form {
                HStack {
                    Text("Date of Transaction")
                        .bold()
                    
                    DatePicker("", selection: $date,  displayedComponents: .date)
                        .datePickerStyle(CompactDatePickerStyle())
                        .frame(width: 150, height: 50)
                        .frame(alignment: .trailing)
                }
                
                HStack {
                    Text("Transaction Name:")
                        .bold()
                    TextField("Placeholder", text: $transactionNameText)
                }
                
                
                HStack {
                    Text("Category:")
                        .bold()
                    Picker(selection: $transactionCategoryText, label: Text("List of categories"))
                    {
                        ForEach(0 ..< Categories.count) { index in
                            Text(self.Categories[index]).tag(index)
                        }
                    }.pickerStyle(.menu)
                }.frame(width: 150, height: 50)
                    .foregroundColor(.black)
                
                
                HStack {
                    Text("Merchant:")
                        .bold()
                    TextField("Placeholder", text: $transactionMerchantText)
                }
                
                HStack {
                    Text("Amount:")
                        .bold()
                    //         TextField("Placeholder", text: )
                }
                
                HStack {
                    Text(transactionAmountValue, format: .currency(code: "USD"))
                        .bold()
                    //               TextField("Placeholder", text: $transactionAmountValue)
                }
                
                HStack {
                    Text("Reoccuring puchase:")
                        .bold()
                    Picker("Transaction Type:", selection: $selection) {
                        ForEach(reOccuringPurchase, id: \.self) {
                            Text($0)
                        }
                    }.pickerStyle(.menu)
                        .foregroundColor(.black)
                    //  Text(selection)
                }
                
                HStack {
                    Text("Transaction Type:")
                        .bold()
                    Picker("Transaction Type:", selection: $selection) {
                        ForEach(transactionType, id: \.self) {
                            Text($0)
                        }
                    }.pickerStyle(.menu)
                        .foregroundColor(.black)
                }
                
                HStack {
                    Text("Notes:")
                        .bold()
                    
                    TextField("Placeholder", text: $transactionNoteText)
                        .lineLimit(4)
                }
                
                
                //MARK: --Save or Update Button for existing and new entries
                VStack {
                    Button {
                        transactionViewModel.createTransaction(name: transactionNameText, amount: transactionAmountValue, category: transactionCategoryText, date: transactionDateText, isReoccuring: transactionReoccuring, merchant: transactionMerchantText, note: transactionNoteText, type: transactionTypeText)
                        print(transactionViewModel.transactions.count)
                        dismiss()
                    } label: {
                        Spacer()
                        ZStack {
                            Rectangle().fill(.ultraThinMaterial)
                                .cornerRadius(12)
                            Text(transaction == nil ? "Save" : "Update")
                        }
                    }.frame(width: UIScreen.main.bounds.width - 80, height: 40)
                }
                
                //                HStack {
                //                    let date = transaction.date
                //                    let stringDate = DateFormatter.allNumericUSA.string(from: date ?? Date())
                //                    Text(stringDate)
                //                    //  TextField(Date, text: $transactionDateText)
                //                }
                //
                //                HStack {
                //                    Text(transaction.name ?? "TBD")
                //                    TextField("", text: $transactionNameText)
                //                }
                //
                //                HStack {
                //                    Text(transaction.category ?? "TBD")
                //                    TextField("", text: $transactionCategoryText)
                //                }
                //
                //                HStack {
                //                    Text(transaction.category ?? "TBD")
                //                        .font(.footnote)
                //                        .lineLimit(1)
                //                    TextField("", text: $transactionCategoryText)
                //                }
                //
                //                HStack {
                //                    Text(transaction.merchant ?? "TBD")
                //                        .font(.caption)
                //                        .bold()
                //                        .lineLimit(1)
                //                    TextField("", text: $transactionMerchantText)
                //                }
                //
                //
                //                HStack {
                //                    Text(transaction.amount, format: .currency(code: "USD"))
                //                        .bold()
                //                    TextField("Enter $ amount", text: $transactionAmountValue)
                //                }
                //
                //                HStack {
                //                    Text(transaction.isReoccuring = false ?? "TBD")
                //                    TextField("", text: $transactionReoccuring)
                //                }
                //
                //                HStack {
                //                    Text(transaction.note ?? "TBD")
                //                    TextField("", text: $transactionNoteText)
                //                }
            }//end of form
            
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
        
        .onAppear {
            if ifIsNew {  //THIS IS WORKING, DONT DELETE. THIS IS WHAT'S SHOWING UP IN THE PLACEHOLDER TEXT FIELDS
                transactionDateText = Date()
                transactionNameText = ""
                transactionCategoryText = ""
                transactionMerchantText = ""
                transactionAmountValue = 0.00
                transactionReoccuring = false
                transactionNoteText = ""
                
                //            } else {
                //                //THIS IS THE INFO THE PLACEHOLDER DATA IS PULLING
                //                transactionDateText = Date()
                //                transactionNameText = "Babyshower gift"
                //                transactionCategoryText = "Gift"
                //                transactionMerchantText = "Walmart"
                //                transactionAmountValue = 0.0
                //                transactionReoccuring = false
                //                transactionNoteText = "shower for new baby" }
                //        }
            }
            
            
            //    func prepareForCreateEntry() {
            //        let transaction = Transaction(context: managedObjectContext)
            //        transaction.date = transactionDateText
            //        transaction.name = transactionNameText
            //        transaction.category = transactionCategoryText
            //        transaction.merchant = transactionMerchantText
            //        transaction.amount = transactionAmountValue
            //        transactionReoccuring = transactionReoccuring
            //        transaction.note = transactionNoteText
            //
            //        do {
            //            try managedObjectContext.save()
            //            transactionViewModel.transactions.append(transaction)
            //        } catch {
            //            // handle the Core Data error
            //        }
            //        CoreDataStack.saveContext()
            //
            //        dismiss()
            //
            //        }
            //
            //
            //    func prepareForUpdateTransaction() {
            //        //get info from core data
            //    }
            
        }
    }
}

struct TransactionDetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            TransactionDetailView(transactionViewModel: TransactionListViewModel(), transactionDateText: Date(), transactionAmountValue: 0.0, transactionTypeText: "", ifIsNew: false)
        }
    }
}

