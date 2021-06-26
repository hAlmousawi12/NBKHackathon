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
    @State var percentage = ""
    @State var i = -1
    var body: some View {
        ZStack {
            Color.theme.bg.edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 30) {
                
                TextField("Enter the name", text: $name)
                TextField("Enter the price", text: $price)
                TextField("Enter the days", text: $daysLeft)
                TextField("Enter how much you saved", text: $savedPrice)
                TextField("Enter the percentage", text: $percentage)
                    .keyboardType(.numberPad)
                
                Button("Add to Budgets") {
                    env.AddToBudgetss(item: Saving(name: name, price: price, percentage: Double(percentage) ?? 0.0, daysLeft: daysLeft, savedPrice: savedPrice, numberOfSaving: i))
                }
                .frame(width: 250, height: 50)
                .background(Color.theme.blue)
                .foregroundColor(.white)
                .cornerRadius(15)
                .shadow(color: .theme.blue.opacity(0.3), radius: 10, x: 0, y: 0)
                
            }.padding(.horizontal, 30)
        }
    }
}

struct AddBudget_Previews: PreviewProvider {
    static var previews: some View {
        AddBudget()
    }
}
