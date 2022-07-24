//
//  MainPageView.swift
//  Moneywise
//
//  Created by Carmen Chiu on 7/13/22.
//

import SwiftUI

struct MainPageView: View {
    @EnvironmentObject var viewModel: TransactionListViewModel
    //  var authetificationManager = AuthenticationManager()
    
    var body: some View {
        //     if authetificationManager.isAuthenticated {
        NavigationView {
            ScrollView {
                //MARK: header and tab bar items
                VStack {
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

                    GeometryReader {g in
                        ZStack {
                            ForEach(0..<data.count) {i in
                                
                                DrawShape(center: CGPoint(x: g.frame(in: .global).width / 2, y: g.frame(in: .global).height / 2), index: i)
                            }
                        }
                    }
                    .frame(height: 360)
                    .padding(.top, 20)
                    .clipShape(Circle())
                    .shadow(radius: 8)
                                        
                    VStack {
                        ForEach(data) {i in
                            HStack {
                                Text(i.name)
                                    .frame(width: 150)

                                GeometryReader{g in
                                    HStack {
                                        Spacer(minLength: 0)
                                        Rectangle()
                                            .fill(i.color)
                                            .frame(width: self.getWidth(width: g.frame(in: .global).width, value: i.percent), height: 10)
                                        
                                        Text(String(format: "\(i.percent)", "%.0f"))
                                            .fontWeight(.bold)
                                            .padding(.leading, 10)
                                    }
                                }
                            }
                            .padding(.top, 18)
                        }
                    }//end of vstack
                }
            }.background(Color.background)
        }
    }
    
    func getWidth(width: CGFloat, value: CGFloat) -> CGFloat {
        
        let temp = value / 100
        return temp * width
    }
}//end of struct


struct DrawShape: View {
    
    var center: CGPoint
    var index: Int
    
    var body: some View {
        
        Path{path in
            
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
//Placeholder data
//iterate over the rows in the list of transactions to get the total for the month. Format it as the following
var data = [
    Pie(id: 0, percent: 6, name: "Dining", color: Color("Blue")),
    Pie(id: 1, percent: 0, name: "Education", color: Color("BrightPink")),
    Pie(id: 2, percent: 3, name: "Entertainment", color: Color("Yellow")),
    Pie(id: 3, percent: 2, name: "Fitness", color: Color("Orange")),
    Pie(id: 4, percent: 3, name: "Gift", color: Color("Green")),
    Pie(id: 5, percent: 8, name: "Grocery", color: Color("Peach")),
    Pie(id: 6, percent: 2, name: "Healthcare", color: Color("Pink")),
    Pie(id: 7, percent: 38, name: "Housing", color: Color("Purple")),
    Pie(id: 8, percent: 7, name: "Others", color: Color("Red")),
    Pie(id: 9, percent: 4, name: "Shopping", color: Color("Red2")),
    Pie(id: 10, percent: 5, name: "Transportation", color: Color("RoyalBlue")),
    Pie(id: 11, percent: 4, name: "Utilities", color: Color("Teal")),
    Pie(id: 12, percent: 20, name: "Vacation", color: Color("Green")),
]


























//struct MainPageView_Previews: PreviewProvider {
//    static var previews: some View {
//        MainPageView()
//
//    }
//}



//MARK: -- List of most recent transactions- CHANGE TO CATEGORIES IN THIRD SPRINT
//                HStack {
//                    Text("Recent Transactions")
//                        .bold()
//                    NavigationLink {
//                        TransactionListView()
//                    } label: {
//                        HStack(spacing: 4) {
//                            Text("See All")
//                            Image(systemName: "chevron.right")
