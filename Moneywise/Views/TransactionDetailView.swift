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
    @State var category: Category.Categories = .Investment
    @State var transactionMerchantText: String = ""
    @State var transactionAmountValue: Double = 0.00
    @State var transactionReoccuring: Bool = false
    @State var transactionNoteText: String = ""
    @State var categoryType: Category.Categories.ExpenseType = .all
    @State private var selection = ""
    
 
    private let reOccuringPurchase = ["Select One", "Yes", "No"]
    
    var ifIsNew: Bool
    
    var body: some View {
        VStack {
            Form {
                HStack {
                    Text("Date")
                        .bold()
                    DatePicker("", selection: $date,  displayedComponents: .date)
                        .datePickerStyle(CompactDatePickerStyle())
                        .frame(width: 150, height: 50)
                        .frame(alignment: .trailing)
                }
                
                HStack {
                    Text("Name:")
                        .bold()
                    TextField("Placeholder", text: $transactionNameText)
                }
                
                
                HStack {
                    Text("Category:")
                        .bold()
                    Picker(selection: $category, label: Text("List of categories"))
                    {
                        ForEach(Category.Categories.allCases, id: \.self) { category in
                            Text(category.rawValue)
                                .onTapGesture {
                                    self.category = category
                                }
                        }
                    }.pickerStyle(.menu)
                }.frame(width: 150, height: 50)
                
                HStack {
                    Text("Merchant:")
                        .bold()
                    TextField("Placeholder", text: $transactionMerchantText)
                }
                
                HStack {
                    Text("Amount:   $")
                        .bold()
             //      TextField("Placeholder", text: 0.00)
                }
                
                HStack {
                    Text(transactionAmountValue, format: .currency(code: "USD"))
                        .bold()
                    //               TextField("Placeholder", text: $transactionAmountValue)
                }
                
                HStack {
                    Text("Transaction Type:")
                        .bold()
                    Picker("Transaction Type:", selection: $categoryType) {
                        ForEach(Category.Categories.ExpenseType.allCases, id: \.self) { categoryType in
                            Text(categoryType.rawValue)
                                .onTapGesture {
                                    self.categoryType = categoryType
                                }
                        }
                    }.pickerStyle(.menu)
                        .foregroundColor(.black)
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
                }
      
                HStack {
                    Text("Notes:")
                        .bold()
                    
                    TextField("Placeholder", text: $transactionNoteText)
                        .lineLimit(4)
                }
                HStack {
                    
                }
                
                //MARK: --Save or Update Button for existing and new entries
//                VStack {
//                    Button {
//                        transactionViewModel.createTransaction(name: transactionNameText, amount: transactionAmountValue, category: transactionCategoryText, date: transactionDateText, isReoccuring: transactionReoccuring, merchant: transactionMerchantText, note: transactionNoteText, type: transactionTypeText)
//                        print(transactionViewModel.transactions.count)
//                        dismiss()
//                    } label: {
//                        Spacer()
//                        ZStack {
//                            Rectangle().fill(.ultraThinMaterial)
//                                .cornerRadius(12)
//                            Text(transaction == nil ? "Save" : "Update")
//                        }
//                    }.frame(width: UIScreen.main.bounds.width - 80, height: 40)
//                }
                
            }//end of form
            
            .navigationTitle("Transaction Details")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        transactionViewModel.createTransaction(name: transactionNameText, amount: transactionAmountValue, category: category.rawValue, date: transactionDateText, isReoccuring: transactionReoccuring, merchant: transactionMerchantText, note: transactionNoteText, type: categoryType.rawValue, imageName: category.CategoryImage)
                       print(transactionViewModel.transactions.count)
                        dismiss()
                    } label: {
                        Text("Save")
                    }
                }
            }
        }
        
        .onAppear {
//            if ifIsNew {  //THIS IS WORKING, DONT DELETE. THIS IS WHAT'S SHOWING UP IN THE PLACEHOLDER TEXT FIELDS
//                transactionDateText = Date()
//                transactionNameText = ""
//                transactionCategoryText = ""
//                transactionMerchantText = ""
//                transactionAmountValue = 10.00
//                transactionReoccuring = false
//                transactionNoteText = "Test for notes"
//
//                            } else {
//                                //THIS IS THE INFO THE PLACEHOLDER DATA IS PULLING
//                                transactionDateText = Date()
//                                transactionNameText = "Babyshower gift"
//                                transactionCategoryText = "Gift"
//                                transactionMerchantText = "Walmart"
//                                transactionAmountValue = 0.0
//                                transactionReoccuring = false
//                                transactionNoteText = "shower for new baby" }
                        }
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
            //        }

    }


//struct TransactionDetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        NavigationView {
//            TransactionDetailView(transactionViewModel: TransactionListViewModel(), managedObjectContext: Date(), dismiss: 0.0, transactionDateText: "", transactionNameText: false, ifIsNew: false)
//        }
//    }
//}
//
