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
    //  var authetificationManager = AuthenticationManager()
    
    var body: some View {
        //     if authetificationManager.isAuthenticated {
        NavigationView {
            ScrollView {
                //MARK: header and tab bar items
                VStack {
//                    Color("background").edgesIgnoringSafeArea(.all)
                    ZStack {
                        VStack {
                            Text("Overview")
                                .font(.title2)
                                .bold()
                            Text("Total Expenses")
                                .font(.title2)
                            Spacer()
                        }
                        
                        .navigationBarTitleDisplayMode(.inline)
                        .frame(maxWidth: .infinity,
                               maxHeight: .infinity)
                        
                        //MARK: -- Toolbar item to add new entry
                        .toolbar {
                            ToolbarItem {
                                NavigationLink {
                                    TransactionDetailView(transactionViewModel: viewModel, ifIsNew: true)
                                } label: {
                                    Image(systemName: "plus")
                                        .symbolRenderingMode(.palette)
                                        .foregroundStyle(Color.icon)
                                }
                            }
                        }
                    }

                    //MARK: -- Pie CHart
                    GeometryReader {g in
                        ZStack {
                            ForEach(0..<data.count) {i in
                                DrawShape(center: CGPoint(x: g.frame(in: .global).width / 2, y: g.frame(in: .global).height / 2), index: i)
                            }
                        }
                    }
                    .frame(height: 290)
                    .padding(.top, 20)
                    .clipShape(Circle())


                    //MARK: -- Categories and percentages
                    VStack {
                        ForEach(data) {category in
                            HStack {
                                Text(category.name)
                                    .frame(width: 150)

                                GeometryReader{g in
                                    HStack {
                                        Spacer(minLength: 0)
                                        Rectangle()
                                            .fill(category.color)
                                            .frame(width: self.getWidth(width: g.frame(in: .global).width-50, value: category.percent), height: 5)

                                        Text(String(format: "%.2f", category.percent))
                                            .fontWeight(.bold)
                                            .padding(.leading, 10)
                                            .padding(.trailing, 30)
                                    }
                                }
                            }
                            .padding(.top, 10)
                        }
                    }//end of vstack
                }
            }
            .background(Color.background).ignoresSafeArea(.all)
        }
    }

    func getWidth(width: CGFloat, value: CGFloat) -> CGFloat {
        let temp = value / 100
        return temp * width
    }
}//end of struct


// MARK: -- Struct for build out of the pie chart
struct DrawShape: View {

    var center: CGPoint
    var index: Int

    var body: some View {

        Path{path in
            //Path is the outline of the 2D shape
            path.move(to: self.center)
            path.addArc(center: self.center, radius: 180, startAngle: .init(degrees: self.from()), endAngle: .init(degrees: self.to()), clockwise: false)
        }
        .fill(data[index].color)
    }

    //since an angle is continuous, we'll need to calculate the angles before and add with the current to get the exact angle
    func from() -> Double {
        if index == 0 {
            return 0
        }
        else {
            var temp: Double = 0
            for i in 0...index-1 {
                temp += Double(data[i].percent / 100) * 360
            }
            return temp
        }
    }

    func to() -> Double {   //convert percent to an angle
        var temp: Double = 0
        //need the current degree
        for i in 0...index {
            temp += Double(data[i].percent / 100) * 360
        }
        return temp
    }
}

struct Pie: Identifiable {
    var id: Int
    var percent: CGFloat
    var name: String
    var color: Color
}


func loadTransactionData() -> [Pie] {
    let request = NSFetchRequest<Transaction>(entityName: "Transaction")
    request.sortDescriptors = [NSSortDescriptor(key: #keyPath(Transaction.name), ascending: false)]

    do {
        let transactions = try? PersistenceController.shared.container.viewContext.fetch(request)
        var total = 0.0;
        var categories: [String : Double] = [:]
        let ignoredCategories = ["Income", "Savings", "Investment"]
        transactions?.forEach{transaction in
            if(!ignoredCategories.contains(transaction.category ?? "Other")){
                total += transaction.amount
                if (categories[transaction.category ?? "Other"] == nil){
                    categories[transaction.category ?? "Other"] = transaction.amount
                }else{
                    categories[transaction.category ?? "Other"]! += transaction.amount
                }
            }
        }
        var pies: [Pie] = []
        var id = 0
        let colors = ["Blue", "BrightPink", "Yellow", "Orange", "Red", "Peach", "Pink", "Purple", "Red", "RoyalBlue", "Teal", "Green", "Mustard", "Green2"]
        categories.forEach { category in
            let percent = (category.value / total)
            pies.append(Pie(id: id, percent: CGFloat(percent*100), name: category.key, color: Color(colors[id] )))
            id += 1
        }
        return pies
    } catch {
        print(error)
    }
}


var data = loadTransactionData()


struct MainPageView_Previews: PreviewProvider {
    static var previews: some View {
        MainPageView()

    }
}
