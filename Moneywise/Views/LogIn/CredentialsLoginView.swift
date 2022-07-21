//
//  CredentialsLoginView.swift
//  Moneywise
//
//  Created by Carmen Chiu on 7/19/22.
//

import SwiftUI

struct CredentialsLoginView: View {
    @EnvironmentObject var authentificationManager: AuthenticationManager
    @State private var username = ""
    @State private var password = ""
    
    
    var body: some View {
        VStack(spacing: 40) {
            Text("Log into Moneywise")
            TextField("Username", text: $username)
            SecureField("Password", text: $password)
            PrimaryButton(showImage: false, text: "Login")
                .onTapGesture {
                    authentificationManager.authenticateWithCredentials(username: username, password: password)
                }
        }
        .textFieldStyle(.roundedBorder)
            .padding()
            .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

struct CredentialsLoginView_Previews: PreviewProvider {
    static var previews: some View {
        CredentialsLoginView()
    }
}
