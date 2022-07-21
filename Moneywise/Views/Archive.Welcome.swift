//
//  Welcome.swift
//  Moneywise
//
//  Created by Carmen Chiu on 7/12/22.
//

//import SwiftUI
//import LocalAuthentication
//
//struct Welcome: View {
//    @StateObject var authentificationManager = AuthenticationManager()
//   // @State private var isUnlocked = false  //FaceID Authentification.not showing private data by default
////    var transaction: Transaction?
//
//    var body: some View {
//        NavigationView {
            
//            ZStack {
//                LinearGradient(colors: [Color.background], startPoint: .topLeading, endPoint: .bottomLeading)
//                    .ignoresSafeArea()
//
//                VStack(alignment: .center) {
//                    Text("Moneywise")
//                        .font(.largeTitle)
//                        .bold()
//                        .padding(.top)
//                        .padding(.bottom, 10)
//
//                    Image("icon")
//                        .resizable()
//                        .scaledToFit()
//                        .padding(50)
//
//
//                    Text("Get smarter about how you spend your money")
//                        .font(.title2)
//                        .italic()
//
//                    Spacer()
                    
      //              MARK: FaceID Button
//                    ZStack{
//                        Spacer()
//                        Rectangle().fill(.ultraThinMaterial)
//                            .cornerRadius(12)
//                        NavigationLink(destination: MainPageView()) {
//                            HStack {
//                            Text("Lets get started!")
//                            Image("faceid")
//                            }
//                        }
//                    }.frame(width: UIScreen.main.bounds.width - 40, height: 55)
                    
//                }
//            }
//        }
//    
//    

    
    
    
//    //MARK: Unlock with FaceID
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



//
//struct Welcome_Previews: PreviewProvider {
//    static var previews: some View {
//        Welcome()
//            .navigationBarHidden(true)
//            .environmentObject(AuthenticationManager())
//        Welcome()
//            .preferredColorScheme(.dark)
//            .navigationBarHidden(true)
//            .environmentObject(AuthenticationManager())
//
//    }
//}
