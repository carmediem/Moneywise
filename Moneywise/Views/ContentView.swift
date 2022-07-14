//
//  ContentView.swift
//  Moneywise
//
//  Created by Carmen Chiu on 7/13/22.
//

import SwiftUI

struct ContentView: View {
    var transaction: Transaction?
    var body: some View {
        Text("Hello World!")
            .padding()
    }
}
//import view model here and loop through here.

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
        ContentView()
        }
    }
}
