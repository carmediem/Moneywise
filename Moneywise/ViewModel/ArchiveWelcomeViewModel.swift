//
//  ArchiveWelcomeViewModel.swift
//  Moneywise
//
//  Created by Carmen Chiu on 7/20/22.
//
//
//import SwiftUI
//import LocalAuthentication
//
//struct ArchiveWelcomeViewModel: View {
//    @State  var isUnlocked = false  //FaceID Authentification.not showing private data by default
//    var body: some View {
//        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
//    }
//    func authenticate() {
//        let context = LAContext()
//        var error: NSError?
//        //check to see if we can access the data using biometrics with a bool
//        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
//            let reason = "We need to unlock your data in order to access Moneywise."
//            //tell context to evaluation the deviceOwnerAuthentication reason to unlock data. In the completion closure, take two parameters of success or error.
//            context.evaluatePolicy(.deviceOwnerAuthentication, localizedReason: reason) {success, authenticationError in
//                if success {
//                    isUnlocked = true
//                } else {
//
//                }
//            }
//        } else { //maybe device with no biometrics on their phone
//        }
//
//    }
//}
//
//struct ArchiveWelcomeViewModel_Previews: PreviewProvider {
//    static var previews: some View {
//        ArchiveWelcomeViewModel()
//    }
//}
