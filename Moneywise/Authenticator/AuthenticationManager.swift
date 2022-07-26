//
//  AuthenticationManager.swift
//  Moneywise
//
//  Created by Carmen Chiu on 7/19/22.
//

import Foundation
import LocalAuthentication

@MainActor
class AuthenticationManager: ObservableObject {
    private(set) var context = LAContext()
    @Published private(set) var biometryType: LABiometryType = .none
    private (set) var canEvaluatePolicy = false
    @Published private(set) var isAuthenticated = false
    @Published private(set) var errorDescription: String?
    @Published var showAlert = false
    
    
    init() {
        getBiometryType()
    }
    
    func getBiometryType() {
        canEvaluatePolicy = context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: nil)
        biometryType = context.biometryType
    }
    
    func authenticateWithBiometrics() async {
        //recreate the context every time the user tries to log in again. Otherwise, the faceID will not show up again next time
        context = LAContext()

        if canEvaluatePolicy {
            let reason = "Log into Moneywise"
            
            do {
                let success = try await context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason)
                
                if success {
                    DispatchQueue.main.async {     //need to use dispatchQueue bc it is no the man thread
                        self.isAuthenticated = true
        
                        print("isAuthenticated", self.isAuthenticated) //need to reference self bc we're in a closure
                    }
                }
        } catch {
            print(error.localizedDescription)
            DispatchQueue.main.async {
                self.errorDescription = error.localizedDescription
                self.showAlert = true
                self.biometryType = .none
            }
            
        }
    }
}
    func authenticateWithCredentials(username: String, password: String) {
        if username.lowercased() == "carmen" && password == "hello" {
            isAuthenticated = true
        } else {
            errorDescription =  "Wrong login information"
            showAlert = true
        }
    }
    
    func logout() {
        isAuthenticated = false
    }
}
