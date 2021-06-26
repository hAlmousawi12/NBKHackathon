//
//  AddToWallet.swift
//  FirebaseTemplate
//
//  Created by Hussain on 6/26/21.
//  Copyright © 2021 OMAR. All rights reserved.
//

import SwiftUI

struct AddToWallet: View {
    @EnvironmentObject var env: UserEnv
    @State var price = ""
    @State var category = ""
    @State var selection = 1
    var selected = ["Saving", "Budget"]
    var body: some View {
        ZStack {
            Color.theme.bg.edgesIgnoringSafeArea(.all)
            VStack(spacing: 30) {
                TextField("Enter the price", text: $price)
                    .keyboardType(.numberPad)
                
                TextField("Enter the category", text: $category)
                
                HStack {
                    Picker(selection: $selection, label: Text("Is it saving or budget"), content: {
                        Text("Saving").tag(1)
                        Text("budget").tag(2)
                    })
                    .pickerStyle(MenuPickerStyle())
                    Spacer()
                    
                    Text(selected[selection - 1])
                }
                
                Button("Add to my wallet") {
                    env.AddToWallet(item: Wallet(price: Double(price) ?? 0.0, category: category, isSaving: selection == 1 ))
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

struct AddToWallet_Previews: PreviewProvider {
    static var previews: some View {
        AddToWallet()
            .accentColor(.theme.blue)
    }
}
