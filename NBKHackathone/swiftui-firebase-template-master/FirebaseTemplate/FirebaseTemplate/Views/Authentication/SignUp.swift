//
//  SignInView.swift
//  FirebaseTemplate
//
//  Created by Omar Alibrahim on 12/27/20.
//  Copyright © 2020 OMAR. All rights reserved.
//

import SwiftUI

struct SignUp: View {
    @State var user = User()
    @State var password = ""
    @EnvironmentObject var env: FirebaseEnv
    @State private var balance = ""
    @State private var income = ""
    @State private var expense = ""
    var body: some View {
        //            Form{
        //                TextField("enter your balance", text: $balance)
        //                    .keyboardType(.numberPad)
        //                TextField("enter your income", text: $income)
        //                    .keyboardType(.numberPad)
        //                TextField("enter your expense", text: $expense)
        //                    .keyboardType(.numberPad)
        //                TextField("Fullname", text: $user.fullName).keyboardType(.default)
        //                TextField("E-mail", text: $user.email).keyboardType(.emailAddress)
        //                SecureField("password", text: $password)
        //                Button("Sign up"){
        //                    self.user.budget.balance = Int(self.balance) ?? 0
        //                    self.user.budget.expense = Int(self.expense) ?? 0
        //                    self.user.budget.income = Int(self.income) ?? 0
        //                    env.signUp(user: user, password: password)
        //                    env.signedIn = true
        //                }
        //            }
        //            .navigationTitle("Sign up")
        ZStack {
            Color(UIColor(red: 246.0/255.0, green: 246.0/255.0, blue: 247.0/255.0, alpha: 1.0))
                .ignoresSafeArea(.all)
            VStack {
                Spacer()
                HStack {
                    Image(systemName: "person")
                        .foregroundColor(.secondary)
                    
                    TextField("FullName",
                              text: $user.fullName)
                }   .padding()
                .background(Capsule().fill(Color.white))
                HStack {
                    Image(systemName: "envelope")
                        .foregroundColor(.secondary)
                    
                    TextField("Email",
                              text: $user.email)
                }   .padding()
                .background(Capsule().fill(Color.white))
                HStack {
                    Image(systemName: "person")
                        .foregroundColor(.secondary)
                    TextField("enter your balance",
                              text: $balance)
                }   .padding()
                .background(Capsule().fill(Color.white))
                HStack {
                    Image(systemName: "arrow.down")
                        .foregroundColor(.secondary)
                    
                    TextField("income",
                                text: $income)
                }   .padding()
                .background(Capsule().fill(Color.white))
                HStack {
                    Image(systemName: "arrow.up")
                        .foregroundColor(.secondary)
                    
                    TextField("expense",
                              text: $expense)
                }.padding()
                .background(Capsule().fill(Color.white))
                HStack {
                    Image(systemName: "lock")
                        .foregroundColor(.secondary)
                    
                    SecureField("Password",
                              text: $password)
                }   .padding()
                .background(Capsule().fill(Color.white))
                Button("Sign up"){
                    self.user.budget.balance = Int(self.balance) ?? 0
                    self.user.budget.expense = Int(self.expense) ?? 0
                    self.user.budget.income = Int(self.income) ?? 0
                    env.signUp(user: user, password: password)
                    env.signedIn = true
                }
                .modifier(SignInModifier())
                .padding(.top, 30.0)
                NavigationLink("Don't have an account?", destination: SignIn())
                    .padding(.top, 10)
                Spacer()
            }.padding()
        }
    }
}

struct SignUp_Previews: PreviewProvider {
    static var previews: some View {
        SignUp()
            .environmentObject(FirebaseEnv())
    }
}
