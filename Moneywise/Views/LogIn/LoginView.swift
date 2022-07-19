//
//  LoginView.swift
//  Moneywise
//
//  Created by Carmen Chiu on 7/19/22.
//

import SwiftUI

struct LoginView: View {
    @EnvironmentObject var authenticationManager: AuthenticationManager

    var body: some View {
        VStack(spacing: 40) {
            Title()
            switch authenticationManager.biometryType {
            case .faceID:
                PrimaryButton(image: "faceid", text: "Log in with FaceID")
                    .onTapGesture {
                        Task.init {
                            await
                            authenticationManager.authenticateWithBiometrics()
                        }
                    }
            case .touchID:
                PrimaryButton(image: "touchid", text: "Log in with TouchID")
                    .onTapGesture {
                        Task.init {
                            await
                            authenticationManager.authenticateWithBiometrics()
                        }
                    }
            default:
                NavigationLink {
                    CredentialsLoginView()
                        .environmentObject(authenticationManager) //need this so it doesnt crash
                } label: {
                PrimaryButton(image: "person.fill", text: "Log in with your credentials")
                }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
            .environmentObject(AuthenticationManager())
    }
}
