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
    @Published var walletItems: [Wallet] = []
    @Published var budgetsCount = 0
    @Published var SavingsCount = 0
    @Published var savings: [Saving] = []
    @Published var budgets: [Saving] = []
    @Published var otherUsers: [User] = []
    @Published var transactions: [Transaction] = []
    let path = "users/\(Networking.getUserId() ?? "")"
    
    func getUser() {
        Networking.getSingleDocument(path) { (user: User) in
            self.user = user
        }
    }
    
    func getOtherUsersData() {
        
        Networking.getListOf(COLLECTION_NAME: "\(path)/otherAccounts") { (users: [User]) in
            self.otherUsers = users
            self.totalExpense = self.user.budget.expense
            self.totalBalance = self.user.budget.balance
            self.totalIncome = self.user.budget.income
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
    
    func loadWallet() {
        Networking.getListOf(COLLECTION_NAME: "\(path)/wallet") { (items: [Wallet]) in
            self.walletItems = items
            self.SavingsCount = 0
            self.budgetsCount = 0
            for i in items {
                if i.isSaving {
                    self.SavingsCount += 1
                } else {
                    self.budgetsCount += 1
                }
            }
        }
    }
    
    func AddToWallet(item: Wallet) {
        Networking.createItem(item, inCollection: "\(path)/wallet") {
            self.showAlert(alertType: .success)
        } fail: { err in
            self.showAlert(alertType: .fail)
        }

    }
    
    func loadSavings() {
        Networking.getListOf(COLLECTION_NAME: "\(path)/wishlist") { (saving: [Saving]) in
            self.savings = saving
        }
    }
    
    func AddToSavings(item: Saving) {
        Networking.createItem(item, inCollection: "\(path)/wishlist") {
            self.showAlert(alertType: .success)
        } fail: { err in
            self.showAlert(alertType: .fail)
        }

    }
    
//    func loadTransactions() {
//        Networking.getListOf(COLLECTION_NAME: "\(path)/transaction") { (transactions: [Transaction]) in
//            self.transactions = transactions
//        }
//    }
//
//    func AddATransaction(item: Transaction) {
//        Networking.createItem(item, inCollection: "\(path)/transaction") {
//            self.showAlert(alertType: .success)
//        } fail: { err in
//            self.showAlert(alertType: .fail)
//        }
//
//    }
    
    func loadBudgets() {
        Networking.getListOf(COLLECTION_NAME: "\(path)/budgett") { (budgets: [Saving]) in
            self.budgets = budgets
        }
    }
    
    func AddToBudgetss(item: Saving) {
        Networking.createItem(item, inCollection: "\(path)/budgett") {
            self.showAlert(alertType: .success)
        } fail: { err in
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
