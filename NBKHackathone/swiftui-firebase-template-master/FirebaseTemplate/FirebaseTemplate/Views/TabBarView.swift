//
//  TabBarView.swift
//  FirebaseTemplate
//
//  Created by Hussain on 6/25/21.
//  Copyright © 2021 OMAR. All rights reserved.
//

import SwiftUI

struct TabBarView: View {
    @EnvironmentObject var env: FirebaseEnv
    var body: some View {
        NavigationView {
            TabView {
                Home().environmentObject(UserEnv()).tabItem {
                    Image(systemName: "house.fill")
                }
                
                Planning().environmentObject(UserEnv()).tabItem {
                    Image(systemName: "creditcard.fill")
                }
                
                Video().tabItem {
                    Image(systemName: "video.fill")
                }
                
                ProfileView().environmentObject(FirebaseEnv()).tabItem {
                    Image(systemName: "person.fill")
                }
                
            }
        }
    }
}

struct TabBarView_Previews: PreviewProvider {
    static var previews: some View {
        TabBarView()
    }
}
