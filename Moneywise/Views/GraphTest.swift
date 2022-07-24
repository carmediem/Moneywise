////
////  GraphTest.swift
////  Moneywise
////
////  Created by Carmen Chiu on 7/24/22.
////
//
//import SwiftUI
////
////struct GraphTest: View {
////    var body: some View {
////
////
////        Home()
////    }
////}
////
////struct GraphTest_Previews: PreviewProvider {
////    static var previews: some View {
////        GraphTest()
////    }
////}
//
//
//struct Home: View {
//    
//    var body: some View {
//        
//        VStack {
//            
//            ZStack {
//                
//                HStack {
//                    
//                    Button(action: {
//                        
//                    }) {
//                        
//                        Image(systemName: "line.horizonta.3")
//                            .resizable()
//                            .frame(width: 20, height: 15)
//                            .foregroundColor(.black)
//                    }
//                    
//                    Spacer()
//                    
//                    Button(action: {
//                        
//                    }) {
//                        
//                        Image(systemName: "bell.fill")
//                            .foregroundColor(.black)
//                    }
//                }
//            }
//            Text("My Usage")
//                .fontWeight(.bold)
//                .padding(.top, UIApplication.shared.windows.first?.safeAreaInsets.top)
//                .padding()
//                .overlay(Rectangle().stroke(Color.black.opacity(0.05), lineWidth: 2))
//            
//            
//            
//            
//            GeometryReader {g in
//                
//                ZStack {
//                    
//                    ForEach(0..<data.count) {i in
//                        
//                        DrawShape(center: CGPoint(x: g.frame(in: .global).width / 2, y: g.frame(in: .global).height / 2), index: i)
//                    }
//                }
//            }
//            .frame(height: 360)
//            .padding(.top, 20)
//            //need to clip it so it stays in a cirlc shape
//            .clipShape(Circle())
//            .shadow(radius: 8)
//            
//            //the radius is 180 so the circle size will be 360
//            
//            VStack {
//                
//                ForEach(data) {i in
//                    
//                    HStack {
//                        
//                        Text(i.name)
//                            .frame(width: 100)
//                        
//                        //fixed width
//                        
//                        GeometryReader{g in
//                            
//                            HStack {
//                                
//                                Spacer(minLength: 0)
//                                
//                                Rectangle()
//                                    .fill(i.color)
//                                    .frame(width: self.getWidth(width: g.frame(in: .global).width, value: i.percent), height: 10)
//                                
//                                
//                                Text(String(format: "\(i.percent)", "%.0f"))
//                                    .fontWeight(.bold)
//                                    .padding(.leading, 10)
//                            }
//                        }
//                    }
//                    .padding(.top, 18)
//                }
//            }//end of vstack
//            .padding()
//            
//            Spacer()
//        }
//        .edgesIgnoringSafeArea(.top)
//    }
//    
//    
//    
////    func getWidth(width: CGFloat, value: CGFloat) -> CGFloat {
////
////        let temp = value / 100
////        return temp * width
////    }
//}
////
////struct DrawShape: View {
////
////    var center: CGPoint
////    var index: Int
////
////    var body: some View {
////
////        Path{path in
////
////            path.move(to: self.center)
////            path.addArc(center: self.center, radius: 180, startAngle: .init(degrees: self.from()), endAngle: .init(degrees: self.to()), clockwise: false)
////        }
////        .fill(data[index].color)
////    }
////
////    //since an angle is continuous, we'll need to calculate the angles before and add with the current to get the exact angle
////
////    func from() -> Double {
////
////        if index == 0 {
////
////            return 0
////        }
////        else {
////
////            var temp: Double = 0
////
////            for i in 0...index-1 {
////
////                temp += Double(data[i].percent / 100) * 360
////            }
////
////            return temp
////        }
////
////    }
////
////    func to() -> Double {
////
////        //convert percent to an angle
////
////        var temp: Double = 0
////
////        //need the current degree
////
////        for i in 0...index {
////
////            temp += Double(data[i].percent / 100) * 360
////        }
////
////        return temp
////    }
////}
////
////
////struct Pie: Identifiable {
////    var id: Int
////    var percent: CGFloat
////    var name: String
////    var color: Color
////}
////
////var data = [
////    Pie(id: 0, percent: 10, name: "Health", color: Color("Red")),
////    Pie(id: 1, percent: 15, name: "Groceries", color: Color("Pink")),
////    Pie(id: 2, percent: 20, name: "Savings", color: Color("Green")),
////    Pie(id: 3, percent: 20, name: "Dining", color: Color("Purple")),
////    Pie(id: 4, percent: 35, name: "Housing", color: Color.green.opacity(0.6))
////]
