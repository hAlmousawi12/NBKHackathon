//
//  Transaction.swift
//  FirebaseTemplate
//
//  Created by Hussain on 6/26/21.
//  Copyright © 2021 OMAR. All rights reserved.
//

import Foundation

struct Transaction: Codable, Hashable {
    
    var amount: String = ""
    var category: String = ""
    var date: Date = Date()
    
}
