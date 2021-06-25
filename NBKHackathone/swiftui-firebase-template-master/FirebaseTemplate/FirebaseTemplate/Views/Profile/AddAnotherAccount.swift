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
    var body: some View {
        VStack(spacing: 15){
            TextField("E-mail", text: $newUser.email)
            
            TextField("enter your balance", text: $balance)
                .keyboardType(.numberPad)
            TextField("enter your income", text: $income)
                .keyboardType(.numberPad)
            TextField("enter your expense", text: $expense)
                .keyboardType(.numberPad)
            
            SecureField("password", text: $password)
            Button("Add another account") {
                self.newUser.budget.balance = Int(self.balance) ?? 0
                self.newUser.budget.expense = Int(self.expense) ?? 0
                self.newUser.budget.income = Int(self.income) ?? 0
                env.addAnotherAccount(user: newUser)
                //TODO .....
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
