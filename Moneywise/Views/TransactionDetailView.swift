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
    
    var transaction: Transaction?
    
    //For uploading image
    @State var uploadTransactionPhoto = false
    @State var openCameraRoll = false
    @State var imageSelected = UIImage()
    
    @State var transactionDateText: Date = Date()
    @State var transactionNameText: String = ""
    @State var category: Category.Categories = .SelectOne
    @State var transactionMerchantText: String = ""
    @State var transactionAmountValue: String = ""
    @State var transactionReoccuring: Bool = false
    @State var transactionNoteText: String = ""
    @State var categoryType: Category.Categories.ExpenseType = .Selection
    @State private var selection = ""
    var transactionValue: Double {
        Double(transactionAmountValue) ?? 0.00
    }
    var ifIsNew: Bool
    
    private let reOccuringPurchase = ["Select One", "Yes", "No"]
    
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
                }.frame(height: 30)
                
                HStack {
                    Text("Merchant:")
                        .bold()
                    TextField("Placeholder", text: $transactionMerchantText)
                }
                
                HStack {
                    Text("Amount:   $")
                        .bold()
                    TextField("Placeholder", text: $transactionAmountValue)
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
                
                VStack (alignment: .leading) {
                    Text("Upload Photo")
                        .bold()
                    
                    Button(action: {
                        uploadTransactionPhoto = true
                        openCameraRoll = true
                        print("Upload photo of transaction")
                    }, label: {
                        // Text("")
                        if uploadTransactionPhoto {
                            Image(uiImage: imageSelected)
                                .resizable()
                                .frame(width: 120, height: 120)
                        } else {
                            Image("receipt")
                                .resizable()
                                .frame(width: 140, height: 140, alignment: .center)
                        }
                        
                    })   .buttonStyle(.bordered)
                        .frame(alignment: .center)
                    
                }.sheet(isPresented: $openCameraRoll) {
                    ImagePicker(selectedImage: $imageSelected, sourceType: .photoLibrary)
                    
                }
                
            }
        }
        //end of form
        
        .navigationTitle("Transaction Details")
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    transactionViewModel.createTransaction(name: transactionNameText, amount: transactionValue, category: category.rawValue, date: transactionDateText, isReoccuring: transactionReoccuring, merchant: transactionMerchantText, note: transactionNoteText, type: categoryType.rawValue, imageName: category.CategoryImage)
                    print(transactionViewModel.transactions.count)
                    dismiss()
                } label: {
                    Text("Save")
                }
            }
        }
    }
//        .onAppear {
//            if let transaction = transaction {
//                transactionDateText = transaction.date ?? date
//                transactionNameText =  transaction.name
//                category = transaction.category
//                transactionMerchantText = transaction.transactionMerchantText
//                transactionAmountValue = transaction.transactionAmountValue
//                transactionReoccuring = transaction.isReoccurring
//                transactionNoteText = transaction.note
//            categoryType: Category.Categories.ExpenseType = transaction.categoryType
//                var transactionValue: Double {
//                    Double(transactionAmountValue) ?? 0.00
//                }
//            }
//        }
}
//            if ifIsNew {  //THIS IS WORKING, DONT DELETE. THIS IS WHAT'S SHOWING UP IN THE PLACEHOLDER TEXT FIELDS
//                transactionDateText = Date()
//                transactionNameText = ""
//         //       Category.Categories = ""
//                transactionMerchantText = ""
//        //        transactionAmountValue = 10.00
//                transactionReoccuring = false
//                transactionNoteText = "Test for notes"

//                            } else {
//                                //THIS IS THE INFO THE PLACEHOLDER DATA IS PULLING
//                                transactionDateText = Date()
//                                transactionNameText = "Babyshower gift"
//             //                   Category.Categories = "Gift"
//                                transactionMerchantText = "Walmart"
//               //                 transactionAmountValue = 0.0                   transactionReoccuring = false
//                                transactionNoteText = "shower for new baby" }

// }


//struct TransactionDetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        NavigationView {
//            TransactionDetailView(transactionViewModel: TransactionListViewModel(), managedObjectContext: Date(), dismiss: 0.0, transactionDateText: "", transactionNameText: false, ifIsNew: false)
//        }
//    }
//}

