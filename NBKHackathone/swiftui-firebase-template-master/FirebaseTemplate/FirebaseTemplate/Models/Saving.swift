//
//  Saving.swift
//  FirebaseTemplate
//
//  Created by Hussain on 6/25/21.
//  Copyright © 2021 OMAR. All rights reserved.
//

import Foundation

struct Saving: Hashable {
    var name: String
    var price: String
    var percentage: Double
    var daysLeft: String
    var savedPrice: String
    var numberOfSaving: Int
}


var savingss: [Saving] = [
    .init(name: "iPhone 11 Pro Max", price: "$1249.00", percentage: 56.0, daysLeft: "19 Days Left", savedPrice: "$545.00", numberOfSaving: 1),
    .init(name: "Converse Shoe", price: "$100.00", percentage: 50.0, daysLeft: "3 Days Left", savedPrice: "$50.00", numberOfSaving: 2)
]
