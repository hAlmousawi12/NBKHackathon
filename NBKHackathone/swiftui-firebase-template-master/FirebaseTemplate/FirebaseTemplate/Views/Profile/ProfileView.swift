//
//  ProfileView.swift
//  FirebaseTemplate
//
//  Created by Hussain on 6/25/21.
//  Copyright © 2021 OMAR. All rights reserved.
//

import SwiftUI

struct ProfileView: View {
    @EnvironmentObject var env: FirebaseEnv
    var body: some View {
        ZStack {
            Color.theme.bg.edgesIgnoringSafeArea(.all)
            VStack {
                Form {
                    NavigationLink(
                        destination: AddAnotherAccount().environmentObject(FirebaseEnv()),
                        label: {
                            Text("Add Another Account")
                                .foregroundColor(.theme.blue)
                        })
                    SignOutButton(env: env)
                }
            }
        }.navigationBarHidden(true)
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
