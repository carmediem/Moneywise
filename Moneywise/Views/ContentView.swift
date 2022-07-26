//
//  ContentView.swift
//  Moneywise
//
//  Created by Carmen Chiu on 7/13/22.
//

import SwiftUI
import LocalAuthentication


struct ContentView: View {
    
    @StateObject var authentificationManager = AuthenticationManager()
    
    //not actually using this..
   var transaction: Transaction?
      
    var body: some View {
        NavigationView {
          
            VStack(alignment: .center) {
                Text("Moneywise")
                    .font(.largeTitle)
                    .bold()
              //      .padding(.top, 20)
                    .padding(.bottom, 40)
                
                Image("icon")
                    .resizable()
              //      .scaledToFit()
                    .frame(width: 190, height: 190)
                    .padding(.bottom, 40)
                
                Text("Get smarter about how")
                    .font(.title2)
                    .italic()
                 Text("you spend your money")
                    
                    .font(.title2)
                    .italic()
                
                Spacer()
            
            
            //MARK: NEXT STEPS AFTER AUTHENTIFICATION
            VStack {
                if authentificationManager.isAuthenticated {
                    
                    VStack(spacing: 40) {
                        ZStack{
                            Spacer()
                            Rectangle().fill(.ultraThinMaterial)
                                .padding()
                                .padding(.horizontal)
                                .background(.white)
                                .cornerRadius(30)
                                .shadow(radius: 10)
                            NavigationLink(destination: MainPageView()) {
                                HStack {
                                Text("BLANK")

                                }
                            }
                        }.frame(width: UIScreen.main.bounds.width - 40, height: 55)
                        Text("")
                        //MARK:  MOVE THE LOGOUT BUTTON TO THE UPPER LEFT HAND CORNER
                
                        PrimaryButton(showImage: false, text: "Logout")
                            .onTapGesture {
                                authentificationManager.logout()
                            }
                    }
                } else {
                    LoginView()
                        .environmentObject(authentificationManager)
                }
            }
            .alert(isPresented:
                    $authentificationManager.showAlert) {
                Alert(title: Text("Error"), message: Text(authentificationManager .errorDescription ?? "There was an error with your login credentials. Pleas try again"), dismissButton: .default(Text("Okay")))
            }
            }.background(Color.background)
        }
    }
 
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ContentView()
                .navigationBarHidden(true)
                .environmentObject(AuthenticationManager())
            ContentView()
                .preferredColorScheme(.dark)
                .navigationBarHidden(true)
                .environmentObject(AuthenticationManager())

        }
    }
}
