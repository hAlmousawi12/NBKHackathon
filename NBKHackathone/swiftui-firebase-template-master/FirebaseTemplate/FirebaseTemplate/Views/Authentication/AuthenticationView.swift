//
//  AuthenticationView.swift
//  FirebaseTemplate
//
//  Created by Omar Alibrahim on 12/27/20.
//  Copyright © 2020 OMAR. All rights reserved.
//

import SwiftUI

struct AuthenticationView: View {
    var body: some View {
            VStack{
                    NavigationLink(
                        destination: SignIn().environmentObject(FirebaseEnv()),
                        label: {Text("Sign in").modifier(SignInModifier())}
                    ).padding()
                    NavigationLink(
                        destination: SignUp().environmentObject(FirebaseEnv()),
                        label: {Text("Create an account")}
                    )
                }
            .navigationBarHidden(true)
    }
}

struct SignInModifier: ViewModifier{
    func body(content: Content) -> some View {
        content
            .foregroundColor(.white)
            .padding()
            .frame(minWidth: 100, idealWidth: 200, maxWidth: .infinity,  alignment: .center)
            .background(Color.theme.blue)
            .cornerRadius(10)
            .padding(.horizontal)
    }
}

struct AuthenticationView_Previews: PreviewProvider {
    static var previews: some View {
        AuthenticationView()
    }
}
