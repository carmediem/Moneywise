//
//  MainPageView.swift
//  Moneywise
//
//  Created by Carmen Chiu on 7/13/22.
//

import SwiftUI
import CoreData

struct MainPageView: View {
    @EnvironmentObject var viewModel: TransactionListViewModel
    
    
    @State var pieGraphData: [Pie] = []
    
    
    var body: some View {
        
        NavigationView {
            ScrollView {
                VStack {
                    VStack(alignment: .center) {
                        Text("Monthly Expenses")
                            .font(.title2)
                            .bold()
                    }
                    .padding(.bottom, 15)
                    
                    HStack {
                        Button {
                            viewModel.filterByPreviousMonth()
                        } label: {
                            Image(systemName: "arrow.left")
                        }
                        
                        Text(getDateStringFromCurrentMonthIndex(currentMonth: currentMonth)) //set the value of the textfield to be the return value of the getDateStringFromCurrentMonthIndex func so its more dynamic. triggered to update when there is a new value in the function
                            .font(.headline)
                        //  .padding(.leading, -140)
                        
                        Button {
                            viewModel.filterByNextMonth()
                            //   viewModel.load() - removing this because we're now loading it from the filter function
                        } label: {
                            Image(systemName: "arrow.right")
                        }
                    }
                    .padding(.bottom,15)
                    
                    .navigationBarTitleDisplayMode(.inline)
                    //                    .frame(maxWidth: .infinity,
                    //                           maxHeight: .infinity)
                    
                    //MARK: -- Toolbar item to add new entry
                    .toolbar {
                        ToolbarItem {
                            NavigationLink {
                                TransactionDetailView()
                            } label: {
                                Image(systemName: "plus")
                                    .symbolRenderingMode(.palette)
                            }
                        }
                    }
                    
                    
                    //MARK: -- Pie Chart. it only loads the first time it goes to the screen. Doesnt load again. Pies are being passed in correctly. Calculations are fine.
                    GeometryReader {g in
                        ZStack {
                            ForEach(0..<viewModel.pie.count, id: \.self) {i in
                                DrawShape(center: CGPoint(x: g.frame(in: .global).width / 2, y: g.frame(in: .global).height / 2), index: i)
                            }
                        }
                    }
                    .frame(height: 290)
                    .padding(.top, 20)
                    .clipShape(Circle())
                    
                    
                    //MARK: -- Categories and percentages for bar chart. THIS PART UPDATES
                    VStack {
                        ForEach(viewModel.pie) {category in
                            HStack {
                                Text(category.name)
                                    .frame(width: 150)
                                
                                GeometryReader{g in
                                    HStack {
                                        Spacer(minLength: 0)
                                        Rectangle()
                                            .fill(category.color)
                                            .frame(width: self.getWidth(width: g.frame(in: .global).width, value: category.percent), height: 5)
                                        
                                        
                                        Text(String(format: "%.2f", category.percent))
                                            .fontWeight(.bold)
                                            .padding(.leading, 10)
                                            .padding(.trailing, 30)
                                    }
                                }
                            }
                            .padding(.top, 10)
                        }
                    }
                }//end of vstack
                .onReceive(viewModel.$pie) { pie in
                    //   self.pieGraphData = pie
                    print("Pie data: \(pie.count)")
                    
                }
            }
            .background(Color.background)
        }
    }
    
    func getWidth(width: CGFloat, value: CGFloat) -> CGFloat {
        let temp = value / 100
        return temp * width
    }
    
}//end of struct


// MARK: -- Struct for build out of the pie chart
struct DrawShape: View {
    @EnvironmentObject var viewModel: TransactionListViewModel
    
    var center: CGPoint
    var index: Int
    
    var body: some View {
        
        Path { path in
            //Path is the outline of the 2D shape
            path.move(to: self.center)
            path.addArc(center: self.center, radius: 180, startAngle: .init(degrees: self.from()), endAngle: .init(degrees: self.to()), clockwise: false)
        }
        .fill(index >= viewModel.pie.count ? Color.clear : viewModel.pie[index].color)
        
    }
    
    //since an angle is continuous, we'll need to calculate the angles before and add with the current to get the exact angle
    func from() -> Double {
        if index == 0 {
            return 0
            
        } else {
            var temp: Double = 0
            for i in 0..<index {  //up to but not including index
                if viewModel.pie.isEmpty {
                    temp += 0
                } else {
                    if index < viewModel.pie.count {
                        temp += Double(viewModel.pie[i].percent / 100) * 360
                    }
                }
            }
            return temp
        }
    }
    
    func to() -> Double {   //convert percent to an angle
        var temp: Double = 0
        //need the current degree
        for i in 0...index {
            if viewModel.pie.isEmpty {
                temp += 0
            } else {
                print("Index: \(index)")
                print("PieCount: \(viewModel.pie.count)")
                print("Array index: \(i)")
                
                if index < viewModel.pie.count {
                    temp += Double(viewModel.pie[i].percent / 100) * 360
                }
            }
        }
        return temp
    }
}

struct Pie: Identifiable, Equatable {
    var id: Int
    var percent: CGFloat
    var name: String
    var color: Color
}


//MARK: -- Fetching the Transactions
func getTransactions() -> [Transaction] {
    let request = NSFetchRequest<Transaction>(entityName: "Transaction")
    request.sortDescriptors = [NSSortDescriptor(key: #keyPath(Transaction.name), ascending: false)]
    let transactions = (try? PersistenceController.shared.container.viewContext.fetch(request)) ?? []
    return transactions
}



//MARK: -- loading the transaction data.


var currentMonth = Calendar.current.component(.month, from: Date()) - 1
//set current month variable using info from currentMonthNumber. Is an Int so need to make it a string using the getDateStringFromCurrentMonthIndex

func updateMonth(updatedMonth: Int) {
    currentMonth = updatedMonth
    
}

//var data = loadTransactionData(transactions: getTransactions())


func getDateStringFromCurrentMonthIndex(currentMonth: Int) -> String {
    let monthsArray = ["JANUARY","FEBRUARY","MARCH","APRIL","MAY","JUNE","JULY","AUGUST","SEPTEMBER","OCTOBER","NOVEMBER","DECEMBER"]
    return monthsArray[currentMonth] //when this funtion is called, want it to return the current month index, which is 7 which is August
}

struct MainPageView_Previews: PreviewProvider {
    static var previews: some View {
        MainPageView()
        
    }
}



//data var and the loading method..
