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
        VStack(alignment: .center) {
            Text("Moneywise")
                .font(.largeTitle)
                .bold()
                .padding(.top, 10)
                .padding(.bottom, 20)
            
            Image("icon")
                .resizable()
                .frame(width: 220, height: 220)
            
            
            VStack(spacing: 20) {
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
        }.background(Color.background)
    }
}
struct CredentialsLoginView_Previews: PreviewProvider {
    static var previews: some View {
        CredentialsLoginView()
    }
}
