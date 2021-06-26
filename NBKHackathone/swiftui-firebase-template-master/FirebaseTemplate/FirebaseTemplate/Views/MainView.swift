//
//  MainView.swift
//  FirebaseTemplate
//
//  Created by Omar Alibrahim on 12/27/20.
//  Copyright © 2020 OMAR. All rights reserved.
//

import SwiftUI

struct MainView: View {
    @EnvironmentObject var env: FirebaseEnv
    var body: some View {
        if env.signedIn {
            TabBarView()
                .environmentObject(FirebaseEnv())
                .environmentObject(VideoEnv())
                .environmentObject(UserEnv())
        }
        else {
            AuthenticationView()
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
            .environmentObject(FirebaseEnv())
    }
}
