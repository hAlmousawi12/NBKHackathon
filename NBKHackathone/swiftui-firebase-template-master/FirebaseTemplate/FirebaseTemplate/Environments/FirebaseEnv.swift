//
//  FirebaseEnv.swift
//  FirebaseTemplate
//
//  Created by Omar Alibrahim on 12/27/20.
//  Copyright © 2020 OMAR. All rights reserved.
//

import SwiftUI
import FirebaseAuth

class FirebaseEnv: ObservableObject{
    @Published var signedIn: Bool = (FirebaseAuth.Auth.auth().currentUser != nil)
    
    func signIn(user: SignInCredentials, success: @escaping (String) -> Void,  fail: ((Error?) -> Void)?){
        Networking.signIn(user: user, success: { uid in
//            self.signedIn = true
            success(uid)
        }, fail: fail)
    }
    
    func signOut(){
        Networking.signOut()
        self.signedIn = false
    }
    
    func signUp(user: User, password: String){
        Networking.signUp(user: user, password: password) { (uid) in
//            self.signedIn = true
        }
    }
    
    
}
