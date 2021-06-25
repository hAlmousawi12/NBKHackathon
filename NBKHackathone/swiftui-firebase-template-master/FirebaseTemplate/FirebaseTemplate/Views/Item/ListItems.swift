//
//  ListItems.swift
//  FirebaseTemplate
//
//  Created by Omar Alibrahim on 12/27/20.
//  Copyright © 2020 OMAR. All rights reserved.
//

import SwiftUI

struct ListItems: View {
    @EnvironmentObject var itemsEnv: ItemsEnv
    
    var body: some View {
        List(itemsEnv.items, id: \.self){ item in
            VStack(alignment: .leading){
                Text(item.name).font(.title3)
                Text("\(item.price)").font(.headline).foregroundColor(.red)
            }
        }
        .navigationTitle("Items List")
        .onAppear(perform: itemsEnv.loadItems)
    }

}

struct ListItems_Previews: PreviewProvider {
    static var previews: some View {
            ListItems()
                .environmentObject(ItemsEnv())
    }
}
