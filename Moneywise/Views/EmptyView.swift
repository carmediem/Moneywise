//
//  EmptyView.swift
//  Moneywise
//
//  Created by Carmen Chiu on 7/15/22.
//

import SwiftUI

struct EmptyView: View {
    @Binding var query: String
    
    var body: some View {
    Text("We couldn't find: \(query)")
    }
}

struct EmptyView_Previews: PreviewProvider {
    static var previews: some View {
        EmptyView(query: .constant("that transaction"))
    }
}
