//
//  UserEnv.swift
//  FirebaseTemplate
//
//  Created by Hussain on 6/25/21.
//  Copyright © 2021 OMAR. All rights reserved.
//

import Foundation

class UserEnv: ObservableObject {
    @Published var user = User()
    @Published var totalBalance = 0
    @Published var totalExpense  = 0
    @Published var totalIncome = 0
    @Published var alertShown = false
    @Published var alertMessage = ErrorMessages.none.message
    let path = "users/\(Networking.getUserId() ?? "")"
    
    func getUser() {
        Networking.getSingleDocument(path) { (user: User) in
            self.user = user
        }
    }
    
    func getOtherUsersData() {
        
        Networking.getListOf(COLLECTION_NAME: "\(path)/otherAccounts") { (users: [User]) in
            for i in users {
                self.totalBalance += i.budget.balance
                self.totalIncome += i.budget.income
                self.totalExpense += i.budget.expense
            }
        }
    }
    
    
    
    func addAnotherAccount(user: User) {
        Networking.createItem(user, inCollection: "\(path)/otherAccounts", withDocumentId: UUID().uuidString) {
            self.showAlert(alertType: .success)
        } fail: {error in
            self.showAlert(alertType: .fail)
            
        }
    }
    
    enum ErrorMessages{
        case success, fail, none, incompleteForm
        var message: String{
            switch self{
            case .success: return "success"
            case .incompleteForm: return "incompleteForm"
            case .fail: return "fail"
            case .none: return ""
            }
        }
    }
    func showAlert(alertType: ErrorMessages){
        self.alertMessage = alertType.message
        self.alertShown = true
    }
}
