//
//  AddAnotherAccount.swift
//  FirebaseTemplate
//
//  Created by Hussain on 6/25/21.
//  Copyright © 2021 OMAR. All rights reserved.
//

import SwiftUI

struct AddAnotherAccount: View {
    @State var newUser = User(fullName: "", email: "", budget: Budget(balance: 0, income: 0, expense: 0))
    @EnvironmentObject var env: UserEnv
    @State var alertShown: Bool = false
    @State var alertError: String = ""
    @State var password = ""
    @State private var balance = ""
    @State private var income = ""
    @State private var expense = ""
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    var body: some View {
        VStack(spacing: 15){
            
            TextField("Enter your full name", text: $newUser.fullName)
                .background(Capsule().fill(Color.white))
            TextField("enter your E-mail", text: $newUser.email)
                .background(Capsule().fill(Color.white))
            TextField("Enter your balance", text: $balance)
                .background(Capsule().fill(Color.white))
                .keyboardType(.numberPad)
            TextField("Enter your income", text: $income)
                .background(Capsule().fill(Color.white))
                .keyboardType(.numberPad)
            TextField("Enter your expense", text: $expense)
                .keyboardType(.numberPad)
                .background(Capsule().fill(Color.white))
            
            SecureField("password", text: $password)
                .background(Capsule().fill(Color.white))
            Button("Add another account") {
                
                self.newUser.budget.balance = Int(self.balance) ?? 0
                self.newUser.budget.expense = Int(self.expense) ?? 0
                self.newUser.budget.income = Int(self.income) ?? 0
                env.addAnotherAccount(user: newUser)
                self.presentationMode.wrappedValue.dismiss()
            }
            NavigationLink("Don't have an account?", destination: SignUp())
        }
        .alert(isPresented: $alertShown, content: {
            Alert(title: Text("Error!"), message: Text(alertError), dismissButton: .cancel())
        })
        .padding()
    }
}

struct AddAnotherAccount_Previews: PreviewProvider {
    static var previews: some View {
        AddAnotherAccount()
    }
}
