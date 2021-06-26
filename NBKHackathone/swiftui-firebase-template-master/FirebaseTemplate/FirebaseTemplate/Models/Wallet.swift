//
//  Wallet.swift
//  FirebaseTemplate
//
//  Created by Hussain on 6/26/21.
//  Copyright © 2021 OMAR. All rights reserved.
//

import Foundation

struct Wallet: Codable, Hashable {
    
    var price: Double = 0.0
    var category: String = ""
    var isSaving: Bool = false
    
}


/*
 1 - the Wallet
 - budgets : example(100 kd budget for june , 200 kd budget for july)
 - savings : example(just like the wishlist)
 -events : example(wedding , graduation day , birthday)
 2 - the add button
 (as a user when i click on the add on wallet i get two inputs, one for the amount of money and one for what is it for like food or beverages and stuff )
 and do the same for the other add buttons
 with the needed data
 3 - Statistics feature
 -------------------------------------------------------
 please make the app as functional as possible عشان لا نتوهق وقت البرزنتيشن
 -------------------------------------------------------
 */
