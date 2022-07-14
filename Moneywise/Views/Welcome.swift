//
//  Welcome.swift
//  Moneywise
//
//  Created by Carmen Chiu on 7/12/22.
//

import SwiftUI

struct Welcome: View {
    var body: some View {
        NavigationView {
            ZStack {
                LinearGradient(colors: [Color.background], startPoint: .topLeading, endPoint: .bottomLeading)
                    .ignoresSafeArea()
                
                VStack(alignment: .center) {
                    Text("Moneywise")
                        .font(.largeTitle)
                        .bold()
                        .padding(.top)
                        .padding(.bottom, 10)
                    
                    Image("icon")
                        .resizable()
                        .scaledToFit()
                        .padding(50)
                    
                    
                    Text("Get smarter about how you spend your money")
                        .font(.title2)
                        .italic()
                    
                    Spacer()
                    
                    //MARK: Get started button
                    ZStack{
                        Spacer()
                        Rectangle().fill(.ultraThinMaterial)
                            .cornerRadius(12)
                        NavigationLink(destination: MainPageView()) {
                            Text("Lets get started!")
                            
                        }
                    }.frame(width: UIScreen.main.bounds.width - 40, height: 55)
                    
                }
            }
        }
    }
}


struct Welcome_Previews: PreviewProvider {
    static var previews: some View {
        Welcome()
        Welcome()
            .preferredColorScheme(.dark)
            .navigationBarHidden(true)
        
        
    }
}
