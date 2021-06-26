//
//  AddBudget.swift
//  FirebaseTemplate
//
//  Created by Hussain on 6/26/21.
//  Copyright © 2021 OMAR. All rights reserved.
//

import SwiftUI

struct AddBudget: View {
    @EnvironmentObject var env: UserEnv
    @State var name = ""
    @State var price = ""
    @State var daysLeft = ""
    @State var savedPrice = ""
    @State var i = -1
    @State var percentage = 0.0
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    var body: some View {
        ZStack {
            Color.theme.bg.edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 30) {
                
                TextField("Enter the name", text: $name)
                    .background(Capsule().fill(Color.white))
                TextField("Enter the price", text: $price)
                    .background(Capsule().fill(Color.white))
                    .keyboardType(.numberPad)
                TextField("Enter the days", text: $daysLeft)
                    .background(Capsule().fill(Color.white))
                    .keyboardType(.numberPad)
                TextField("Enter how much you saved", text: $savedPrice)
                    .background(Capsule().fill(Color.white))
                    .keyboardType(.numberPad)
                
                Button("Add to Budgets") {
                    
                    percentage = Double((Double(savedPrice) ?? 0.0) / (Double(price) ?? 1.0) * 100)
                    
                    if (Double(savedPrice) ?? 0.0) < (Double(price) ?? 0.0) {
                        self.presentationMode.wrappedValue.dismiss()
                        env.AddToBudgetss(item: Saving(name: name, price: price, percentage: percentage, daysLeft: daysLeft, savedPrice: savedPrice, numberOfSaving: i))
                    } else {
                        env.alertShown = true
                        env.alertMessage = "The amount of the savings is higher than the price"
                    }
                }
                .frame(width: 250, height: 50)
                .background(Color.theme.blue)
                .foregroundColor(.white)
                .cornerRadius(15)
                .shadow(color: .theme.blue.opacity(0.3), radius: 10, x: 0, y: 0)
                
            }.padding(.horizontal, 30)
        }.alert(isPresented: $env.alertShown, content: {
            Alert(title: Text(env.alertMessage), dismissButton: .default(Text("Okay!")))
        })
    }
}

struct AddBudget_Previews: PreviewProvider {
    static var previews: some View {
        AddBudget()
    }
}
