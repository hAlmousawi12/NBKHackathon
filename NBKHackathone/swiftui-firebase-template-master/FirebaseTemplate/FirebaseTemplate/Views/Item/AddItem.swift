//
//  AddItem.swift
//  FirebaseTemplate
//
//  Created by Omar Alibrahim on 12/27/20.
//  Copyright © 2020 OMAR. All rights reserved.
//

import SwiftUI


struct AddItem: View {
    @EnvironmentObject var itemsEnv: ItemsEnv
    @State var itemName: String = ""
    @State var itemPrice: String = ""

    var body: some View {
        VStack {
            TextField("item name", text: $itemName)
            TextField("item price", text: $itemPrice)
                .keyboardType(.decimalPad)
            
            Button(action: {
                guard let price = Double(itemPrice) else {
                    itemsEnv.showAlert(alertType: .incompleteForm)
                    return
                }
                let item = Item(name: itemName, price: price)
                itemsEnv.addItem(item: item)

            }, label: {
                Text("Add Item")
            })
            Spacer()
        }
        .navigationTitle("Add a new item")
        .padding()
        .alert(isPresented: $itemsEnv.alertShown, content: {
            Alert(title: Text(itemsEnv.alertMessage))
        })
    }
    
}


struct AddItem_Previews: PreviewProvider {
    static var previews: some View {
            AddItem()
                .environmentObject(ItemsEnv())
    }
}
