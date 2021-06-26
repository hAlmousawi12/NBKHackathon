//
//  PayView.swift
//  FirebaseTemplate
//
//  Created by Hussain on 6/26/21.
//  Copyright © 2021 OMAR. All rights reserved.
//

import SwiftUI

struct PayView: View {
    @EnvironmentObject var env: UserEnv
    @State var transaction: Transaction = Transaction(amount: "", category: "", date: Date())
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    var body: some View {
        VStack {
            TextField("Enter the amount", text: $transaction.amount)
                .background(Capsule().fill(Color.white))
                .keyboardType(.numberPad)
                
            
            TextField("Category", text: $transaction.category)
                .background(Capsule().fill(Color.white))
            
            Button(action: {
                transaction.date = Date()
//                env.AddATransaction(item: Transaction(amount: transaction.amount, category: transaction.category, date: transaction.date))
                self.presentationMode.wrappedValue.dismiss()
            }, label: {
                Text("Done!")
            })
            .modifier(SignInModifier())
        }
    }
}

struct PayView_Previews: PreviewProvider {
    static var previews: some View {
        PayView()
    }
}
