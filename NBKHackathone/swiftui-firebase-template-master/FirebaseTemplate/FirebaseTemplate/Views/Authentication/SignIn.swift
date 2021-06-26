//
//  SignInView.swift
//  FirebaseTemplate
//
//  Created by Omar Alibrahim on 12/27/20.
//  Copyright © 2020 OMAR. All rights reserved.
//

import SwiftUI


struct SignIn: View {
    @State var userCredentials = SignInCredentials(email: "", name: "", password: "")
    @EnvironmentObject var env: FirebaseEnv
    @State var alertShown: Bool = false
    @State var alertError: String = ""
    @State var selection: Int? = nil
    var body: some View {
        ZStack {
            Color(UIColor(red: 246.0/255.0, green: 246.0/255.0, blue: 247.0/255.0, alpha: 1.0))
                .ignoresSafeArea(.all)
            VStack(spacing: 15){
                
                    VStack {
                        HStack {
                            Image(systemName: "envelope")
                                .foregroundColor(.secondary)
                            TextField("Email",
                                      text: $userCredentials.email)
                        }   .padding()
                        .background(Capsule().fill(Color.white))
                        HStack {
                            Image(systemName: "lock")
                                .foregroundColor(.secondary)
                            
                            SecureField("Password",
                                        text: $userCredentials.password)
                        }   .padding()
                        .background(Capsule().fill(Color.white))
                    }.padding()
                NavigationLink(destination: TabBarView()
                                .environmentObject(FirebaseEnv())
                                .environmentObject(UserEnv()), tag: 1, selection: $selection) {
                    Button("Sign in"){
                        env.signIn(user: userCredentials) { (uid) in
                            env.signedIn = true
                            print("Signed in!")
                            if env.signedIn {
                                selection = 1
                            }
                        } fail: { (error) in
                            alertError = error?.localizedDescription ?? ""
                            alertShown = true
                        }
                    }
                    .modifier(SignInModifier())
                }
                            
                            NavigationLink("Don't have an account?", destination: SignIn())
            }
            .navigationTitle("Sign in")
            .alert(isPresented: $alertShown, content: {
                Alert(title: Text("Error!"), message: Text(alertError), dismissButton: .cancel())
            })
            .padding()
        }
    }
}

struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        SignIn()
            .environmentObject(FirebaseEnv())
    }
}
