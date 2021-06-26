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
                
                SignOutButton(env: env)
            }.navigationBarHidden(true)
            
        }
    }
}

//extension ProfileView: 

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
