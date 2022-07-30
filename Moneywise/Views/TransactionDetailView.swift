//
//  TransactionDetailView.swift
//  Moneywise
//
//  Created by Carmen Chiu on 7/12/22.
//

import SwiftUI

struct TransactionDetailView: View {
    //MARK: View Model
    @EnvironmentObject var transactionViewModel: TransactionListViewModel
    
    @Environment(\.managedObjectContext) var managedObjectContext
    
    @Environment(\.dismiss) var dismiss: DismissAction
    
   // @State private var date = Date()
    
    @State var transaction: Transaction?
    
    
    func setUpViews() {
        guard let transaction = transaction else { return }
        transactionDateText = transaction.date ?? transactionDateText
        transactionNameText = transaction.name ?? ""
        category = Category.Categories(rawValue: transaction.category ?? "" ) ?? .Vacation
        transactionMerchantText = transaction.merchant ?? ""
        transactionAmountValue = "\(transaction.amount)"
        categoryType  = Category.Categories.ExpenseType(rawValue: transaction.type ?? "") ?? .all
        transactionNoteText = transaction.note ?? ""
        transactionImage = ImageStorage.shared.loadImageFromDocumentDirectory(nameOfImage: transaction.name!)
        print("transactionImage")
        print(transactionImage)
    }
    
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
    @State var transactionImage: UIImage? = nil
    @State private var selection = ""
    var transactionValue: Double {
        Double(transactionAmountValue) ?? 0.00
    }
    
    private let reOccuringPurchase = ["Select One", "Yes", "No"]
    
    var body: some View {
        VStack {
            Form {
                HStack {
                    Text("Date")
                        .bold()
                    DatePicker("", selection: $transactionDateText,  displayedComponents: .date)
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
                        if uploadTransactionPhoto {
                            Image(uiImage: imageSelected)
                                .resizable()
                                .frame(width: 120, height: 120)
                        } else {
                            if transactionImage != nil {
                                Image(uiImage: transactionImage!)
                                    .resizable()
                                    .frame(width: 120, height: 120)
                            } else {
                            Image("receipt")
                                .resizable()
                                .frame(width: 140, height: 140)
                        }
                        }
                    })   .buttonStyle(.bordered)
                        .frame(alignment: .center)
                    
                }.sheet(isPresented: $openCameraRoll) {
                    ImagePicker(selectedImage: $imageSelected, sourceType: .photoLibrary, transaction: transaction!)
                    
                }
            }
        }
        .onAppear {
            setUpViews()
        }.background(Color.background).opacity(30)
        //end of form
        
        .navigationTitle("Transaction Details")
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    if transaction == nil {
                        transactionViewModel.createTransaction(name: transactionNameText, amount: transactionValue, category: category.rawValue, date: transactionDateText, isReoccuring: transactionReoccuring, merchant: transactionMerchantText, note: transactionNoteText, type: categoryType.rawValue, imageName: category.CategoryImage)
                    } else {
                        transactionViewModel.updateTransaction(
                            transaction,
                            name: transactionNameText,
                            amount: transactionValue,
                            category: category.rawValue,
                            date: transactionDateText,
                            isReoccuring: transactionReoccuring,
                            merchant: transactionMerchantText,
                            type: categoryType.rawValue,
                            note: transactionNoteText,
                            imageName: category.CategoryImage
                        )
                    dismiss()
                    }
                } label: {
                    Text("Save")
                }
            }
        }
        
    }
}



struct TransactionDetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            TransactionDetailView()
        }
    }
}

