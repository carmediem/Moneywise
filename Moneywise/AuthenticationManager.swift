//
//  AuthenticationManager.swift
//  Moneywise
//
//  Created by Carmen Chiu on 7/19/22.
//

import Foundation
import LocalAuthentication

class AuthenticationManager: ObservableObject {
    private(set) var context = LAContext()
    @Published private(set) var biometryType: LABiometryType = .none
    private (set) var canEvaluatePolicy = false
    
    init() {
        getBiometryType()
    }
    func getBiometryType() {
        canEvaluatePolicy = context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: nil)
        biometryType = context.biometryType
    }
}
